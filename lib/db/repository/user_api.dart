import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/db/model/user.dart';

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

  // Fetch all users from Firestore
  Future<List<User>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await _userCollection.get();
      return snapshot.docs
          .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }
}
