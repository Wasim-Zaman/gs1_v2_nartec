import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiring_task/providers/gtin.dart';
import 'package:hiring_task/providers/login_provider.dart';
import 'package:hiring_task/res/routes/routes_management.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String routeName = 'gs1-login-screen';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GTIN>(
          create: (context) => GTIN(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'GS1 Saudi Arabia',
        theme: ThemeData(
          primarySwatch: darkBlue,
          appBarTheme: AppBarTheme(
            elevation: 0,
            toolbarTextStyle: const TextTheme().bodyMedium,
            titleTextStyle: const TextTheme().titleLarge,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: RoutesManagement.getRoutes(),
      ),
    );
  }
}
