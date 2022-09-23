import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy/module/provider/app_state.dart';
import 'package:solar_energy/ui/pages/auth/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Appstate(),
        child: MaterialApp(
          title: 'Flutter Login',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFF2661FA),
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          
          home: const LoginScreen(),
          builder: EasyLoading.init(),
        ));
  }
}
