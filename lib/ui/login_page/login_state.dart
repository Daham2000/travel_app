/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';

@immutable
class LoginState {
  final bool? isSearching;

  LoginState({
    required this.isSearching,
  });

  LoginState.init()
      : this(
          isSearching: false,
        );

  LoginState clone({
    bool? isSearching,
  }) {
    return LoginState(
      isSearching: isSearching ?? this.isSearching,
    );
  }

  static LoginState get initialState => LoginState(
        isSearching: false,
      );

}
