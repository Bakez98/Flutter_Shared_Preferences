import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myProvider extends ChangeNotifier {
  bool isDefined = false;
  late SharedPreferences prefs;
  String? myname;
  int? mycounter;

  Future initMyController() async {
    if (!isDefined) {
      prefs = await SharedPreferences.getInstance();
      isDefined = true;
    }
    checkIfExist();
  }

  void checkIfExist() async {
    if (prefs.containsKey("myname") && prefs.containsKey("mycounter")) {
      //implement if the value already exist which mean the app already opened before
      setAlreadyUsedVals();
    } else {
      setFirstOpenerVals();
    }

    print("my name = ${myname}\nmy couter = ${mycounter}");
  }

  Future setFirstOpenerVals() async {
    print("setFirstOpenerVals");
    var counter = 1;
    String name = "";

    myname = name;
    mycounter = counter;

    await prefs.setString("myname", myname!);
    await prefs.setInt("mycounter", mycounter!);

    notifyListeners();
  }

  Future setAlreadyUsedVals() async {
    print("setAlreadyUsedVals");

    myname = prefs.getString("myname");
    mycounter = prefs.getInt("mycounter")! + 1;
    print("counter = ${mycounter}");
    await prefs.setInt("mycounter", mycounter!);

    notifyListeners();
  }

  Future setNameFromform(String val) async {
    myname = val;
    await prefs.setString("myname", myname!);
    notifyListeners();
  }
}
