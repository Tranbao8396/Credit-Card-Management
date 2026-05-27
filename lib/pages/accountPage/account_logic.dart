import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_management/pages/accountPage/account_state.dart';
import 'package:credit_management/services/authentication_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountLogic extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final currentUser = AuthenticationService.instance.userInfo;
  final state = AccountState();

  Future<void> validate() async {
    if (state.password != null && state.password!.length < 6) {
      state.isValid = false;
      notifyListeners();
      return;
    }

    state.isValid = true;
    notifyListeners();
  }

  Future<void> setName(String? name) async {
    state.name = name;
    notifyListeners();
  }

  Future<void> setPassword(String? password) async {
    state.password = password;
    notifyListeners();
  }

  Future<void> updateInfo(BuildContext context) async {
    await validate();
    if (state.isValid == false) return;
    try {
      if (state.name != null) {
        await currentUser!.updateDisplayName(state.name);
        await _db.collection('users').doc(currentUser!.uid).update({
          'name': state.name,
        });
      }
      if (state.password != null) await currentUser!.updatePassword(state.password!);

      state.password = null;
      state.name = null;
      if (!context.mounted) return;
      Navigator.of(context).pop(true);
      notifyListeners();
    } catch (e) {
      throw ("error: $e");
    }
  }
}
