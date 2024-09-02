/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/ui/home_page/home_provider.dart';
import 'package:travel_app/ui/login_page/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: 'MAYTH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
        child: FutureBuilder<User?>(
          future: Authentication().getLoggedUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              // User is signed in
              return HomeProvider();
            } else {
              // No user is signed in
              return LoginProvider();
            }
          },
        ),
      ),
    );
    return materialApp;
  }
}
