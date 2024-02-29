import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/models/post.dart';
import 'package:fake_vision/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
    String postType,
  ) async {
    String result = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      // String photoUrl = await StorageMethods().uploadFileToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: [],
          postType: postType);

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  

  Future<String> uploadVideo(
    String description,
    String videoDownloadUrl,
    String uid,
    String username,
    String profileImage,
    String postType
  ) async {
    String result = "some error occurred";
    try {
      String videoUrl =
          await StorageMethods().uploadVideoToStorage('posts', videoDownloadUrl, true);

      String postId = Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: videoUrl,
        profileImage: profileImage,
        likes: [],
        postType:postType
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());

      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String result = "some error occured";
    try {
      //if user has already liked the post, we have to delete it
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        // we need to add likes to array
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      result = "success";
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
