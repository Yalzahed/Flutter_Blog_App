import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';
import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class myHomePage extends StatefulWidget {

  final User user;
  myHomePage(this.user);
  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = new Post(text, widget.user.displayName);
    // savePost(post);
    post.setID(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updateMessages(){
    getAllMessages().then((posts) => {
      this.setState(() {
        this.posts = posts;
      })
    });
  }

  @override
  void initState(){
    super.initState();
    updateMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My First Flutter App")),
        body: Column(children: [
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWiget(this.newPost),
        ]));
  }
}