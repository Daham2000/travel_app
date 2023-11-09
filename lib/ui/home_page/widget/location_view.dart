/*
 * Copyright (c) FutureSoft 2021  
 * Author: Daham
 *  
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatefulWidget {
  final List<dynamic> latLng;

  LocationView({required this.latLng});

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  GoogleMapController? mapController;

  LatLng? _center;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _center =
        LatLng(double.parse(widget.latLng[0]), double.parse(widget.latLng[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center ?? LatLng(double.parse(widget.latLng[0]), double.parse(widget.latLng[1])),
          zoom: 11.0,
        ),
      ),
    );
  }
}
