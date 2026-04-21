import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/methods/shared_methods.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';
  String? _roleFilter;

  List<({String label, String? value})> _roleOptions(BuildContext context) => [
        (label: context.l10nCommon.all, value: null),
        (label: context.l10nCommon.restaurants, value: 'restaurants'),
        (label: context.l10nCommon.role_admin, value: 'admin'),
        (label: context.l10nCommon.customers, value: 'customer'),
      ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() =>
        setState(() => _search = _searchController.text.trim().toLowerCase()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border(bottom: BorderSide(color: scheme.outline)),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(fontSize: 13, color: scheme.onSurface),
                    decoration: InputDecoration(
                      hintText: context.l10nMerchant.users_search_hint,
                      hintStyle: TextStyle(fontSize: 13, color: brand.muted),
                      prefixIcon: Icon(Icons.search_rounded,
                          size: 18, color: brand.muted),
                      suffixIcon: _search.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.close_rounded,
                                  size: 16, color: brand.muted),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _search = '');
                              },
                            )
                          : null,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: scheme.surfaceBright,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: scheme.outline)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: scheme.outline)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: brand.danger!)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _roleOptions(context).map((opt) {
                    final selected = _roleFilter == opt.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _roleFilter = opt.value),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? brand.danger!.withValues(alpha: 0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? brand.danger!.withValues(alpha: 0.5)
                                  : scheme.outline,
                            ),
                          ),
                          child: Text(
                            opt.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w400,
                              color: selected ? brand.danger : brand.muted,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseAuth.instance.currentUser == null
                ? const Stream.empty()
                : FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline_rounded,
                            size: 40, color: brand.danger),
                        const SizedBox(height: 12),
                        Text(
                          snap.error.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 12, color: scheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (!snap.hasData) {
                return Center(
                    child: CircularProgressIndicator(color: brand.primary));
              }

              var docs = snap.data!.docs.toList()
                ..sort((a, b) {
                  final aRaw = (a.data() as Map<String, dynamic>)['createdAt'];
                  final bRaw = (b.data() as Map<String, dynamic>)['createdAt'];
                  DateTime? aDate;
                  DateTime? bDate;
                  if (aRaw is Timestamp) aDate = aRaw.toDate();
                  if (bRaw is Timestamp) bDate = bRaw.toDate();
                  if (aRaw is DateTime) aDate = aRaw;
                  if (bRaw is DateTime) bDate = bRaw;
                  if (aDate == null && bDate == null) return 0;
                  if (aDate == null) return 1;
                  if (bDate == null) return -1;
                  return bDate.compareTo(aDate);
                });

              if (_roleFilter != null) {
                docs = docs
                    .where((d) =>
                        (d.data() as Map<String, dynamic>)['role']
                            ?.toString() ==
                        _roleFilter)
                    .toList();
              }

              if (_search.isNotEmpty) {
                docs = docs.where((d) {
                  final data = d.data() as Map<String, dynamic>;
                  final name = (data['name'] ?? '').toString().toLowerCase();
                  final email = (data['email'] ?? '').toString().toLowerCase();
                  return name.contains(_search) || email.contains(_search);
                }).toList();
              }

              if (docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_search_rounded,
                          size: 40, color: brand.muted),
                      const SizedBox(height: 12),
                      Text(
                        _search.isNotEmpty || _roleFilter != null
                            ? context.l10nMerchant.users_empty_filtered
                            : context.l10nMerchant.users_empty_all,
                        style: TextStyle(fontSize: 14, color: brand.muted),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: docs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final doc = docs[i];
                  return _UserCard(
                    uid: doc.id,
                    data: doc.data() as Map<String, dynamic>,
                    brand: brand,
                    scheme: scheme,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// -- User card -----------------------------------------------------------------

class _UserCard extends StatelessWidget {
  final String uid;
  final Map<String, dynamic> data;
  final BrandColors brand;
  final ColorScheme scheme;

  const _UserCard({
    required this.uid,
    required this.data,
    required this.brand,
    required this.scheme,
  });

  void _openDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _UserDetailSheet(uid: uid, data: data, brand: brand, scheme: scheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name = data['name']?.toString() ?? 'Unknown';
    final String email = data['email']?.toString() ?? '—';
    final String role = data['role']?.toString() ?? 'customer';
    final bool banned = data['banned'] == true;
    final String? photoUrl = (data['photoUrl'] as String?)?.isNotEmpty == true
        ? data['photoUrl'] as String
        : null;
    final Timestamp? ts = data['createdAt'] as Timestamp?;
    final String joined =
        ts != null ? dateTimeToString(context, ts.toDate()) : '—';
    final _RoleStyle rs = _roleStyle(role, context, brand);

    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                banned ? brand.danger!.withValues(alpha: 0.35) : scheme.outline,
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: brand.primary!.withValues(alpha: 0.1),
                  backgroundImage:
                      photoUrl != null ? NetworkImage(photoUrl) : null,
                  child: photoUrl == null
                      ? Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: brand.primary),
                        )
                      : null,
                ),
                if (banned)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: brand.danger, shape: BoxShape.circle),
                      child: const Icon(Icons.block_rounded,
                          size: 9, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (banned) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: brand.danger!.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: brand.danger!.withValues(alpha: 0.3)),
                          ),
                          child: Text(context.l10nCommon.users,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: brand.danger)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(email,
                      style: TextStyle(fontSize: 12, color: brand.muted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: rs.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: rs.color.withValues(alpha: 0.3)),
                        ),
                        child: Text(rs.label,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: rs.color)),
                      ),
                      const SizedBox(width: 8),
                      Text(context.l10nMerchant.users_joined(joined),
                          style: TextStyle(fontSize: 11, color: brand.muted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, size: 20, color: brand.muted),
          ],
        ),
      ),
    );
  }
}

// -- User detail sheet ---------------------------------------------------------

class _UserDetailSheet extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> data;
  final BrandColors brand;
  final ColorScheme scheme;

  const _UserDetailSheet({
    required this.uid,
    required this.data,
    required this.brand,
    required this.scheme,
  });

  @override
  State<_UserDetailSheet> createState() => _UserDetailSheetState();
}

class _UserDetailSheetState extends State<_UserDetailSheet> {
  bool _loading = false;

  Future<void> _toggleBan() async {
    final bool currentlyBanned = widget.data['banned'] == true;
    final String action =
        currentlyBanned ? context.l10nCommon.unban : context.l10nCommon.ban;
    final String detail = currentlyBanned
        ? context.l10nMerchant.users_unban_body
        : context.l10nMerchant.users_ban_body;

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: widget.scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('$action User?',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Text(detail,
            style: TextStyle(fontSize: 13, color: widget.brand.muted)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10nCommon.cancel)),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  currentlyBanned ? widget.brand.success : widget.brand.danger,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(action),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    setState(() => _loading = true);

    final messenger = ScaffoldMessenger.of(context);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({'banned': !currentlyBanned});

      if (!mounted) return;
      Navigator.pop(context);
      messenger
        ..clearSnackBars()
        ..showSnackBar(_successSnack(currentlyBanned
            ? context.l10nMerchant.users_snack_unbanned
            : context.l10nMerchant.users_snack_banned));
    } catch (e) {
      if (!mounted) return;
      messenger
        ..clearSnackBars()
        ..showSnackBar(_errorSnack(e.toString()));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _deleteUser() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: widget.scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(context.l10nMerchant.users_delete_title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Text(context.l10nMerchant.users_delete_body,
            style: TextStyle(fontSize: 13, color: widget.brand.muted)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.l10nCommon.cancel)),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.brand.danger,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(context.l10nMerchant.users_delete_title),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    setState(() => _loading = true);

    final messenger = ScaffoldMessenger.of(context);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .delete();

      if (!mounted) return;
      Navigator.pop(context);
      messenger
        ..clearSnackBars()
        ..showSnackBar(_successSnack(context.l10nMerchant.users_snack_deleted));
    } catch (e) {
      if (!mounted) return;
      messenger
        ..clearSnackBars()
        ..showSnackBar(_errorSnack(e.toString()));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final String name = data['name']?.toString() ?? 'Unknown';
    final String email = data['email']?.toString() ?? '—';
    final String phone = data['phone']?.toString() ?? '—';
    final String role = data['role']?.toString() ?? 'customer';
    final bool banned = data['banned'] == true;
    final String? photoUrl = (data['photoUrl'] as String?)?.isNotEmpty == true
        ? data['photoUrl'] as String
        : null;
    final Timestamp? ts = data['createdAt'] as Timestamp?;
    final String joined =
        ts != null ? dateTimeToString(context, ts.toDate()) : '—';
    final _RoleStyle rs = _roleStyle(role, context, widget.brand);

    return Container(
      decoration: BoxDecoration(
        color: widget.scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
          28, 24, 28, 28 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(context.l10nMerchant.users_detail_title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: widget.scheme.onSurface)),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, color: widget.brand.muted),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: widget.brand.primary!.withValues(alpha: 0.1),
                  backgroundImage:
                      photoUrl != null ? NetworkImage(photoUrl) : null,
                  child: photoUrl == null
                      ? Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: widget.brand.primary),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: widget.scheme.onSurface)),
                      const SizedBox(height: 2),
                      Text(email,
                          style: TextStyle(
                              fontSize: 13, color: widget.brand.muted)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: rs.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: rs.color.withValues(alpha: 0.3)),
                            ),
                            child: Text(rs.label,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: rs.color)),
                          ),
                          if (banned) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color:
                                    widget.brand.danger!.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: widget.brand.danger!
                                        .withValues(alpha: 0.3)),
                              ),
                              child: Text(context.l10nMerchant.users_ban_body,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: widget.brand.danger)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(color: widget.scheme.outline),
            const SizedBox(height: 16),
            _DetailRow(
                label: context.l10nMerchant.users_detail_id,
                value: widget.uid,
                copyable: true,
                brand: widget.brand),
            _DetailRow(
                label: context.l10nMerchant.users_detail_phone,
                value: phone,
                brand: widget.brand),
            _DetailRow(
                label: context.l10nMerchant.users_detail_joined,
                value: joined,
                brand: widget.brand),
            _DetailRow(
                label: context.l10nMerchant.users_detail_role,
                value: role,
                brand: widget.brand),
            const SizedBox(height: 24),
            if (_loading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(color: widget.brand.primary),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _toggleBan,
                      icon: Icon(
                        banned ? Icons.lock_open_rounded : Icons.block_rounded,
                        size: 16,
                      ),
                      label: Text(banned
                          ? context.l10nCommon.unban
                          : context.l10nCommon.ban),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            banned ? widget.brand.success : widget.brand.danger,
                        side: BorderSide(
                            color: banned
                                ? widget.brand.success!
                                : widget.brand.danger!),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _deleteUser,
                      icon: const Icon(Icons.delete_outline_rounded, size: 16),
                      label: Text(context.l10nMerchant.users_delete_title),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.brand.danger,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  SnackBar _successSnack(String msg) => SnackBar(
        content: Row(children: [
          const Icon(Icons.check_circle_outline_rounded,
              color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Text(msg,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ]),
        backgroundColor: widget.brand.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      );

  SnackBar _errorSnack(String msg) => SnackBar(
        content: Row(children: [
          const Icon(Icons.error_outline_rounded,
              color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
              child: Text(msg,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500))),
        ]),
        backgroundColor: widget.brand.danger,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
      );
}

// -- Detail row ----------------------------------------------------------------

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool copyable;
  final BrandColors brand;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.brand,
    this.copyable = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child:
                Text(label, style: TextStyle(fontSize: 12, color: brand.muted)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurface),
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(context.l10nMerchant.requests_copied("Given ID")),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              child: Icon(Icons.copy_rounded, size: 15, color: brand.muted),
            ),
        ],
      ),
    );
  }
}

// -- Helpers -------------------------------------------------------------------

class _RoleStyle {
  final String label;
  final Color color;
  const _RoleStyle(this.label, this.color);
}

_RoleStyle _roleStyle(String role, BuildContext context, BrandColors brand) {
  switch (role) {
    case 'admin':
      return _RoleStyle(context.l10nCommon.role_admin, brand.danger!);
    case 'restaurant':
      return _RoleStyle(
          context.l10nCommon.role_restaurant, const Color(0xFF8B5CF6));
    case 'customer':
      return _RoleStyle(context.l10nCommon.role_customer, brand.primary!);
    default:
      return _RoleStyle(role, brand.muted!);
  }
}
