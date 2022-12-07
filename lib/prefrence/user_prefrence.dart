import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreference{

  void saveRegisteredUser(User userData) async{

    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("name", userData.user);
    pref.setString("token", userData.token);

  
  }

  Future<User> getUser() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String name = pref.getString("name").toString();
    String token = pref.getString("token").toString();

    return User(user: name, token: token);
  }

  void removeUser() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('name');
    pref.remove('token');
  }

}