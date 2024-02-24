import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/models/user.dart';
import 'package:fake_vision/providers/user_provider.dart';
import 'package:fake_vision/resources/firestore_methods.dart';
import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/app_bar/custom_app_bar.dart';
import 'package:fake_vision/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await FirestoreMethods().postComment(
        widget.postId,
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        if (context.mounted) showSnackBar(context, res);
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      
      appBar: CustomAppBar(
        title: 'Comments',
        paddingTop: 34.0,
        backButtonScreen: MobileScreenLayout(),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      hintStyle: TextStyle(fontFamily: 'Inter', fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => postComment(
                  user.uid,
                  user.username,
                  user.photoUrl,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue, fontFamily: 'Inter'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
