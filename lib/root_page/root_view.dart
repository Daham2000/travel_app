/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/home_page/home_provider.dart';

import 'root_bloc.dart';
import 'root_event.dart';
import 'root_state.dart';
import 'sub_page/login_provider.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  String email;
  String name;
  String password;
  // ignore: close_sinks
  RootBloc rootBloc;

  @override
  void initState() {
    rootBloc = BlocProvider.of<RootBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (pre, current) =>
          pre.error != current.error ||
          pre.isLoading != current.isLoading ||
          pre.isLoginSuccess != current.isLoginSuccess,
      builder: (context, state) {
        if(state.error=="User not available" && state.isLoginSuccess==false){
          rootBloc.add(ClearEvent());
          print("Navigating to Login page...");
          Future.microtask(
                () =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginProvider())),
          );
        }else if(state.isLoginSuccess==true){
          print("Navigating to Home page...");
          rootBloc.add(ClearEvent());
          Future.microtask(
                () =>
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeProvider())),
          );
        }
        return Scaffold();
      },
    );
  }
}
