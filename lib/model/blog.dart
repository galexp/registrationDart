
class Blog{
    final int id;
    final String title;
    final String body;
    final String author;

    Blog({required this.id, required this.title, required this.body, required this.author});

    factory Blog.fromJson(Map<String, dynamic> json){
      return Blog(id:json['id'], title: json['title'], body: json['body'], author: json['author']);
    }

}