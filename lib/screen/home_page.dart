

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/provider/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        
      ),
      body:  Center(
        child: Text("Welcome ${userProvider.changeName}"),
      ),
    );
  }
}