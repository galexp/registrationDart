import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/model/user.dart';
import 'package:workshop/prefrence/user_prefrence.dart';
import 'package:workshop/provider/auth_provider.dart';
import 'package:workshop/provider/blog_provider.dart';
import 'package:workshop/provider/user_provider.dart';
import 'package:workshop/screen/home_page.dart';
import 'package:workshop/screen/sign_in.dart';
import 'package:workshop/util/http_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider())
      ],
      child: const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<User> getUser() => UserPreference().getUser();

    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
               if(snapshot.hasError){
                return Text('Error : ${snapshot.error}');
               }else if(snapshot.data!.token == "null"){
                  return const SignInScreen();
               }else{

               
                  return const HomePage();
               }
          }

        
      },)
      
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    // defining a provider(s)
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

   return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  child: const Text("Registration",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                keyboardType: TextInputType.name,
                controller: name,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Name cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Name")
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
                child: authProvider.registeredStatus == Status.registering
                ? const CircularProgressIndicator()
                :
                ElevatedButton(
                  
                  onPressed: () {
                      if(_formKey.currentState!.validate()){
                        authProvider.register(name.text, email.text, password.text)
                        .then((response) {
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
                  MaterialPageRoute(builder: (context) => const SignInScreen())),
                  child: const Text("Go to Login")
                  ),

              )
            ],
          ),
        )
      ,)
    );
  }
}
