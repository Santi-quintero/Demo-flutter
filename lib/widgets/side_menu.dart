import 'package:auth_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ui_provider.dart';
import '../provider/user_auth.dart';
import '../screens/screens.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(224, 248, 243, 243),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: const [
               _DrawerHeader(),
            ],
          ),
          ListTile(
              leading: const Icon(Icons.pages_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              }),
          ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/about');
              }),
          ListTile(
              leading: const Icon(Icons.perm_contact_cal_outlined),
              title: const Text('Contacts'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/contact');
              }),
          ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: const Text('signature'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signature');
              }),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      padding: EdgeInsets.zero,
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
      child: PurpleBox(),
    );
  }
}
