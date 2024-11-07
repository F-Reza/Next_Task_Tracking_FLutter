import 'package:flutter/material.dart';
import 'package:next_task/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'provider/task_provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TaskProvider(),
            ),
          ],
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Next Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      // initialRoute: HomeScreen.routeName,
      // routes: {
      //   MainDrawer.routeName : (_) => const MainDrawer(),
      //   HomeScreen.routeName : (_) => const HomeScreen(),
      // },
      //static const String routeName = '/info';
    );
  }
}
