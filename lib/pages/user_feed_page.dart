import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages.dart';

import '../arguments/arguments.dart';
import '../widgets/widgets.dart';
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

    Future getFollowers() async {
      return null;
    }

    Future getFollowings() async {
      return null;
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
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          args.profilePict,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        args.user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ProfileTag(
                    future: getUserFeed(),
                    tag: 'Posts',
                  ),
                  ProfileTag(
                    future: getFollowers(),
                    tag: 'Followers',
                  ),
                  ProfileTag(
                    future: getFollowings(),
                    tag: 'Following',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: getUserFeed(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }

                final feedWidget = snapshot.data.map(
                  (Post feed) {
                    String imagePost =
                        'https://picsum.photos/1000?image=${feed.id + 1}';

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PostPage.routeName,
                          arguments: PostPageArguments(
                            feed,
                            args.user,
                            imagePost,
                            args.profilePict,
                          ),
                        );
                      },
                      child: Image.network(
                        imagePost,
                        fit: BoxFit.contain,
                        width: (MediaQuery.of(context).size.width / 3) - 2,
                      ),
                    );
                  },
                ).toList();

                return Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    ...feedWidget,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
