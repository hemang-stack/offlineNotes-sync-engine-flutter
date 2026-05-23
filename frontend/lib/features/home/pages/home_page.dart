import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My tasks"),
        actions: [
          IconButton(onPressed: () {}, 
          icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}
