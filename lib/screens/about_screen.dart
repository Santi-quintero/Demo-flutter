import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: const SideMenu(),
      body: const Center(
        child: Text('Abouts screen'),
      ),
    );
  }
}
