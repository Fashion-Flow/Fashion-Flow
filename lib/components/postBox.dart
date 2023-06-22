import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_flow/components/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String postText;
  final String userName;
  final String postImageUrl;
  final String postId;
  final List<String> likes;

  const Post(
      {super.key,
      required this.postImageUrl,
      required this.postText,
      required this.userName,
      required this.postId,
      required this.likes});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser!.displayName);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.displayName])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.displayName])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: IntrinsicHeight(
        // expensive widget...
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    LimitedBox(
                      maxHeight: 400.0,
                      child: Image.network(
                        widget.postImageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(widget.postText),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.comment_outlined),
                const SizedBox(height: 10.0),
                LikeButton(isLiked: isLiked, onTap: toggleLike),
                const SizedBox(height: 5.0),
                Text(
                  widget.likes.length.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 15.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
