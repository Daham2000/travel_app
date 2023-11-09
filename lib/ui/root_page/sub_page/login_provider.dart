/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../root_bloc.dart';
import 'login_view.dart';

class LoginProvider extends BlocProvider<RootBloc> {
  LoginProvider({Key? key})
      : super(
          key: key,
          create: (context) => RootBloc(context,isLogin: false),
          child: LoginView(),
        );
}
