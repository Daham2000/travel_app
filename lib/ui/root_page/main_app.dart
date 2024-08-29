/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/ui/home_page/home_provider.dart';
import 'package:travel_app/ui/login_page/login_provider.dart';
import 'package:travel_app/ui/login_page/login_view.dart';
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
      home: FutureBuilder<User?>(
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
    );
    return materialApp;
  }
}
