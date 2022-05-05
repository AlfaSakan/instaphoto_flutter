import 'package:flutter/material.dart';
import './pages/pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: TabBarBottom.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        UsersPage.routeName: (context) => const UsersPage(),
        PostPage.routeName: (context) => const PostPage(),
        UserFeedPage.routeName: (context) => const UserFeedPage(),
        TabBarBottom.routeName: (context) => const TabBarBottom(),
      },
    );
  }
}
