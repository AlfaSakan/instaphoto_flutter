import 'package:flutter/material.dart';
import 'package:instaphoto_flutter/widgets/widgets.dart';
import '../arguments/arguments.dart';

class PostPage extends StatefulWidget {
  static const routeName = 'PostPage';
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLikePost = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostPageArguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Posts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            PostCard(
              profilePict: args.imageProfile,
              user: args.user,
              post: args.post,
              imagePost: args.imagePost,
              isLike: isLikePost,
              onTapLike: (boolValue) {
                setState(() {
                  isLikePost = boolValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
