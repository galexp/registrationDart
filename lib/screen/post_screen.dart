import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:workshop/provider/blog_provider.dart';
import 'package:workshop/provider/user_provider.dart';
import 'package:workshop/screen/edit_post.dart';
import 'package:workshop/util/http_service.dart';

import '../model/user.dart';
import '../prefrence/user_prefrence.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
   Future<User> getUser() => UserPreference().getUser();
   String username = "";
   String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUser().then((value)  {
        username = value.user;
        token = value.token;
        print(username);
      
      });
  }
  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: FutureBuilder(
        future: BlogProvider().getPost(),
        builder: (context, snapshot) {

            if(snapshot.hasData){

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {

                    return ListTile(
                      leading:  username == snapshot.data![index].author
                      ? Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                            BlogProvider().deletePost(snapshot.data![index].author, 
                            snapshot.data![index].id, token).then((response){
                                print(response);
                               HttpService().showMessage(response["message"], context);
                             BlogProvider().getPost();


                            });
                           

                        },
                        child: const Text("Delete Post")),
                    ) : const SizedBox(),
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].body),
                     trailing: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: 
                      username == snapshot.data![index].author
                      ? 
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                           MaterialPageRoute(builder: 
                           (context) => 
                           EditPost(id: snapshot.data![index].id, title: snapshot.data![index].title, 
                           body: snapshot.data![index].body) ));
                        },  
                        child: const Text("Update Post"))
                        : const SizedBox()
                        ,
                    ) ,
                    );
                    
                  }
                );
              
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          
        })
        
    );
  }
}