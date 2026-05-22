import 'dart:convert';
import 'package:credit_management/types/bank.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataMigrationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool?> migrationRun() async {
    try {
      final String readData = await rootBundle.loadString(
        'assets/data/bank_data.json',
      );
      final List<dynamic> data = jsonDecode(readData);
      for (var item in data) {
        Bank bank = Bank.fromJson(item);
        final document = _db.collection('banks').doc(bank.id);
        document.set(bank.toMap());
      }
      return true;
    } catch (e) {
      throw ("error migration: $e");
    }
  }
}
