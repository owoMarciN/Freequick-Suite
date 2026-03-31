import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider_app/services/auth_service.dart';
import 'package:rider_app/services/rider_service.dart';
import 'package:rider_app/models/dispatch_model.dart';
import 'package:rider_app/models/rider_model.dart';



enum RiderAppState { loading, unauthenticated, needsProfile, idle, onJob }

class RiderProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final RiderService _service = RiderService();

  RiderAppState _appState = RiderAppState.loading;
  RiderModel? _rider;
  Map<String, dynamic>? _activeOrder;
  DispatchJob? _pendingJob;
  bool _isOnline = false;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription? _riderSub;
  StreamSubscription? _orderSub;
  StreamSubscription? _jobsSub;

  RiderAppState get appState => _appState;
  RiderModel? get rider => _rider;
  Map<String, dynamic>? get activeOrder => _activeOrder;
  DispatchJob? get pendingJob => _pendingJob;
  bool get isOnline => _isOnline;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void init() {
    _auth.authStateChanges.listen((User? user) async {
      if (user == null) {
        _cleanup();
        _appState = RiderAppState.unauthenticated;
        notifyListeners();
      } else {
        await _setupRiderStream(user.uid);
      }
    });
  }

  Future<void> _setupRiderStream(String uid) async {
    _appState = RiderAppState.loading;
    notifyListeners();

    _riderSub?.cancel();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.getIdToken(true);
      }
  
      final doc = await FirebaseFirestore.instance.collection('riders').doc(uid).get();

      if (!doc.exists) {
        _appState = RiderAppState.needsProfile;
        notifyListeners();
        return;
      }

      _rider = RiderModel.fromDoc(doc);
      _isOnline = _rider!.isOnline;

      if (_rider!.hasActiveOrder && _rider!.currentOrderID != null) {
        _appState = RiderAppState.onJob;
        _subscribeToOrder(_rider!.currentOrderID!);
      } else {
        _appState = RiderAppState.idle;
        _subscribeToJobs(uid);
      }

      notifyListeners();

      _riderSub = _service.streamRider(uid).listen((snap) {
        if (!snap.exists) return;

        _rider = RiderModel.fromDoc(snap);
        _isOnline = _rider!.isOnline;

        if (_rider!.hasActiveOrder && _rider!.currentOrderID != null) {
          if (_appState != RiderAppState.onJob) {
            _appState = RiderAppState.onJob;
            _subscribeToOrder(_rider!.currentOrderID!);
            _jobsSub?.cancel();
            _pendingJob = null;
          }
        } else {
          if (_appState != RiderAppState.idle) {
            _appState = RiderAppState.idle;
            _activeOrder = null;
            _orderSub?.cancel();
            _subscribeToJobs(uid);
          }
        }

        notifyListeners();
      });
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        _errorMessage = "Syncing security permissions... please wait.";
        notifyListeners();
        // Retry once after a short delay
        await Future.delayed(const Duration(seconds: 1));
        return _setupRiderStream(uid); 
      }
      _errorMessage = "Firestore Error: ${e.message}";
      notifyListeners();
    }
  }

  void _subscribeToJobs(String riderUID) {
    _jobsSub?.cancel();

    _jobsSub = FirebaseFirestore.instance
        .collection("dispatch_jobs")
        .where("status", isEqualTo: "pending")
        .where("riderUID", isEqualTo: riderUID)
        .limit(1)
        .snapshots()
        .listen((snap) {
      if (snap.docs.isEmpty) {
        _pendingJob = null;
      } else {
        final doc = snap.docs.first;
        final data = doc.data();
        if (data['riderUID'] == null || data['riderUID'] == riderUID) {
          _pendingJob = DispatchJob.fromDoc(doc);
        } else {
          _pendingJob = null;
        }
      }
      notifyListeners();
    }, onError: (e) {
      _errorMessage = 'Stream Error: $e';
      notifyListeners();
    });
  }

  void _subscribeToOrder(String orderID) {
    _orderSub?.cancel();
    _orderSub = _service.streamOrder(orderID).listen((snap) {
      if (snap.exists) {
        _activeOrder = snap.data() as Map<String, dynamic>?;
        _activeOrder?['orderID'] = snap.id;
        notifyListeners();
      }
    });
  }

  Future<void> toggleOnline() async {
    if (_rider == null) return;
    _setLoading(true);
    try {
      await _service.setOnlineStatus(_rider!.uid, !_isOnline);
    } catch (e) {
      _errorMessage = 'Could not update status';
    }
    _setLoading(false);
  }

  Future<void> acceptJob(String jobID) async {
    if (_rider == null) return;
    _setLoading(true);
    try {
      await _service.acceptJob(jobID, _rider!.uid);
      _pendingJob = null;
    } catch (e) {
      _errorMessage = 'Failed to accept job: $e';
      _setLoading(false);
    }
  }

  Future<void> rejectJob(String jobID) async {
    _pendingJob = null;
    notifyListeners();
    await _service.rejectJob(jobID);
  }

  Future<void> updateOrderStatus(String orderID, String newStatus) async {
    if (_rider == null) return;
    _setLoading(true);
    try {
      await _service.updateOrderStatus(orderID, newStatus);
      if (newStatus == 'Delivered') {
        _activeOrder = null;
        _orderSub?.cancel();
      }
    } catch (e) {
      _errorMessage = 'Failed to update order: $e';
    }
    _setLoading(false);
  }

  Future<void> reloadToHome() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    _appState = RiderAppState.loading;
    notifyListeners(); // forces UI to show splash

    // load the rider document once
    final doc = await FirebaseFirestore.instance.collection('riders').doc(uid).get();
    if (!doc.exists) {
      _appState = RiderAppState.needsProfile;
    } else {
      _rider = RiderModel.fromDoc(doc);
      _isOnline = _rider!.isOnline;
      _appState = RiderAppState.idle;
      _subscribeToJobs(uid); // optional, start job listener
    }

    notifyListeners(); // forces UI rebuild immediately
  }

  Future<void> reload() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _setupRiderStream(uid);
  }

  Future<void> signOut() async {
    _cleanup();
    await _auth.signOut();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _cleanup() {
    _riderSub?.cancel();
    _orderSub?.cancel();
    _jobsSub?.cancel();
    _rider = null;
    _activeOrder = null;
    _pendingJob = null;
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }
}
