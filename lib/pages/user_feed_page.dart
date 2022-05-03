import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../arguments/user_feed_arguments.dart';
import '../models/models.dart';

class UserFeedPage extends StatelessWidget {
  static const routeName = 'UserFeedPage';
  const UserFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserFeedArguments;

    Future getUserFeed() async {
      const _authority = 'jsonplaceholder.typicode.com';
      const _unencodedPath = 'posts';
      final _queryParameters = {'userId': args.user.id.toString()};
      final _uri = Uri.https(_authority, _unencodedPath, _queryParameters);

      final response = await http.get(_uri);
      var jsonData = jsonDecode(response.body);
      List<Post> posts = [];

      for (var u in jsonData) {
        Post post = Post(u['id'], u['userId'], u['title'], u['body']);
        posts.add(post);
      }

      return posts;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          args.user.username,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  args.profilePict,
                  width: 40,
                  height: 40,
                ),
              ),
              title: Text(
                args.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(args.user.username),
            ),
            FutureBuilder(
              future: getUserFeed(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }

                final feedWidget = snapshot.data.map(
                  (feed) {
                    String imagePost =
                        'https://picsum.photos/1000?image=${feed.id + 1}';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          imagePost,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feed.title,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                feed.body,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ).toList();

                return Column(
                  children: [
                    ...feedWidget,
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
