import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String appName = "Yoripe";

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatefulWidget {
  final String title = 'Yoripe';

  const MyMainPage({
    super.key,
  });

  @override
  State<MyMainPage> createState() => MyMainPageState();
}

class MyMainPageState extends State<MyMainPage> {
  int currentPageIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'User: ${user!.email}',
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.near_me),
            icon: Icon(Icons.near_me_outlined),
            label: 'Near Me',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_box),
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Recipe',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline_outlined),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_rounded),
            icon: Icon(Icons.menu_rounded),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
