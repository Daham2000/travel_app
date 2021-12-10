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
  final bool isLoading;

  RootState({
    this.error,
    this.isLoginSuccess,
    this.isLoading,
  });

  RootState.init()
      : this(
          error: null,
          isLoginSuccess: false,
          isLoading: false,
        );

  RootState clone({
    String error,
    bool isLoginSuccess,
    bool isLoading,
  }) {
    return RootState(
      error: error ?? this.error,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static RootState get initialState => RootState(
        error: "",
        isLoginSuccess: false,
        isLoading: false,
      );
}
