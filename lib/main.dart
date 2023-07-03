import 'package:flutter/material.dart';
import 'package:online_shoe_app/controllers/mainScreenProvider.dart';
import 'package:online_shoe_app/views/ui/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MainScreenNotifier>(create: (_)=> MainScreenNotifier())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen()
    );
  }
}


