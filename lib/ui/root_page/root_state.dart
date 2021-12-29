/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';

@immutable
class RootState {
  final String error;
  final bool isLoginSuccess;
  final bool isRegSuccess;
  final bool isLoading;

  RootState({
    this.error,
    this.isLoginSuccess,
    this.isRegSuccess,
    this.isLoading,
  });

  RootState.init()
      : this(
          error: null,
          isLoginSuccess: false,
          isRegSuccess: false,
          isLoading: false,
        );

  RootState clone({
    String error,
    bool isLoginSuccess,
    bool isRegSuccess,
    bool isLoading,
  }) {
    return RootState(
      error: error ?? this.error,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isRegSuccess: isRegSuccess ?? this.isRegSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static RootState get initialState => RootState(
        error: "",
        isLoginSuccess: false,
        isRegSuccess: false,
        isLoading: false,
      );
}
