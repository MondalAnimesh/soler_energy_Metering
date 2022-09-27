import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy/module/provider/app_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:solar_energy/ui/pages/auth/login.dart';
import 'package:solar_energy/ui/pages/home/user.dart';

import 'module/function/is_user_logged_in.dart';

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
        child: NeumorphicApp(
          title: 'Flutter Login',
          debugShowCheckedModeBanner: false,
          theme: const NeumorphicThemeData(
            baseColor: Color(0xFFFFFFFF),
            lightSource: LightSource.topLeft,
            depth: 10,
          ),
          darkTheme: const NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            lightSource: LightSource.topLeft,
            depth: 6,
          ),
          home: FutureBuilder(
              future: isUserLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return const Home();
                  }
                  return const LoginScreen();
                }
                return const CircularProgressIndicator();
              }),
          builder: EasyLoading.init(),
        ));
  }
}
