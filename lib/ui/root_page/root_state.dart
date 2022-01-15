/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:travel_app/db/model/user.dart';

@immutable
class RootState {
  final String error;
  final bool isLoginSuccess;
  final bool isRegSuccess;
  final bool isLoading;
  final User userModel;

  RootState({
    this.error,
    this.isLoginSuccess,
    this.isRegSuccess,
    this.isLoading,
    this.userModel,
  });

  RootState.init()
      : this(
          error: null,
    userModel: null,
          isLoginSuccess: false,
          isRegSuccess: false,
          isLoading: false,
        );

  RootState clone({
    String error,
    bool isLoginSuccess,
    bool isRegSuccess,
    bool isLoading,
    User userModel,
  }) {
    return RootState(
      error: error ?? this.error,
      userModel: userModel ?? this.userModel,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isRegSuccess: isRegSuccess ?? this.isRegSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static RootState get initialState => RootState(
        error: "",
        userModel: null,
        isLoginSuccess: false,
        isRegSuccess: false,
        isLoading: false,
      );
}
