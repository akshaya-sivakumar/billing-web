import 'package:billing_web/ui/screens/admin/admin_panel.dart';
import 'package:billing_web/ui/screens/admin/branches.dart';
import 'package:billing_web/ui/screens/admin/new_item_create.dart';
import 'package:billing_web/ui/screens/admin/sidedishes.dart';
import 'package:billing_web/ui/screens/admin/users.dart';
import 'package:billing_web/ui/screens/dashboard.dart';
import 'package:billing_web/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/branch_bloc/branch_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/newItem_bloc/new_item_bloc.dart';
import 'bloc/sidedish_bloc/sidedish_bloc.dart';
import 'bloc/signup_bloc/signup_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  if (settings.name == LoginPage.routeName) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginPage(),
            ));
  } else if (settings.name == NewItemCreatePage.routeName) {
    return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SidedishBloc(),
                ),
                BlocProvider(
                  create: (context) => NewItemBloc(),
                ),
              ],
              child: const NewItemCreatePage(),
            ));
  } else if (settings.name == AdminPanel.routeName) {
    return MaterialPageRoute(builder: (_) => const AdminPanel());
  } else if (settings.name == Dashboard.routeName) {
    return MaterialPageRoute(builder: (_) => const Dashboard());
  } else if (settings.name == Branches.routeName) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => BranchBloc(),
              child: const Branches(),
            ));
  } else if (settings.name == SideDishes.routeName) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => SidedishBloc(),
              child: const SideDishes(),
            ));
  } else if (settings.name == Users.routeName) {
    return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => BranchBloc(),
                ),
                BlocProvider(
                  create: (context) => SignupBloc(),
                ),
              ],
              child: const Users(),
            ));
  } else {
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error PAge"),
      ),
      body: const Center(
        child: Text('Page Not Found'),
      ),
    );
  });
}
