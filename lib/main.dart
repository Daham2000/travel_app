/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/root_page/root_bloc.dart';
import 'firebase_options.dart';

import 'ui/root_page/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    child: MainApp(),
    create: (_) => RootBloc(),
  ));
}
