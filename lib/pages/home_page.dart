import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../pages/pages.dart';
import '../pages/user_feed_page.dart';
import '../arguments/user_feed_arguments.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getPostData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    var jsonData = jsonDecode(response.body);
    List<Post> posts = [];

    for (var u in jsonData) {
      Post post = Post(u['id'], u['userId'], u['title'], u['body']);
      posts.add(post);
    }

    return posts;
  }

  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user =
          User(u['id'], u['name'], u['username'], u['email'], u['phone']);
      users.add(user);
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'InstaPhoto',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, AsyncSnapshot snapshotUser) {
            if (snapshotUser.data == null) {
              return const Center(
                child: Text('Loading...'),
              );
            }

            return FutureBuilder(
              future: getPostData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    String imagePost =
                        'https://picsum.photos/1000?image=${snapshot.data[index].id + 1}';
                    String profilePict =
                        'https://picsum.photos/1000?image=${snapshot.data[index].userId + 10}';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              UserFeedPage.routeName,
                              arguments: UserFeedArguments(
                                snapshotUser.data[snapshot.data[index].userId],
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
                                  '${snapshotUser.data[snapshot.data[index].userId].username}',
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
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PostPage.routeName,
                              arguments: PostPageArguments(
                                snapshot.data[index],
                                snapshotUser.data[snapshot.data[index].userId],
                                imagePost,
                              ),
                            );
                          },
                          child: Image.network(
                            imagePost,
                            fit: BoxFit.cover,
                            // height: 250,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    PostPage.routeName,
                                    arguments: PostPageArguments(
                                      snapshot.data[index],
                                      snapshotUser
                                          .data[snapshot.data[index].userId],
                                      imagePost,
                                    ),
                                  );
                                },
                              text:
                                  '${snapshotUser.data[snapshot.data[index].userId].username}. ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: snapshot.data[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
