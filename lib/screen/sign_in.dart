

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/provider/user_provider.dart';
import 'package:workshop/util/http_service.dart';

import '../main.dart';
import '../model/user.dart';
import '../provider/auth_provider.dart';
import 'home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  clipBehavior: Clip.none,
                  child: const Text("Login",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ),
              ),

             Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Email cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Email Address")
                ),
              ),
              ),

              Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Password cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Password")
                ),
              ),
              ),

              Container(
                padding: const EdgeInsets.all(25),
                child: authProvider.logginStatus == Status.loggingIn
                ? const CircularProgressIndicator()
                :
                ElevatedButton(
                  
                  onPressed: () {
                      if(_formKey.currentState!.validate()){
                          authProvider.login(email.text, password.text).then((response) {
                              if(response['status'] == 500){
                                HttpService().showMessage(response['message'], context);
                              }else{
                                 User user = User(user: response['data'].user, 
                            token: response['data'].token);
                            userProvider.setUser(user);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
                            const HomePage()));
                              }
                          });
                      }
                  },
                  child: const Text("Submit"),
                )
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed:() => Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) =>  const MyHomePage(title: "Register Page",))),
                  child: const Text("Go to Regiser")
                  ),

              )

            ],
          ),
        )
      ,)
    );
  
  }
}