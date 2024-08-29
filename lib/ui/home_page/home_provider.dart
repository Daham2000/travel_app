/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc.dart';
import 'home_view.dart';

class HomeProvider extends BlocProvider<HomeBloc> {
  HomeProvider({Key? key})
      : super(
          key: key,
          create: (context) => HomeBloc(context),
          child: HomeView(),
        );
}
