import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier{

    var changeName = "";

     var token = "";

    void setUser(User name){
      changeName = name.user;
      token = name.token;
      notifyListeners();
    }

}