/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';

@immutable
abstract class RootEvent {}

class RegisterUserEvent extends RootEvent {
  final String name;
  final String password;

  RegisterUserEvent({required this.name, required this.password});
}

class LoginEvent extends RootEvent{
  final bool isAutoLogin;
  final String name;
  final String password;
  LoginEvent({required this.isAutoLogin,required this.name,required this.password});
}

class ClearEvent extends RootEvent{}
