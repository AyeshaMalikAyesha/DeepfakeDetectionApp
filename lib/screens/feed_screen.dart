import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: colorStatusBar, // Set the status bar color
                statusBarIconBrightness:
                    Brightness.light, // Status bar icons' color
              ),
              automaticallyImplyLeading: false,
              elevation: 5.0, //shadow to app bar
              flexibleSpace: Stack(
                children: [
                  // Clipping the background image to the bounds of the AppBar
                  ClipRect(
                    child: Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Images/bg2.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Color.fromARGB(255, 34, 34, 34).withOpacity(
                                  0.5), // This controls the black tint
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Actual AppBar content
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Row(
                      children: [
                        Image.asset('Images/app_logo-removebg.png'),

                        SizedBox(width: 8.0), // Add some spacing
                        Text(
                          "FakeVision",
                          style: TextStyle(
                            fontFamily: 'Coniferous',
                            fontSize: 33,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.chat,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
