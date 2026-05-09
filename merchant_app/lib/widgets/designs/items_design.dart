import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/methods/shared_methods.dart';
import 'package:merchant_app/models/items.dart';
import 'package:merchant_app/widgets/sheets/edit_sheet_components.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

class ItemsDesignWidget extends StatelessWidget {
  final Items? model;
  const ItemsDesignWidget({super.key, this.model});

  void _openEditSheet(BuildContext context) {
    if (model == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditItemSheet(item: model!),
    );
  }

  // Quick sold-out toggle — no sheet needed, updates Firestore directly
  Future<void> _toggleSoldOut(BuildContext context) async {
    if (model == null) return;
    final newValue = !(model!.isSoldOut ?? false);
    try {
      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(model!.restaurantID)
          .collection('menus')
          .doc(model!.menuID)
          .collection('items')
          .doc(model!.itemID)
          .update({'isSoldOut': newValue});
    } catch (e) {
      if (context.mounted) unifiedSnackBar(e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;
    final bool hasImage =
        model?.imageUrl != null && model!.imageUrl!.isNotEmpty;
    final bool isSoldOut = model?.isSoldOut ?? false;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _openEditSheet(context),
      child: Container(
        decoration: BoxDecoration(
          color: isSoldOut
              ? colorScheme.surface.withValues(alpha: 0.6)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSoldOut
                ? Colors.redAccent.withValues(alpha: 0.4)
                : colorScheme.outline,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Item image
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: hasImage
                      ? Image.network(
                          model!.imageUrl!,
                          fit: BoxFit.cover,
                          color: isSoldOut
                              ? Colors.black.withValues(alpha: 0.35)
                              : null,
                          colorBlendMode:
                              isSoldOut ? BlendMode.darken : null,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: brandColors.primary
                                  ?.withValues(alpha: 0.05),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded /
                                          progress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                  color: brandColors.primary,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) =>
                              customImagePlaceholder(context, brandColors),
                        )
                      : customImagePlaceholder(context, brandColors),
                ),

                // Sold-out overlay label
                if (isSoldOut)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'SOLD OUT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Discount badge
                if (model?.hasDiscount == true && !isSoldOut)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: brandColors.success,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${model!.discount!.toStringAsFixed(0)}%',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),

                // Likes badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite_rounded,
                            size: 18, color: Colors.redAccent),
                        const SizedBox(width: 4),
                        Text(
                          '${model?.likes ?? 0}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model?.title ?? 'Untitled Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isSoldOut ? brandColors.muted : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          model?.shortInfo ?? '',
                          style: TextStyle(
                              fontSize: 12, color: brandColors.muted),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (model?.hasDiscount == true) ...[
                              Text(
                                'PLN ${model!.price!.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: brandColors.muted,
                                  decoration: TextDecoration.lineThrough,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                            Text(
                              'PLN ${model?.discountedPrice.toStringAsFixed(2) ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isSoldOut
                                    ? brandColors.muted
                                    : model?.hasDiscount == true
                                        ? brandColors.success
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Action buttons column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          backgroundColor:
                              brandColors.muted!.withValues(alpha: 0.3),
                        ),
                        onPressed: () => _openEditSheet(context),
                        child: Row(children: [
                          Text(context.l10nCommon.edit,
                              style: TextStyle(
                                  color: brandColors.success,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Icon(Icons.change_circle,
                              color: brandColors.success),
                        ]),
                      ),
                      const SizedBox(height: 8),

                      // Sold-out quick toggle
                      GestureDetector(
                        onTap: () => _toggleSoldOut(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSoldOut
                                ? Colors.redAccent.withValues(alpha: 0.1)
                                : brandColors.success!
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSoldOut
                                  ? Colors.redAccent.withValues(alpha: 0.4)
                                  : brandColors.success!
                                      .withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isSoldOut
                                    ? Icons.remove_shopping_cart_rounded
                                    : Icons.shopping_cart_rounded,
                                size: 13,
                                color: isSoldOut
                                    ? Colors.redAccent
                                    : brandColors.success,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isSoldOut ? 'Sold Out' : 'In Stock',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: isSoldOut
                                      ? Colors.redAccent
                                      : brandColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Edit sheet ---------------------------------------------------------------

class _EditItemSheet extends StatefulWidget {
  final Items item;
  const _EditItemSheet({required this.item});

  @override
  State<_EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends State<_EditItemSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _shortInfoController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _discountController;
  late final TextEditingController _tagController;

  late List<String> _tags;
  late bool _hasDiscount;
  late bool _isSoldOut;
  Uint8List? _imageBytes;
  String? _imageFileName;
  bool _isLoading = false;
  String? _tagError;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title ?? '');
    _shortInfoController =
        TextEditingController(text: widget.item.shortInfo ?? '');
    _descriptionController =
        TextEditingController(text: widget.item.description ?? '');
    _priceController =
        TextEditingController(text: widget.item.price?.toString() ?? '');
    _discountController =
        TextEditingController(text: widget.item.discount?.toString() ?? '');
    _tagController = TextEditingController();
    _tags = List<String>.from(widget.item.tags ?? []);
    _hasDiscount = widget.item.hasDiscount;
    _isSoldOut = widget.item.isSoldOut ?? false;
    _priceController.addListener(() => setState(() {}));
    _discountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _shortInfoController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    String? validationResult;

    if (tag.isEmpty) {
      validationResult = context.l10nMerchant.items_tag_error_empty;
    } else if (!RegExp(r'^[A-Z]').hasMatch(tag)) {
      validationResult = context.l10nMerchant.items_tag_error_capitalize;
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(tag)) {
      validationResult = context.l10nMerchant.items_tag_error_letters;
    } else if (_tags.contains(tag)) {
      validationResult = context.l10nMerchant.items_tag_error_duplicate;
    }

    setState(() {
      _tagError = validationResult;
      if (validationResult == null) {
        _tags.add(tag);
        _tagController.clear();
      }
    });
  }

  void _removeTag(String tag) => setState(() => _tags.remove(tag));

  Future<void> _pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null && result.files.first.bytes != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _imageFileName = result.files.first.name;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      String finalImageUrl = widget.item.imageUrl ?? '';
      final String? oldUrl = widget.item.imageUrl;
      bool imageChanged = false;

      if (_imageBytes != null) {
        final String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_$_imageFileName';
        final ref = FirebaseStorage.instance
            .ref()
            .child('restaurants')
            .child(widget.item.restaurantID!)
            .child('menus')
            .child(widget.item.menuID!)
            .child('items')
            .child(fileName);

        await ref.putData(_imageBytes!);
        finalImageUrl = await ref.getDownloadURL();
        imageChanged = true;
      }

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.item.restaurantID)
          .collection('menus')
          .doc(widget.item.menuID)
          .collection('items')
          .doc(widget.item.itemID)
          .update({
        'title': _titleController.text.trim(),
        'shortInfo': _shortInfoController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': double.tryParse(_priceController.text.trim()) ?? 0.0,
        'discount': _hasDiscount
            ? (double.tryParse(_discountController.text.trim()) ?? 0.0)
            : 0.0,
        'isSoldOut': _isSoldOut,
        'tags': _tags,
        if (imageChanged) 'imageUrl': finalImageUrl,
      });

      if (imageChanged && oldUrl != null && oldUrl.isNotEmpty) {
        final String? errorMsg = await deleteOldFile(oldUrl);
        if (errorMsg != null && mounted) {
          unifiedSnackBar(context.l10nMerchant.image_cleanup_error,
              error: true);
        }
      }

      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final savedMsg = context.l10nCommon.successSaved;
      Navigator.pop(context);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Row(children: [
              const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(savedMsg,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ]),
            backgroundColor: const Color(0xFF1E293B),
            behavior: SnackBarBehavior.floating,
            elevation: 6,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
            dismissDirection: DismissDirection.horizontal,
          ),
        );
    } catch (e) {
      if (!mounted) return;
      unifiedSnackBar(e.toString(), error: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10nCommon.confirmDeleteTitle),
        content: Text(context.l10nCommon.confirmDeleteBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.l10nCommon.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.l10nCommon.confirm,
                style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;
    setState(() => _isLoading = true);

    final messenger = ScaffoldMessenger.of(context);

    try {
      if (widget.item.imageUrl != null && widget.item.imageUrl!.isNotEmpty) {
        await deleteOldFile(widget.item.imageUrl!);
      }

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.item.restaurantID)
          .collection('menus')
          .doc(widget.item.menuID)
          .collection('items')
          .doc(widget.item.itemID)
          .delete();

      if (!mounted) return;
      final deletedMsg = context.l10nCommon.successDeleted;
      Navigator.pop(context);
      messenger
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Row(children: [
              const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(deletedMsg,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ]),
            backgroundColor: const Color(0xFF1E293B),
            behavior: SnackBarBehavior.floating,
            elevation: 6,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
            dismissDirection: DismissDirection.horizontal,
          ),
        );
    } catch (e) {
      if (!mounted) return;
      unifiedSnackBar(e.toString(), error: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(28, 24, 28, 28 + keyboardHeight),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10nMerchant.edit_sheet_title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.pink.withValues(alpha: 0.3)),
                        onPressed: _isLoading ? null : _delete,
                        child: Row(children: [
                          Text(context.l10nCommon.delete,
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          const Icon(Icons.delete_rounded,
                              color: Colors.redAccent),
                        ]),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close_rounded,
                            color: brandColors.muted),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _imageBytes != null
                          ? brandColors.primary!
                          : colorScheme.outline,
                      width: _imageBytes != null ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _imageBytes != null
                      ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                      : widget.item.imageUrl != null &&
                              widget.item.imageUrl!.isNotEmpty
                          ? Image.network(widget.item.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  customImagePlaceholder(context, brandColors))
                          : customImagePlaceholder(context, brandColors),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(context.l10nCommon.changeImage,
                    style:
                        TextStyle(fontSize: 11, color: brandColors.muted)),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _titleController,
                decoration: customInputDecoration(
                    label: context
                        .l10nMerchant.items_design_field_title_label,
                    colorScheme: colorScheme,
                    brandColors: brandColors),
                validator: (v) => v == null || v.trim().isEmpty
                    ? context.l10nMerchant.items_field_title_required
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _shortInfoController,
                decoration: customInputDecoration(
                    label: context
                        .l10nMerchant.items_design_field_info_label,
                    hint: context
                        .l10nMerchant.items_design_field_info_hint,
                    colorScheme: colorScheme,
                    brandColors: brandColors),
                validator: (v) => v == null || v.trim().isEmpty
                    ? context.l10nMerchant.items_field_info_required
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: customInputDecoration(
                    label: context
                        .l10nMerchant.items_design_field_desc_label,
                    colorScheme: colorScheme,
                    brandColors: brandColors),
                validator: (v) => v == null || v.trim().isEmpty
                    ? context.l10nMerchant.items_field_desc_required
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: customInputDecoration(
                    label: context
                        .l10nMerchant.items_design_field_price_label,
                    prefixText: 'PLN ',
                    colorScheme: colorScheme,
                    brandColors: brandColors),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return context
                        .l10nMerchant.items_design_field_price_required;
                  }
                  if (double.tryParse(v.trim()) == null) {
                    return context
                        .l10nMerchant.items_design_field_price_invalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tags
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tagController,
                      decoration: customInputDecoration(
                        label: context
                            .l10nMerchant.items_design_field_tags_label,
                        hint: context
                            .l10nMerchant.items_design_field_tags_hint,
                        colorScheme: colorScheme,
                        brandColors: brandColors,
                        errorText: _tagError,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]')),
                      ],
                      onChanged: (_) {
                        if (_tagError != null) {
                          setState(() => _tagError = null);
                        }
                      },
                      onFieldSubmitted: (_) => _addTag(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _addTag,
                    style: IconButton.styleFrom(
                      backgroundColor: brandColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              if (_tags.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _tags
                      .map((tag) => Chip(
                            label: Text(tag,
                                style: const TextStyle(fontSize: 12)),
                            deleteIcon:
                                const Icon(Icons.close_rounded, size: 14),
                            onDeleted: () => _removeTag(tag),
                            backgroundColor: brandColors.primary
                                ?.withValues(alpha: 0.1),
                            side: BorderSide(
                                color: brandColors.primary
                                        ?.withValues(alpha: 0.3) ??
                                    Colors.transparent),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                          ))
                      .toList(),
                ),
              ],
              const SizedBox(height: 16),

              // ── Sold-out toggle ───────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: _isSoldOut
                      ? Colors.redAccent.withValues(alpha: 0.06)
                      : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isSoldOut
                        ? Colors.redAccent.withValues(alpha: 0.4)
                        : colorScheme.outline,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => setState(() => _isSoldOut = !_isSoldOut),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          _isSoldOut
                              ? Icons.remove_shopping_cart_rounded
                              : Icons.shopping_cart_rounded,
                          size: 18,
                          color: _isSoldOut
                              ? Colors.redAccent
                              : brandColors.muted,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sold Out',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _isSoldOut
                                      ? Colors.redAccent
                                      : brandColors.muted,
                                ),
                              ),
                              Text(
                                _isSoldOut
                                    ? 'Item is hidden from customers'
                                    : 'Item is available to order',
                                style: TextStyle(
                                    fontSize: 11, color: brandColors.muted),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _isSoldOut,
                          activeColor: Colors.redAccent,
                          onChanged: (v) =>
                              setState(() => _isSoldOut = v),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Discount toggle
              Container(
                decoration: BoxDecoration(
                  color: _hasDiscount
                      ? brandColors.success?.withValues(alpha: 0.08)
                      : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _hasDiscount
                        ? brandColors.success?.withValues(alpha: 0.4) ??
                            colorScheme.outline
                        : colorScheme.outline,
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () =>
                          setState(() => _hasDiscount = !_hasDiscount),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(Icons.local_offer_rounded,
                                size: 18,
                                color: _hasDiscount
                                    ? brandColors.success
                                    : brandColors.muted),
                            const SizedBox(width: 10),
                            Text(
                                context
                                    .l10nMerchant.items_discount_toggle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _hasDiscount
                                      ? brandColors.success
                                      : brandColors.muted,
                                )),
                            const Spacer(),
                            Checkbox(
                              value: _hasDiscount,
                              onChanged: (v) => setState(
                                  () => _hasDiscount = v ?? false),
                              activeColor: brandColors.success,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_hasDiscount) ...[
                      Divider(
                          height: 1,
                          color: brandColors.success
                              ?.withValues(alpha: 0.2)),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: TextFormField(
                          controller: _discountController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true),
                          decoration: InputDecoration(
                            labelText: context.l10nMerchant
                                .items_design_discount_label,
                            suffixText: '%',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          validator: (v) {
                            if (!_hasDiscount) return null;
                            if (v == null || v.trim().isEmpty) {
                              return context.l10nMerchant
                                  .items_design_discount_required;
                            }
                            final val = double.tryParse(v.trim());
                            if (val == null || val <= 0 || val > 100) {
                              return context.l10nMerchant
                                  .items_design_discount_invalid;
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_priceController.text.isNotEmpty &&
                          _discountController.text.isNotEmpty &&
                          double.tryParse(_priceController.text) !=
                              null &&
                          double.tryParse(_discountController.text) !=
                              null)
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: Row(
                            children: [
                              Text(
                                'PLN ${(double.parse(_priceController.text) * (1 - double.parse(_discountController.text) / 100)).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: brandColors.success),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'PLN ${double.parse(_priceController.text).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: brandColors.muted,
                                    decoration:
                                        TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text(context.l10nMerchant.items_design_saved,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}