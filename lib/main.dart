import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shoe_app/controllers/cartScreenProvider.dart';
import 'package:online_shoe_app/controllers/mainScreenProvider.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/views/ui/main_screen.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("cart");
  await Hive.openBox("liked");

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MainScreenNotifier>(create: (_)=> MainScreenNotifier()),
        ChangeNotifierProvider(create: (_)=> ProductScreenNotifier()),
        ChangeNotifierProvider(create: (_)=> CartScreenNotifier()),
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
      home: MainScreen()
    );
  }
}


