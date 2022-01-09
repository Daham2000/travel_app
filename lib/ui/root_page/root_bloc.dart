/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/db/api/user_api.dart';
import 'package:travel_app/db/auth/authentication.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(BuildContext context,{bool isLogin = false}) : super(RootState.initialState) {
    if(isLogin){
      add(LoginEvent(isAutoLogin: true));
    }
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case ClearEvent:
        yield state.clone(
          error: "",
          isLoading: false,
          isLoginSuccess: false,
        );
        break;

      case RegisterUserEvent:
        yield state.clone(isLoading: true, error: "");
        final data = event as RegisterUserEvent;
        UserCredential response = await Authentication().registerUser(
          email: data.name,
          password: data.password,
        );
        if (response.user.email != null) {
          yield state.clone(isRegSuccess: true, isLoading: false);
        } else {
          yield state.clone(
            isLoginSuccess: false,
            isLoading: false,
            error: "Registration unsuccessful...",
          );
        }
        break;

      case LoginEvent:
        final data = event as LoginEvent;
        yield state.clone(isLoading: true, error: "");
        if (data.isAutoLogin == false) {
          UserCredential response = await Authentication().login(
            email: data.name,
            password: data.password,
          );
          if(response==null){
            print("User not available");
            yield state.clone(
              isLoginSuccess: false,
              isLoading: false,
              error: "User not available",
            );
          }else{
            if (response.user != null) {
              final String token = await auth.currentUser.getIdToken();
              final userModel = await UserAPI().loginUser(token);
              if (response.user.email != null) {
                yield state.clone(
                  isLoginSuccess: true,
                  isLoading: false,
                  userModel: userModel,
                );
              }
            }else {
              yield state.clone(
                isLoginSuccess: false,
                isLoading: false,
                error: "User not available",
              );
            }
          }

        } else {
          User user = await Authentication().getLoggedUser();
          if (user != null) {
            if (user.email != null) {
              final String token = await auth.currentUser.getIdToken();
              final userModel = await UserAPI().loginUser(token);
              print("Avalible user...");
              yield state.clone(
                isLoginSuccess: true,
                isLoading: false,
                error: "User available",
                userModel: userModel
              );
            } else {
              yield state.clone(
                isLoginSuccess: true,
                isLoading: false,
              );
            }
          } else {
            yield state.clone(
              isLoginSuccess: false,
              isLoading: false,
              error: "User not available",
            );
          }
        }
        break;
    }
  }
}
