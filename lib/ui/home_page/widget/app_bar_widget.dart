/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:travel_app/utill/styled_colors.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            StyledColor.BACKGROUND_COLOR_ONE,
            StyledColor.BACKGROUND_COLOR_ONE
          ],
        ),
      ),
    );
  }
}
