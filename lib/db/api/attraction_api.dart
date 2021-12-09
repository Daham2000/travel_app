/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/db/model/attraction.dart';

class AttractionApi {
  final CollectionReference attractionList =
      FirebaseFirestore.instance.collection('attraction');
  DocumentSnapshot documentSnapshot;

  Future<AttractionModel> getUsersList(
      {List<Attraction> list, DocumentSnapshot documentSnapshot}) async {
    List<Attraction> itemsList = [];
    AttractionModel attractionModel;
    try {
      if (list.isNotEmpty) {
        await attractionList
            .startAfterDocument(documentSnapshot)
            .limit(5)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((snapShot) {
            this.documentSnapshot = snapShot;
            itemsList.add(Attraction.fromMap(snapShot.data()));
          });
        });
      } else {
        await attractionList.limit(5).get().then((querySnapshot) {
          querySnapshot.docs.forEach((snapShot) {
            this.documentSnapshot = snapShot;
            itemsList.add(Attraction.fromMap(snapShot.data()));
          });
        });
      }
      attractionModel = new AttractionModel(itemsList, this.documentSnapshot);
      return attractionModel;
    } catch (e) {
      print("Firebase:-  " + e.toString());
      return null;
    }
  }

  Future searchAttraction(String query) async {
    List<Attraction> itemsList = [];
    try {
      await attractionList
          .where(
            "Title",
            isGreaterThanOrEqualTo:
                '${query[0].toUpperCase()}${query.substring(1)}',
          )
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((snapShot) {
          itemsList.add(Attraction.fromMap(snapShot.data()));
          print("searchAttraction:-  ${itemsList[0].title}");
        });
      });
      await attractionList
          .where(
            "District",
            isGreaterThanOrEqualTo:
                '${query[0].toUpperCase()}${query.substring(1)}',
          )
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((snapShot) {
          itemsList.add(Attraction.fromMap(snapShot.data()));
          print("searchAttraction:-  ${itemsList[0].title}");
        });
      });
      return itemsList;
    } catch (Exception) {
      print(Exception.toString());
      return null;
    }
  }
}
