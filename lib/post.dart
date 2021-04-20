import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello_world/database.dart';

class Post {
  String body;
  String author;
  Set usersliked = {};
  DatabaseReference _id;

  Post(this.body, this.author);

  void likedPost(User user) {
    if (this.usersliked.contains(user.uid)) {
      this.usersliked.remove(user.uid);
    } else {
      this.usersliked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setID(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'usersLiked': this
          .usersliked
          .toList(), // sets are not seralisable so convert to list
      'body': this.body
    };
  }

 static Post createPost(record) {
    Map<String, dynamic> attributes = {
      'author': '',
      'usersLiked': [],
      'body': ''
    };
    record.forEach((key, value) => {attributes[key] = value});
    Post post = new Post(attributes['body'], attributes['author']);
    post.usersliked = new Set.from(attributes['usersLiked']);
    return post;
  }
}
