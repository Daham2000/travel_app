import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/db/repository/trip_repo.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();

  factory UserRepository() {
    return instance;
  }

  UserRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _userCollection => _firestore.collection('users');

  // Add a new user to Firestore
  Future<void> addUser(User user) async {
    try {
      await _userCollection.add(user.toMap());
    } catch (e) {
      print('Error adding user: $e');
      throw e; // Rethrow the exception if needed
    }
  }

  // Update an existing user in Firestore
  Future<void> updateUser(String documentId, User user) async {
    try {
      await _userCollection.doc(documentId).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  }

  // Future<void> setUserID() async {
  //   final querySnapshot = await _userCollection.get();
  //   User u;
  //
  //   querySnapshot.docs.forEach((element) {
  //     u = User.fromMap(element.data() as Map<String, dynamic>);
  //     u.id = element.id;
  //     _userCollection.doc(element.id).update(u.toMap());
  //   });
  // }

  // Delete a user from Firestore
  Future<void> deleteUser(String documentId) async {
    try {
      await _userCollection.doc(documentId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw e;
    }
  }

  // Fetch a user from Firestore by document ID
  Future<User?> getUserById(String documentId) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(documentId).get();
      if (doc.exists) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      throw e;
    }
  }

  Future<User> getUserByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _userCollection.get();
      return snapshot.docs
          .where((c) =>
              c["email"].toString().toLowerCase() == (email.toLowerCase()))
          .map((e) => User.fromMap(e.data() as Map<String, dynamic>))
          .toList()[0];
    } catch (e) {
      print('Error fetching user: $e');
      throw e;
    }
  }

  // Fetch all users from Firestore
  Future<List<User>> getAllUsers() async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      QuerySnapshot snapshot = await _userCollection.get();
      return snapshot.docs
          .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
          .toList()
          .where((ele) => ele.email != email)
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }

  Future<void> inviteUserToTrip(List<User> users, String tripId) async {
    try {
      users.forEach((ele) async {
        if (ele.invitations.where((t) => t.email == tripId).isEmpty) {
          ele.invitations.add(Invitation(email: tripId, accepted: false));
        }
        await _userCollection.doc(ele.id).update(ele.toMap());
      });
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }

  Future<void> acceptInvitation(String userID, String tripId) async {
    try {
      final User? user = await getUserById(userID);
      List<Invitation> invitations = user?.invitations ?? [];
      Invitation tt =
          invitations.where((t) => t.email == tripId).toList().first;
      tt.accepted = true;
      final lis = invitations.where((t) => t.email != tripId).toList();
      lis.add(tt);
      user?.invitations = lis;
      await updateUser(userID, user!);
      TripRepository tripRepository = TripRepository();
      final trip = await tripRepository.getTripById(tripId);
      trip?.users.add(userID);
      await tripRepository.updateTripPlan(trip!);
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }
}
