import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class TestFunctionsSheet extends StatefulWidget {
  const TestFunctionsSheet({super.key});

  @override
  State<TestFunctionsSheet> createState() => _TestFunctionsSheetState();
}

class _TestFunctionsSheetState extends State<TestFunctionsSheet> {
  final FirebaseFunctions _functions =
      FirebaseFunctions.instanceFor(region: 'europe-west1');
  
  bool _isRunning = false;
  String _log = '';

  @override
  void initState() {
    super.initState();
    _functions.useFunctionsEmulator('localhost', 5001);
  }

  void _appendLog(String text) {
    setState(() {
      _log += "$text\n";
    });
  }

  Future<String> _createTestQuote() async {
    final ref = FirebaseFirestore.instance.collection("quotes").doc();

    await ref.set({
      "userID": "testUser",
      "restaurantID": "test_restaurant",
      "restaurantName": "Test Restaurant",
      "itemIDs": ["item1"],
      "orderType": "delivery",
      "itemsTotal": 10.0,
      "deliveryFee": 5.0,
      "finalTotal": 15.0,
      "status": "PENDING",
      "addressID": "TEST_ADDRESS",
      "createdAt": FieldValue.serverTimestamp(),
    });

    return ref.id;
  }

  Future<void> _testCash() async {
    _appendLog("CASH TEST START");

    final quoteID = await _createTestQuote();

    final res = await _functions
        .httpsCallable('placeOrder')
        .call({'quoteID': quoteID});

    _appendLog("CASH RESULT: ${res.data}");
  }

  Future<void> _testStripe() async {
    _appendLog("STRIPE TEST START");

    final quoteID = await _createTestQuote();

    final res = await _functions
        .httpsCallable('createPaymentIntent')
        .call({'quoteID': quoteID});

    _appendLog("STRIPE RESULT: ${res.data}");
  }

  Future<void> _testInvalidQuote() async {
    _appendLog("INVALID TEST START");

    try {
      await _functions
          .httpsCallable('placeOrder')
          .call({'quoteID': 'INVALID_ID'});
    } catch (e) {
      _appendLog("ERROR: $e");
    }
  }

  late final List<_TestAction> _actions = [
    _TestAction(
      label: "Test Cash Order",
      color: Colors.green,
      action: _testCash,
    ),
    _TestAction(
      label: "Test Stripe Intent",
      color: Colors.blue,
      action: _testStripe,
    ),
    _TestAction(
      label: "Test Invalid Quote",
      color: Colors.red,
      action: _testInvalidQuote,
    ),
  ];

  Future<void> _runTest(Future<void> Function() fn) async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _log = '';
    });

    try {
      await fn();
    } catch (e) {
      _appendLog("ERROR: $e");
    }

    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Text(
            "Cloud Functions Tester",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._actions.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRunning ? null : () => _runTest(a.action),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: a.color,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(a.label),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _log.isEmpty ? "Logs will appear here..." : _log,
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestAction {
  final String label;
  final Color color;
  final Future<void> Function() action;

  _TestAction({
    required this.label,
    required this.color,
    required this.action,
  });
}