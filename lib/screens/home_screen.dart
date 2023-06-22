import 'package:fashion_flow/components/postBox.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot post = snapshot.data!.docs[index];
                  return Post(
                    postImageUrl: post['url'],
                    postText: post['text'],
                    userName: post['sender'],
                    postId: post.id,
                    likes: List<String>.from(post['likes'] ?? []),
                  );
                });
          }),
    );
  }
}
