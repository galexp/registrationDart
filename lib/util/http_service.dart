
import 'package:flutter/material.dart';

class HttpService{

    static const String base_url = "https://emmi-softwaretrack.online/api/";

    static const String register = "${base_url}register";

    static const String login = "${base_url}login";

    static const String blogs = "${base_url}blogs";

    static const String updateblog = "${base_url}update-blog/";

    static const String deleteblog = "${base_url}delete-blog/";

    void showMessage(String message, BuildContext context){
      var snackbar = SnackBar(content: Text(message));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

}