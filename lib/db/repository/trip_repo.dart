import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/db/model/trip.dart';

class TripRepository {
  static final TripRepository instance = TripRepository._internal();

  factory TripRepository() {
    return instance;
  }

  TripRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _tripCollection => _firestore.collection('trips');

  Future<bool> addTripPlan(Trip trip) async {
    try {
      final user = FirebaseAuth.instance.currentUser?.email;
      trip.users = [user.toString()];
      final doc = await _tripCollection.add(trip.toMap());
      trip.id = doc.id;
      _tripCollection.doc(doc.id).update(trip.toMap());
      return true;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  Future<List<Trip>> getAllTripPlans() async {
    try {
      QuerySnapshot snapshot = await _tripCollection.get();
      return snapshot.docs
          .map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching Trips: $e');
      throw e;
    }
  }
}
