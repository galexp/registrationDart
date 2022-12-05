import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier{

    var changeName = "";

    void setUser(User name){
      changeName = name.user;
      notifyListeners();
    }

}