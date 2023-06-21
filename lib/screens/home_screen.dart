import 'dart:io';
import 'package:fashion_flow/components/postBox.dart';
import 'package:flutter/material.dart';
import 'package:fashion_flow/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('${loggedInUser!.email} logged in');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ffColors.Pink,
        elevation: 0,
        title: Text('Homescreen'),
        leading: IconButton(
          onPressed: () {
            // logout from firestore
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        // user will select a photo from gallery
        XFile? file =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file == null) return;

        // upload file to Firebase Storage
        Reference firebaseRef = FirebaseStorage.instance
            .ref()
            .child('/${loggedInUser!.uid}/posts')
            .child(file.name);
        File postFile = File(file.path);
        await firebaseRef.putFile(postFile);

        // add metadata to collection
        await FirebaseFirestore.instance.collection('posts').add({
          'ref': firebaseRef.fullPath,
          'sender': FirebaseAuth.instance.currentUser!.displayName,
          'url': await firebaseRef.getDownloadURL(),
          'text': 'test description',
          'time': FieldValue.serverTimestamp(),
          'likes': [],
        });
      }),
    );
  }
}
