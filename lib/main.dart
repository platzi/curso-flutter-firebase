import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/app_router.dart';
import 'package:personal_finance/app_theme.dart';
import 'package:personal_finance/blocs/auth/auth_bloc.dart';
import 'package:personal_finance/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(),
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: Builder(builder: (context) {
          return MaterialApp.router(
            theme: AppThemes.greenFinanceTheme,
            darkTheme: AppThemes.greenFinanceDarkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        }),
      ),
    );
  }
}
