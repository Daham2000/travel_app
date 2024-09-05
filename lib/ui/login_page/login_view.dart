/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/db/repository/user_repo.dart';
import 'package:travel_app/ui/home_page/home_provider.dart';
import 'package:travel_app/ui/login_page/login_bloc.dart';
import 'package:travel_app/ui/login_page/login_state.dart';
import 'package:travel_app/ui/root_page/widget/input_decoration.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:toastification/toastification.dart';
class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  final _formKey = GlobalKey<FormState>();
  final _loginKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  void loginUser() async {
    context.read<LoginBloc>().updateLoadingState(true);
    final userCredential = await Authentication()
        .login(email: emailCtrl.value.text, password: passCtrl.value.text);
    if (userCredential?.user != null) {
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: Text('Login Success, Loading...'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      Future.microtask(
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeProvider())),
      );
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text('Incorrect Email or Password.'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
    context.read<LoginBloc>().updateLoadingState(false);
  }

  void registerUser() async {
    context.read<LoginBloc>().updateLoadingState(true);
    final userCredential = await Authentication().registerUser(
        email: emailCtrl.value.text, password: passCtrl.value.text);
    if (userCredential?.user != null) {
      toastification.show(
        context: context,
        type: ToastificationType.success,
        title: Text('User Registration Success, Loading...'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      await userRepository.addUser(User(
          email: emailCtrl.value.text,
          firstName: firstNameCtrl.text,
          lastName: lastNameCtrl.text));
      Future.microtask(
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeProvider())),
      );
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text('User registration failed, Try again.'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
    context.read<LoginBloc>().updateLoadingState(false);
  }

  @override
  Widget build(BuildContext context) {
    final firstNameField = new TextFormField(
      controller: firstNameCtrl,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your first name';
        } else {
          firstName = value.trim();
        }
        return null;
      },
      decoration: customInputDecoration(
        hintText: "first name",
      ),
    );

    final lastNameField = new TextFormField(
      controller: lastNameCtrl,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your last name';
        } else {
          lastName = value.trim();
        }
        return null;
      },
      decoration: customInputDecoration(
        hintText: "last name",
      ),
    );

    final emailField = new TextFormField(
      controller: emailCtrl,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        } else {
          email = value.trim();
        }
        return null;
      },
      decoration: customInputDecoration(
        hintText: "Email",
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passCtrl,
      obscureText: true,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please input the password';
        } else if (value.length < 6) {
          return 'Please input at least 6 characters';
        } else {
          password = value;
        }
        return null;
      },
      decoration: customInputDecoration(
        hintText: "Password",
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 120.0,
          flexibleSpace: Image(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Image.asset(
                  ImageAssets.secondLogoPath,
                  width: 150,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (pre, current) => pre.isSearching != current.isSearching,
            builder: (context, state) {
              return TabBarView(
                children: [
                  if (state.isSearching == true)
                    Center(
                      child: Lottie.asset(
                        ImageAssets.loaderPath,
                        width: 100,
                      ),
                    )
                  else
                    ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _loginKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: emailField,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: passwordField,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: SafeArea(
                                  child: Container(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_loginKey.currentState!
                                            .validate()) {
                                          loginUser();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            side: BorderSide(
                                                color: Colors.blueAccent
                                                    .withOpacity(0.7))),
                                      ),
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Mulish"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (state.isSearching == true)
                    Center(
                      child: Lottie.asset(
                        ImageAssets.loaderPath,
                        width: 100,
                      ),
                    )
                  else
                    ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: firstNameField,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: lastNameField,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: emailField,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: passwordField,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SafeArea(
                                  child: Container(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          registerUser();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            side: BorderSide(
                                                color: Colors.blueAccent
                                                    .withOpacity(0.7))),
                                      ),
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Mulish"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Already do you have an account?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                ],
              );
            }),
      ),
    );
  }
}
