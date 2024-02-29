import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;
  final String postType;
//constructor
  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profileImage,
      required this.likes,
      required this.postType});

//whenever we call toJson method it will convert whatever passed in above arguments of constructor to object
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
        "postUrl": postUrl,
        "postType": postType
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        username: snapshot['username'],
        uid: snapshot['uid'],
        description: snapshot['description'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profileImage: snapshot['profileImage'],
        likes: snapshot['likes'],
        postUrl: snapshot['postUrl'],
        postType: snapshot['postType']);
  }
}
