import 'package:auth_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../ui/input_decorations.dart';
import '../widgets/side_menu.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
        ),
        drawer: const SideMenu(),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
          height: double.infinity,
          width: double.infinity,
          color: Colors.red,
          child: Row(
            children: const [_InfoContact(), _FormContact()],
          ),
        ));
  }
}

class _InfoContact extends StatelessWidget {
  const _InfoContact();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: double.infinity,
      width: 800,
      child: Column(
        children: [
          const HeaderIcon(),
          Title(
              color: Colors.white,
              child: const Text(
                'Informacion de Contacto',
                style: TextStyle(fontSize: 40, color: Colors.white),
              )),
          const SizedBox(
            height: 40,
          ),
          const _Message()
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      // alignment: Alignment.centerLeft,
      width: 300,
      height: 200,
      child: Column(
        children: const [
          Text(
            'Info.copntact@gmail.com',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text('1(829) 902-2345', style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}

class _FormContact extends StatelessWidget {
  const _FormContact();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 920,
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Envia un mensaje',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              // controller: loginForm.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'nombres',
                  labelText: 'nombres',
                  icon: Icons.person),
              onChanged: (value) => {},
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              // controller: loginForm.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Telefono/celular',
                  labelText: 'Telefono/celular',
                  icon: Icons.phone),
              onChanged: (value) => {},
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              // controller: loginForm.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Email',
                  labelText: 'Correo electronico',
                  icon: Icons.alternate_email_outlined),
              onChanged: (value) => {},
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              // controller: loginForm.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Mensaje',
                  labelText: 'Mensaje',
                  icon: Icons.message),
              onChanged: (value) => {},
            ),

            const SizedBox(height: 60,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: () {
                
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text('Enviar mensaje',
                  style:  TextStyle(color: Colors.white),
                ),
              ),)
          ],
        )),
      ),
    );
  }
}
