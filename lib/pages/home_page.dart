import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/widgets.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> isLikePost = {};

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
        centerTitle: false,
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

                    return PostCard(
                      profilePict: profilePict,
                      user: snapshotUser.data[snapshot.data[index].userId],
                      post: snapshot.data[index],
                      imagePost: imagePost,
                      isLike: isLikePost[snapshot.data[index].id.toString()] ??
                          false,
                      onTapLike: (boolValue) {
                        setState(() {
                          isLikePost.addAll(
                              {snapshot.data[index].id.toString(): boolValue});
                        });
                      },
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
