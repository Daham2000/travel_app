import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/login_page/login_bloc.dart';
import 'package:travel_app/ui/login_page/login_view.dart';

class LoginProvider extends BlocProvider<LoginBloc> {
  LoginProvider({Key? key})
      : super(
          key: key,
          create: (context) => LoginBloc(),
          child: LoginView(),
        );
}
