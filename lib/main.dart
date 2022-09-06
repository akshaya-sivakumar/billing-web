import 'package:billing_web/route_generator.dart';
import 'package:billing_web/ui/screens/admin/admin_panel.dart';
import 'package:billing_web/ui/screens/admin/users.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: locator<NavigationService>().navigatorkey,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Billing',
      onGenerateRoute: generateRoute,
      initialRoute: "/",
      scaffoldMessengerKey: scaffoldkey,
      debugShowCheckedModeBanner: false,
    );
  }
}

final scaffoldkey = GlobalKey<ScaffoldMessengerState>();
void showToast({
  message,
  context,
  bool isError = false,
}) {
  scaffoldkey.currentState?.clearSnackBars();
  scaffoldkey.currentState?.showSnackBar(SnackBar(
    elevation: 6,
    content: InkWell(
      onTap: () {
        scaffoldkey.currentState?.clearSnackBars();
      },
      child: Container(
        color: isError ? const Color(0xFFFBF2F4) : const Color(0xFFE1F4E5),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: "futura",
              color:
                  isError ? const Color(0xFFB00020) : const Color(0xFF35B350)),
        ),
      ),
    ),
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 4),
    dismissDirection: DismissDirection.vertical,
    backgroundColor:
        isError ? const Color(0xFFFBF2F4) : const Color(0xFFE1F4E5),
  ));
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
