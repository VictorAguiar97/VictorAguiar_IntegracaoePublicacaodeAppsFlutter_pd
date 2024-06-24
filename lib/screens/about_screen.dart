import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "21:50");
            //Navigator.push(context, MaterialPageRoute(builder: (context) {
            //return const HomeScreen();
            //}));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.pinkAccent,
        title: const Text('Sobre Nós'),
      ),
      body: const Center(
        child: Text("Sobre Nós!"),
      ),
    );
  }
}
