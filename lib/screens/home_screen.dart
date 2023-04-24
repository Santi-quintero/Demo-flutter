import 'package:auth_firebase/provider/user_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/ui_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final authProvider = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      drawer: const SideMenu(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                ),
                onPressed: () {
                  uiProvider.selectedMenuOpt = 0;
                  uiProvider.isFail = false;
                  authProvider.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Sign out', style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    );
  }
}
