import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';
import '../provider/providers.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final userProvider = Provider.of<AuthService>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'Register',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 30,
        ),
        ChangeNotifierProvider(
            create: (_) => RegisterFormProvider(),
            child: _ContentFormRegister(
                registerForm: registerForm,
                userProvider: userProvider,
                uiProvider: uiProvider))
      ],
    );
  }
}

class _ContentFormRegister extends StatelessWidget {
  final RegisterFormProvider registerForm;
  final AuthService userProvider;
  final UiProvider uiProvider;

  const _ContentFormRegister(
      {required this.registerForm,
      required this.userProvider,
      required this.uiProvider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: registerForm.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 250,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecorations.authInputDecoration(
                            hintText: 'Name',
                            labelText: 'Nombre',
                            icon: Icons.person),
                        onChanged: (value) => registerForm.name = value,
                        validator: (value) {
                          return (value != null && value.length >= 6)
                              ? null
                              : 'El nombre como minimo debe contener 5 caracteres';
                        },
                      )),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'LastName',
                          labelText: 'Apellidos',
                          icon: Icons.person),
                      onChanged: (value) => registerForm.lastName = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduzca sus apellidos';
                        } else if (value.contains('@')) {
                          return 'Por favor, no utilice el carácter @.';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 250,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecorations.authInputDecoration(
                            hintText: 'Phone',
                            labelText: 'Phone',
                            icon: Icons.phone_android_outlined),
                        onChanged: (value) => registerForm.phone = value,
                        validator: (value) {
                          return (value != null &&
                                  value.length >= 6 &&
                                  value.length <= 20)
                              ? null
                              : 'Numeros entre 6 y 20 digitos';
                        },
                      )),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Address',
                          labelText: 'address',
                          icon: Icons.send),
                      onChanged: (value) => registerForm.address = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduzca su direccion';
                        } else if (value.contains('@')) {
                          return 'Por favor, no utilice el carácter @.';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(
                      width: 250,
                      child: BirthDateFormField(registerForm: registerForm)),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                      width: 250,
                      child: _SelectGender(registerForm: registerForm))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Email',
                          labelText: 'Correo electronico',
                          icon: Icons.alternate_email_outlined),
                      onChanged: (value) => registerForm.emailAddress = value,
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);

                        return regExp.hasMatch(value!)
                            ? null
                            : 'El valor ingresado no tiene formato valido';
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: '*****',
                          labelText: 'Contraseña',
                          icon: Icons.lock_outlined),
                      onChanged: (value) => registerForm.passsword = value,
                      validator: (value) {
                        return (value != null && value.length >= 6)
                            ? null
                            : 'La contraseña debe de ser de 6 caracteres';
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              _SubmitForm(
                  registerForm: registerForm,
                  userProvider: userProvider,
                  uiProvider: uiProvider),
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
          )),
    );
  }
}

class _SubmitForm extends StatelessWidget {
  const _SubmitForm({
    super.key,
    required this.registerForm,
    required this.userProvider,
    required this.uiProvider,
  });

  final RegisterFormProvider registerForm;
  final AuthService userProvider;
  final UiProvider uiProvider;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      onPressed: registerForm.isLoading
          ? null
          : () async {
              if (!registerForm.isValidForm()) return;
              registerForm.isLoading = true;

              final email = registerForm.emailAddress;
              final password = registerForm.passsword;
              final name = registerForm.name;
              final lastName = registerForm.lastName;
              final phone = registerForm.phone;
              final address = registerForm.address;
              final date = registerForm.date;
              final gender = registerForm.gender;

              final userCredential = await userProvider
                  .registerWithEmailAndPassword(email, password);
              // ignore: avoid_print
              print(userCredential);

              await userProvider.addUserDatabase(
                  name, lastName, phone, address, date, gender, email);

              if (userCredential == 'true') {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, '/home');
                registerForm.resetForm();
              } else {
                uiProvider.messageFail = userCredential;
                uiProvider.isFail = true;
                registerForm.isLoading = false;
              }
              registerForm.isLoading = false;
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          registerForm.isLoading ? 'Esperar' : 'Registrar',
          // loginForm.isLoading ? 'Esperar' : 'Ingresar',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class BirthDateFormField extends StatefulWidget {
  final RegisterFormProvider registerForm;
  const BirthDateFormField({super.key, required this.registerForm});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BirthDateFormFieldState createState() =>
      // ignore: no_logic_in_create_state
      _BirthDateFormFieldState(registerForm);
}

class _BirthDateFormFieldState extends State<BirthDateFormField> {
  final RegisterFormProvider registerForm;

  DateTime selectedDate = DateTime.now();
  var formatterAno = DateFormat("y");

  _BirthDateFormFieldState(this.registerForm);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            DateTime(int.parse(formatterAno.format(selectedDate)) - 18),
        firstDate: DateTime(1900),
        lastDate: DateTime(int.parse(formatterAno.format(selectedDate)) - 18));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        registerForm.date = picked.millisecondsSinceEpoch;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.grey),
          labelText: 'Birth Date',
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
          suffixIcon: IconButton(
            onPressed: () => {_selectDate(context)},
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.deepPurple,
            ),
          ),
        ),
        readOnly: true,
        controller: TextEditingController(
            // ignore: unnecessary_null_comparison
            text: "${selectedDate.toLocal()}".split(' ')[0]),
        validator: (value) {
          // ignore: unnecessary_null_comparison
          if (_selectDate == null) {
            return 'Please select your birth date';
          }
          return null;
        },
      ),
    );
  }
}

class _SelectGender extends StatefulWidget {
  final RegisterFormProvider registerForm;

  const _SelectGender({required this.registerForm});

  @override
  // ignore: no_logic_in_create_state
  State<_SelectGender> createState() => __SelectGenderState(registerForm);
}

class __SelectGenderState extends State<_SelectGender> {
  final RegisterFormProvider registerForm;

  String dropdownValue = 'Male';
  final List<String> _genders = [
    'Male',
    'Female',
    'Non-binary',
    'Other',
  ];

  __SelectGenderState(this.registerForm);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecorations.authInputDecoration(
          hintText: 'Gender', labelText: 'Gender', icon: Icons.people),
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          registerForm.gender = dropdownValue;
          dropdownValue = newValue!;
        });
      },
      items: _genders.map<DropdownMenuItem<String>>((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}
