import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance/blocs/auth/auth_bloc.dart';
import 'package:personal_finance/blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar Sesion'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSubmitting) {
              showDialog(
                  context: context,
                  builder: (cotext) => const Center(
                        child: CircularProgressIndicator(),
                      ));
            } else if (state.isAuthenticated) {
              Navigator.of(context).pop();
              context.go('/dashboard');
            } else if (state.errorMessage != null) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmailField(
            controller: _emailController,
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordField(
            controller: _passwordController,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(onPressed: _signIn, child: const Text('Iniciar sesion'))
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Bienvenido, ${userCredential.user?.email}'),
        ));
        Future.delayed(const Duration(seconds: 2), () {
          context.go('/dashboard');
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error ${e.message}'),
        ));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Contrasena', prefixIcon: Icon(Icons.lock)),
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      validator: Validator.validatePassword,
    );
  }
}

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el correo';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Por favor, ingres un correo valido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contrsena';
    }
    if (value.length < 6) {
      return 'la contrasena tiene al menos 6 caracteres';
    }
    return null;
  }
}
