import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
