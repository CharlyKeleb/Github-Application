import 'package:flutter/material.dart';
import 'package:github_app/providers/repo_provider.dart';
import 'package:github_app/providers/user_provider.dart';
import 'package:github_app/screen/home.dart';
import 'package:github_app/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: RepositriesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme:Constants.darkTheme,
        home: HomeScreen(),
      ),
    );
  }
}
