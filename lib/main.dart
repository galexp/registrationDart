import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                child: ElevatedButton(
                  
                  onPressed: () {
                    
                  },
                  child: const Text("Submit"),
                )
              )
            ],
          ),
        )
      ,)
    );
  }
}
