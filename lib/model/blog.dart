
class Blog{

    final String title;
    final String body;
    final String author;

    Blog({required this.title, required this.body, required this.author});

    factory Blog.fromJson(Map<String, dynamic> json){
      return Blog(title: json['title'], body: json['body'], author: json['author']);
    }

}