/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';

InputDecoration customInputDecoration({String hintText}){
  return InputDecoration(
    hintText: hintText,
    labelText: hintText,
    contentPadding:EdgeInsets.only(top: 20,bottom: 15,left: 5),
    filled: true,
    errorStyle: TextStyle(
      color: Colors.redAccent
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    hintStyle: TextStyle(
      fontSize: 18,
      fontFamily: "Avenir",
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    fillColor: Colors.white.withOpacity(0.15),
  );
}