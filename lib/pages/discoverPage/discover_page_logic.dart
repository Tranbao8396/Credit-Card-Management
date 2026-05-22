import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/pages/discoverPage/discover_state.dart';
import 'package:credit_management/types/bank.dart';
import 'package:flutter/material.dart';

class DiscoverPageLogic extends ChangeNotifier {
  final DiscoverState state = DiscoverState();
  final _db = FirebaseFirestore.instance;

  DiscoverPageLogic() {
    getUSerBanksList();
  }

  Future<void> getUSerBanksList() async {
    try {
      final res = await _db.collection('banks').get();
      state.bankList = res.docs.map<Bank>((e) {
        final data = e.data();
        return Bank(
          bankName: data['bank_name'],
          bankUrl: data['bank_url']
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      throw("Error: $e");
    }
  }
}