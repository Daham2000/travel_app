/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'root_bloc.dart';
import 'root_provider.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp= MaterialApp(
      title: 'MAYTH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootProvider(),
    );
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RootBloc>(create: (context) => RootBloc(context)),
      ],
      child: materialApp,
    );
  }
}
