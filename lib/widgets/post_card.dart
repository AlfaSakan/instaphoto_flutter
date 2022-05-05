import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../arguments/arguments.dart';
import '../models/models.dart';
import '../pages/pages.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.profilePict,
    required this.user,
    required this.post,
    required this.imagePost,
    this.numberLikes,
    required this.onTapLike,
    this.isLike = false,
  }) : super(key: key);

  final String profilePict;
  final String imagePost;
  final User user;
  final Post post;
  final int? numberLikes;
  final void Function(bool value) onTapLike;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              UserFeedPage.routeName,
              arguments: UserFeedArguments(
                user,
                profilePict,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 10,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    profilePict,
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onDoubleTap: () {
            onTapLike(true);
          },
          child: Image.network(
            imagePost,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => onTapLike(!isLike),
                    child: Icon(
                      isLike ? Icons.favorite : Icons.favorite_outline,
                      color: isLike ? Colors.red : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.chat_bubble_outline),
                  const SizedBox(width: 15),
                  const Icon(Icons.send_outlined),
                  const Spacer(),
                  const Icon(Icons.bookmark_outline_rounded),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${numberLikes ?? Random().nextInt(100)} likes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(
                        context,
                        PostPage.routeName,
                        arguments: PostPageArguments(
                          post,
                          user,
                          imagePost,
                          profilePict,
                        ),
                      );
                    },
                  text: '${user.username}. ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
