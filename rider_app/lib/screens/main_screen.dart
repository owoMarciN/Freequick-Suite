import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_assets/methods/shared_methods.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/screens/home_screen.dart';
import 'package:rider_app/screens/profile_screen.dart';
import 'package:shared_assets/extensions/extensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const ProfileScreen()];

  void _confirmSignOut(BuildContext context) {
    final riderProvider = Provider.of<RiderProvider>(context, listen: false);

    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            context.l10nCommon.signOut,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        content: Text(context.l10nCommon.questionAppExit),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  context.l10nCommon.cancel,
                  style: TextStyle(color: brand.primaryDark),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  riderProvider.signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brand.danger,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.l10nCommon.confirm,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<RiderProvider>(context);

    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.surface,
        centerTitle: false,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            // Icon / Avatar
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: brand.primary!.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.delivery_dining,
                color: brand.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            // Name, Phone & Status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    riderProvider.rider?.name ??
                        context.l10nRider.defaultRiderName,
                    style: TextStyle(
                      color: brand.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    formatPhoneNumber(context, riderProvider.rider?.phone),
                    style: TextStyle(
                      color: brand.primaryDark!.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: riderProvider.isOnline
                              ? brand.success
                              : brand.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        riderProvider.isOnline
                            ? context.l10nRider.online
                            : context.l10nRider.offline,
                        style: TextStyle(
                          color: riderProvider.isOnline
                              ? brand.success
                              : brand.danger,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _confirmSignOut(context),
            icon: Icon(Icons.logout_rounded, size: 24, color: brand.danger),
            label: Text(
              context.l10nCommon.signOut,
              style: TextStyle(
                color: brand.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(
                0,
                -1,
              ), // Negative Y offset pushes the shadow upwards
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: brand.primary,
          unselectedItemColor: brand.primaryDark,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: context.l10nCommon.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: context.l10nCommon.profile,
            ),
          ],
        ),
      ),
    );
  }
}
