import 'package:auth_firebase/provider/ui_provider.dart';
import 'package:auth_firebase/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/login_form.dart';
import '../provider/user_auth.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'Login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final userProvider = Provider.of<AuthService>(context);

    return Scaffold(
        body: AuthBakground(
            child: SingleChildScrollView(
      child: Container(
        // color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: uiProvider.selectedMenuOpt == 0
                  ? _CardContentLogin(
                      uiProvider: uiProvider,
                      loginForm: loginForm,
                      userProvider: userProvider)
                  : const RegisterScreen(),
            ),
            const SizedBox(height: 50),
            _FlatBottom(formKey: loginForm),
          ],
        ),
      ),
    )));
  }
}

class _CardContentLogin extends StatelessWidget {
  const _CardContentLogin({
    required this.uiProvider,
    required this.loginForm,
    required this.userProvider,
  });

  final UiProvider uiProvider;
  final LoginFormProvider loginForm;
  final AuthService userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'Login',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 30,
        ),
        ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: _ContentLoginForm(
                loginForm: loginForm,
                uiProvider: uiProvider,
                userProvider: userProvider))
      ],
    );
  }
}

class _ContentLoginForm extends StatelessWidget {
  const _ContentLoginForm({
    required this.loginForm,
    required this.uiProvider,
    required this.userProvider,
  });

  final LoginFormProvider loginForm;
  final UiProvider uiProvider;
  final AuthService userProvider;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
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
              onChanged: (value) => loginForm.emailAddress = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value!)
                    ? null
                    : 'El valor ingresado no tiene formato valido';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              // controller: loginForm.passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  icon: Icons.lock_outlined),
              onChanged: (value) => loginForm.passsword = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              enableFeedback: !loginForm.isValidForm(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      final email = loginForm.emailAddress;
                      final password = loginForm.passsword;
                      final response = await userProvider
                          .singInWithEmailAndPassword(email, password);
                      loginForm.isLoading = false;
                      if (response == 'true') {
                        loginForm.resetForm();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        uiProvider.messageFail = response;
                        uiProvider.isFail = true;
                      }
                      loginForm.isLoading = false;
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Esperar' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (uiProvider.isFail)
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 30,
                child: Text(
                  uiProvider.messageFail,
                  style: const TextStyle(color: Colors.red),
                ),
              )
          ],
        ));
  }
}

class _FlatBottom extends StatelessWidget {
  final LoginFormProvider formKey;

  const _FlatBottom({required this.formKey});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return MaterialButton(
      child: Text(
        uiProvider.selectedMenuOpt == 0 ? 'Crear una cuenta nueva' : 'Login',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (uiProvider.selectedMenuOpt == 1) {
          formKey.resetForm();
          uiProvider.selectedMenuOpt = 0;
        } else {
          formKey.resetForm();
          uiProvider.selectedMenuOpt = 1;
          uiProvider.isFail = false;
        }
      },
    );
  }
}
