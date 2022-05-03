import 'package:flutter/material.dart';
import '../models/models.dart';

class PostPage extends StatefulWidget {
  static const routeName = 'PostPage';
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: ListView(
          children: [
            Image.network(
              args.imagePost,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            Text(args.user.name),
            const SizedBox(height: 8),
            Text(
              args.post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              args.post.body,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostPageArguments {
  final Post post;
  final User user;
  final String imagePost;

  PostPageArguments(this.post, this.user, this.imagePost);
}
