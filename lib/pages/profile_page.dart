import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../arguments/arguments.dart';
import '../models/models.dart';
import 'post_page.dart';
import '../widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'ProfilePage';
  const ProfilePage({Key? key}) : super(key: key);

  final String profilePict = 'https://picsum.photos/1000?image=11';

  Future getUserData() async {
    const _authority = 'jsonplaceholder.typicode.com';
    const _unencodedPath = 'users/1';
    final _uri = Uri.https(_authority, _unencodedPath);

    final response = await http.get(_uri);
    var jsonData = jsonDecode(response.body);

    return jsonData;
  }

  Future getUserFeed() async {
    const _authority = 'jsonplaceholder.typicode.com';
    const _unencodedPath = 'posts';
    final _queryParameters = {'userId': '1'};
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: FutureBuilder(
          future: getUserData(),
          builder: (context, AsyncSnapshot snapshotUser) {
            if (snapshotUser.data == null) {
              return const Text(
                'Loading',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            return Text(
              snapshotUser.data['username'],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
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
                          profilePict,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future: getUserData(),
                        builder: (context, AsyncSnapshot snapshotUser) {
                          if (snapshotUser.data == null) {
                            return const Text(
                              'Loading',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return Text(
                            snapshotUser.data['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
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

                    return FutureBuilder(
                      future: getUserData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Text('Loading...');
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PostPage.routeName,
                              arguments: PostPageArguments(
                                feed,
                                snapshot.data as User,
                                imagePost,
                                profilePict,
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
