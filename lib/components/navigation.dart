import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_flow/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fashion_flow/screens/home_screen.dart';
import 'package:fashion_flow/screens/explore_screen.dart';
import 'package:fashion_flow/screens/camera.dart';
import 'package:fashion_flow/screens/notification_screen.dart';
import 'package:fashion_flow/screens/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class Navigation extends StatefulWidget {
  static const String routeName = '/navigation';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
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

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    Camera(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            Navigator.pushNamed(context, '/login');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search,
                    color:
                        _selectedIndex == 1 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(1),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.notifications,
                    color:
                        _selectedIndex == 3 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(3),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.person,
                    color:
                        _selectedIndex == 4 ? ffColors.Purple : ffColors.Pink),
                onPressed: () => _onItemTapped(4),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
            'sender': loggedInUser!.displayName,
            'url': await firebaseRef.getDownloadURL(),
            'text': 'test description',
            'time': FieldValue.serverTimestamp(),
            'likes': [],
          });
        },
        tooltip: 'Camera',
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: ffColors.Pink),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
