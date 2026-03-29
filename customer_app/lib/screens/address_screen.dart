import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:user_app/screens/save_address_screen.dart';
import 'package:user_app/models/address.dart';
import 'package:user_app/widgets/address_design.dart';
import 'package:user_app/providers/address_provider.dart';
import 'package:user_app/widgets/progress_bar.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/widgets/unified_app_bar.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnifiedAppBar(
        title: "Address Manager",
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SaveAddressScreen()),
        ),
        label: const Text(
          "Add New Address",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add_location, size: 26, color: Colors.white),
      ),
      body: Consumer<AddressProvider>(
        builder: (context, addressProvider, _) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(currentUID)
                .collection("addresses")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: circularProgress());
              }

              final docs = snapshot.data!.docs;

              // Update total count for AddressProvider
              WidgetsBinding.instance.addPostFrameCallback((_) {
                addressProvider.setTotalSavedAddresses(docs.length);
              });

              //  Empty state
              if (docs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off_rounded,
                          size: 72,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "No addresses yet",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add a delivery address to start placing orders.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              //  Address list
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 100),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  return AddressDesign(
                    value: index,
                    addressID: doc.id,
                    model:
                        Address.fromJson(doc.data()! as Map<String, dynamic>),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
