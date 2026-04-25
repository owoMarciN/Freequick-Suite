import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/screens/users/notifications_screen.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  int _previousUnread = 0;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.12, end: -0.12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.12, end: 0.12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.12, end: -0.12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.12, end: 0.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  bool _shouldCount(Map<String, dynamic> data) {
    final source = data['source']?.toString() ?? 'welcome';
    return switch (source) {
      'order' => getUserPref<bool>('notif_order_status') ?? true,
      'admin' => getUserPref<bool>('notif_promotions') ?? true,
      'nearby' => getUserPref<bool>('notif_nearby') ?? true,
      'news' => getUserPref<bool>('notif_app_news') ?? true,
      _ => true,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (currentUID == null) return const SizedBox.shrink();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUID)
          .collection('notifications')
          .where('isRead', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        final unreadDocs = snapshot.data?.docs ?? [];

        final unreadCount = unreadDocs
            .where((doc) => _shouldCount(doc.data() as Map<String, dynamic>))
            .length;

        if (unreadCount > _previousUnread) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _shakeController.forward(from: 0);
          });
        }
        _previousUnread = unreadCount;

        return AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) => Transform.rotate(
            angle: _shakeAnimation.value,
            child: child,
          ),
          child: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
            icon: Badge(
              isLabelVisible: unreadCount > 0,
              label: Text(unreadCount > 99 ? '99+' : '$unreadCount'),
              backgroundColor: Colors.red,
              padding: EdgeInsets.zero,
              child: const Icon(
                Icons.notifications_rounded,
                color: Colors.white,
                size: 28,
                shadows: [
                  Shadow(
                    color: Color(0x66000000),
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}