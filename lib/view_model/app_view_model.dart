import 'package:contacts_application/model/contact.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  List<Contact> cont = <Contact>[];
  int get numCont => cont.length;
  void addCont(Contact newCont) {
    cont.add(newCont);
    notifyListeners();
  }

  String getName(int contIndex) {
    return cont[contIndex].name;
  }

  String getPhone(int contIndex) {
    return cont[contIndex].phoneNumber;
  }

  void deleteCont(int contIndex) {
    cont.removeAt(contIndex);
    notifyListeners();
  }

  void updateName(int contIndex, String newName) {
    cont[contIndex].name = newName;
    notifyListeners();
  }

  void updateNickName(int contIndex, String newNickName) {
    cont[contIndex].nickName = newNickName;
    notifyListeners();
  }

  void updateWork(int contIndex, String newWork) {
    cont[contIndex].work = newWork;
    notifyListeners();
  }

}
