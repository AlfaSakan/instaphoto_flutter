import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UsersPage extends StatefulWidget {
  static const routeName = 'UsersPage';
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text('Loading...'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                        'https://picsum.photos/200?image=${index + 1}0'),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].username),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
