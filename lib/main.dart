import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/app_color.dart';
import 'core/navigation/app_routes.dart';
import 'data/datasource/local_database.dart';
import 'modules/splashscreen/view/splashscreen.dart';
import 'shared/providers/theme_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  prefs = await SharedPreferences.getInstance();
  await ScreenUtil.ensureScreenSize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const Pawfect(),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Pawfect extends StatelessWidget {
  const Pawfect({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 862),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          title: 'Pawfect',
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          navigatorKey: navigatorKey,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.black,
            brightness: Brightness.light,
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          initialRoute: SplashScreen.route,
        );
      },
    );
  }
}
