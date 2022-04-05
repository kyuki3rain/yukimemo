import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yukimemo/auth_controller.dart';

class SettingModel extends ChangeNotifier {
  final Reader _read;
  String fontSize = "Medium";
  List<bool> isSelected = [false, true, false];
  final users = FirebaseFirestore.instance.collection('users');
  DateTime listUpdated = DateTime.now();

  SettingModel(this._read);

  TextStyle getBodyFont() {
    switch (fontSize) {
      case "Small":
        return const TextStyle(fontSize: 12.0);
      case "Medium":
        return const TextStyle(fontSize: 18.0);
      case "Large":
        return const TextStyle(fontSize: 24.0);
      default:
        return const TextStyle(fontSize: 18.0);
    }
  }

  TextStyle getLabelFont() {
    switch (fontSize) {
      case "Small":
        return const TextStyle(fontSize: 14.0);
      case "Medium":
        return const TextStyle(fontSize: 21.0);
      case "Large":
        return const TextStyle(fontSize: 28.0);
      default:
        return const TextStyle(fontSize: 21.0);
    }
  }

  TextStyle getTitleFont() {
    switch (fontSize) {
      case "Small":
        return const TextStyle(fontSize: 16.0);
      case "Medium":
        return const TextStyle(fontSize: 24.0);
      case "Large":
        return const TextStyle(fontSize: 32.0);
      default:
        return const TextStyle(fontSize: 24.0);
    }
  }

  String getFontSize() {
    if (isSelected[0] == true) {
      return "Small";
    }
    if (isSelected[1] == true) {
      return "Medium";
    }
    if (isSelected[2] == true) {
      return "Large";
    }

    return "Medium";
  }

  List<bool> getIsSelected(String fontSize) {
    switch (fontSize) {
      case "Small":
        return [true, false, false];
      case "Medium":
        return [false, true, false];
      case "Large":
        return [false, false, true];
      default:
        return [false, true, false];
    }
  }

  Future<void> fetchItems() async {
    // if (listUpdated.difference(DateTime.now()).inSeconds < 5) return;

    print("firestore use fetch.");
    User? user = _read(authControllerProvider);
    DocumentSnapshot snapshot = await users.doc(user?.uid).get();
    Object? data = snapshot.data();
    if (data != null) {
      final map = data as Map;
      if (map.containsKey("fontSize")) {
        fontSize = map["fontSize"];
        isSelected = getIsSelected(fontSize);
        fontSize = getFontSize();

        notifyListeners();
      }
    }
  }

  void update(int index) {
    isSelected = [false, false, false];
    isSelected[index] = true;
    fontSize = getFontSize();

    print("firestore use update.");
    User? user = _read(authControllerProvider);
    users.doc(user!.uid).set({'fontSize': fontSize});

    notifyListeners();
  }
}

final settingProvider = ChangeNotifierProvider((ref) => SettingModel(ref.read));
