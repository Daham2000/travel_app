/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'root_page/main_app.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}
