import 'package:flutter/material.dart';
import 'post.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;
  final User user;
  PostList(this.listItems, this.user);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback) {
    this.setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
              Expanded(
                  child: ListTile(
                    title: Text(post.body),
                    subtitle: Text(post.author),
                  )),
              Row(children: [
                Container(
                  child:
                  Text(post.usersliked.length.toString(), style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                ),
                IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () => this.like(() => post.likedPost(widget.user)),
                    color: post.usersliked.contains(widget.user.uid) ? Colors.green : Colors.black)
              ])
            ]));
      },
    );
  }
}