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
          "Sigiriya or Sinhagiri (Lion Rock Sinhala: සීගිරිය, Tamil: சிகிரியா/சிங்ககிரி, "
          "pronounced SEE-gi-ri-yə) is an ancient rock fortress located in the "
          "northern Matale District near the town of Dambulla in the Central Province, "
          "Sri Lanka. It is a site of historical and archaeological significance that "
          "is dominated by a massive column of granite approximately 180 m (590 ft) "
          "high.[2 According to the ancient Sri Lankan chronicle the Cūḷavaṃsa, this"
          " area was a large forest, then after storms and landslides it became a "
          "hill and was selected by King Kashyapa (AD 477–495) for his new capital. "
          "He built his palace on top of this rock and decorated its sides with colourful"
          " frescoes. On a small plateau about halfway up the side of this rock he built a gateway "
          "in the form of an enormous lion. The name of this place is derived from this structure; "
          "Siṃhagiri, the Lion Rock.",
      district: "Anuradhapura",
      images: ["https://en.wikipedia.org/wiki/File:Sigiriya_(141688197).jpeg"],
      latLng: ["41.89036192065038", "12.49224162552444"],
      shortDetail: "Ancient City of Sigiriya.",
      title: "Sigiriya",
      youtubeId:
          "https://www.youtube.com/watch?v=TzTFIu25eHA&ab_channel=UNESCO",
      comments: [
        Comment(
            userName: "John Cick",
            userEmail: "",
            commentDescription:
                "Sigiriya is truly a marvel of ancient engineering and artistry. The advanced technology used to"
                " build this fortress is simply mind-boggling. From the intricate water gardens to the rock-carved architecture and "
                "polished Mirror Wall, the builders of Sigiriya were truly ahead of their time. The fact that the irrigation system"
                " still works to this day is a testament to the ingenuity and skill of the ancient Sri Lankan people.",
            commentTime: DateTime.now())
      ],
    ),
    Attraction(
      description: "",
      district: "Kandy",
      images: [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Front_view_of_Temple_of_the_Tooth%2C_Kandy.jpg/432px-Front_view_of_Temple_of_the_Tooth%2C_Kandy.jpg"
      ],
      latLng: ["41.89036192065038", "12.49224162552444"],
      shortDetail: "Ancient City of Kandy.",
      title: "Kandy City",
      youtubeId:
          "https://www.youtube.com/watch?v=b8EnvKNjz_8&ab_channel=SkyTravel",
      comments: [
        Comment(
          userName: "Harindu Niranjan",
          userEmail: "",
          commentDescription:
              "Yes Kandy is tradition it is art it is everything Kandy you know I love you Kandy.",
          commentTime: DateTime.now(),
        ),
        Comment(
          userName: "shajimb kime",
          userEmail: "",
          commentDescription:
          "We r coming to sri lanka end of August 2024.. Looking for a local person for Info's... 😊.",
          commentTime: DateTime.now(),
        ),
        Comment(
          userName: "Felix-o3m4o",
          userEmail: "",
          commentDescription:
          "Oh Kandy. My beautiful hometown there are so many attractive places.",
          commentTime: DateTime.now(),
        )
      ],
    ),
  ];

  void addAll() {
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
      QuerySnapshot snapshot =
          await _attractionCollection.orderBy("Title").limit(5).get();
      return snapshot.docs
          .map((doc) => Attraction.fromJson(doc.data()))
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
          .where((c) =>
              c["Title"].toString().toLowerCase().contains(value.toLowerCase()))
          .map(((doc) =>
              Attraction.fromJson(doc.data() as Map<String, dynamic>)))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }

  Future<List<Attraction>> loadWithPagination(Attraction value) async {
    try {
      final objectDocument = await _attractionCollection
          .where("Title", isEqualTo: value.title)
          .limit(1)
          .get();
      print(objectDocument.docs.length);
      QuerySnapshot snapshot = await _attractionCollection
          .orderBy("Title")
          .startAfterDocument(objectDocument.docs[0])
          .limit(5)
          .get();
      return snapshot.docs
          .map((doc) => Attraction.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw e;
    }
  }
}
