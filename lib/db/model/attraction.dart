/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class Attraction {
  String title;
  String image;
  String shortDetail;
  String description;
  String youtubeID;
  String district;
  List<dynamic> latLng;

  Attraction({this.latLng,this.title, this.image, this.shortDetail, this.description,this.youtubeID,this.district});

  Attraction.fromMap(Map<String, dynamic> data) {
    title = data['Title'];
    image = data['Image'];
    shortDetail = data['Short Detail'];
    description = data['Description'];
    youtubeID = data['youtubeID'];
    district = data['District'];
    latLng = data['LatLng'];
  }
}

class AttractionModel{
  final List<Attraction> list;
  final DocumentSnapshot documentSnapshot;

  AttractionModel(this.list, this.documentSnapshot);
}