import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_managment_flutter_bloc/cubit/theme_cubit.dart';
import 'package:theme_managment_flutter_bloc/cubit/theme_state.dart';

void main() {
  runApp(BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()..setInitialTheme(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.themeData,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Theme Change"),
      ),
      body: Center(
        child: GestureDetector(
            onTap: () {
              context.read<ThemeCubit>().toggleTheme(!isDarkMode);
            },
            child: Image.asset(
              isDarkMode ? "assets/light.png" : "assets/dark.png",
              height: 50,
              width: 50,
            )),
      ),
    );
  }
}
