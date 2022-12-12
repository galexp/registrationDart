import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/blog_provider.dart';
import '../provider/user_provider.dart';
import '../util/http_service.dart';

class EditPost extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  const EditPost({super.key, required this.id, required this.title, required this.body});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {

   final _formKey = GlobalKey<FormState>();
  final TextEditingController blogTitle = TextEditingController();
  final TextEditingController blogDescription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogTitle.text = widget.title;
    blogDescription.text = widget.body;
  }
  
  
  @override
 Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
      ),
      body: SingleChildScrollView(
        child: blogProvider.loadingCicle == Status.loading
        ? const Center(child: CircularProgressIndicator())
        : 
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
             
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 30),
                child: const Text(
                  'Update Post',
                  style: TextStyle(fontFamily: 'Lato', fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Blog Title ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 15)),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Lato',
                              fontSize: 15))
                    ])),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: blogTitle,
                  decoration: const InputDecoration(
                      hintText: "Enter the blog title",
                      filled: true,
                      fillColor: Color.fromARGB(255, 246, 245, 245),
                      enabledBorder: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Blog title is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Blog Description ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 15)),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Lato',
                              fontSize: 15))
                    ])),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: blogDescription,
                  maxLines: 6,
                  decoration: const InputDecoration(
                      hintText: "Enter blog body here",
                      filled: true,
                      fillColor: Color.fromARGB(255, 246, 245, 245),
                      enabledBorder: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Blog Description is required";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // print(userProvider.token);
                      if(_formKey.currentState!.validate()){

                         blogProvider.updatePost(blogTitle.text, blogDescription.text, 
                          widget.id, userProvider.token).then((response){

                             HttpService().showMessage(response['message'], context);
                            //  clearForm();

                          });

                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontFamily: "Lato", fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearForm(){
    blogTitle.clear();
    blogDescription.clear();
  }
}