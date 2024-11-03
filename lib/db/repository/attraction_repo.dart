import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/comment.dart';

class AttractionRepo {
  static final AttractionRepo instance = AttractionRepo._internal();

  factory AttractionRepo() {
    return instance;
  }

  List<Attraction> sampleAttractions = [
    Attraction(
      description:
          "The ancient ruins of the Roman Colosseum, a historical marvel.",
      district: "Central Rome",
      images: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Colosseo_2020.jpg/1200px-Colosseo_2020.jpg"
      ],
      latLng: ["41.89036192065038", "12.49224162552444"],
      shortDetail: "Iconic ancient amphitheater in Rome.",
      title: "Colosseum",
      youtubeId: "", comments: [
        Comment(userEmail: "", commentDescription: "")
    ],
    ),
  ];

  addAll() {
    for (int i = 0; i < sampleAttractions.length; i++) {
      addAttraction(sampleAttractions[i]);
    }
  }

  AttractionRepo._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _attractionCollection =>
      _firestore.collection('attractions');

  Future<void> addAttraction(Attraction model) async {
    try {
      await _attractionCollection.add(model.toJson());
    } catch (e) {
      print('Error adding user: $e');
      throw e; // Rethrow the exception if needed
    }
  }

  Future<List<Attraction>> getALl() async {
    try {
      QuerySnapshot snapshot = await _attractionCollection.orderBy("Title").limit(5).get();
      return snapshot.docs
          .map((doc) => Attraction.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }

  Future<List<Attraction>> getALlByName(String value) async {
    try {
      QuerySnapshot snapshot = await _attractionCollection.get();
      return snapshot.docs
          .where((c) => c["Title"].toString().toLowerCase().contains(value.toLowerCase())).map(((doc) => Attraction.fromJson(doc.data() as Map<String, dynamic>)))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }

  Future<List<Attraction>> loadWithPagination(Attraction value) async {
    try {
      final objectDocument = await _attractionCollection.where("Title", isEqualTo: value.title).limit(1).get();
      print(objectDocument.docs.length);
      QuerySnapshot snapshot = await _attractionCollection.orderBy("Title").startAfterDocument(objectDocument.docs[0]).limit(5).get();
      return snapshot.docs
          .map((doc) => Attraction.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }
}
