/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'root_bloc.dart';
import 'root_view.dart';

class RootProvider extends BlocProvider<RootBloc> {
  RootProvider({
    Key? key
  }) : super (
    key: key,
    create: (context) => RootBloc(context,isLogin: true),
    child: RootView(),
  );
}