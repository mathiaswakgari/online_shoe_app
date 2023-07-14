import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shoe_app/controllers/cartScreenProvider.dart';
import 'package:online_shoe_app/controllers/mainScreenProvider.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/controllers/wishlistProvider.dart';
import 'package:online_shoe_app/views/ui/mainScreen.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("cart");
  await Hive.openBox("wishlist");

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MainScreenNotifier>(create: (_)=> MainScreenNotifier()),
        ChangeNotifierProvider(create: (_)=> ProductScreenNotifier()),
        ChangeNotifierProvider(create: (_)=> CartScreenNotifier()),
        ChangeNotifierProvider(create: (_)=> WishlistNotifier()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainScreen()
        );
      }
    );
  }
}


