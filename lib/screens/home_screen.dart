import 'dart:io';
import 'package:fashion_flow/services-auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fashion_flow/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? loggedInUser;

  // sign user out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

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
        actions: [
          //sign out button
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout),
          )
        ],
        leading: IconButton(
          onPressed: () {
            // logout from firestore
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text('HomeScreen'),
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
          'text': 'test',
          'time': FieldValue.serverTimestamp(),
        });
      }),
      body: buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget buildUserList(DocumentSnapshot document) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }


        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) =>
              buildUserListItem(doc)).toList(),
        )
      },
    );
  }

  //build individual user list items

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map <String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data ['email']),
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatPage(
            receiverUserEmail: data ['email'],
            receiverUserID: data ['uids'],
          ),
          ),
          );
        },
      )
    } else {
      // return empty container
      return Container();
    }
  }


}
