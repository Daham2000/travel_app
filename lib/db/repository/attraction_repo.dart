import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/db/model/attraction.dart';

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
      youtubeId: "",
    ),
    Attraction(
      description:
          "A breathtaking waterfall surrounded by lush forests and scenic views.",
      district: "Niagara Falls",
      images: [
        "https://cdn.britannica.com/30/94430-050-D0FC51CD/Niagara-Falls.jpg"
      ],
      latLng: ["43.33063937797153", "-79.07029427262562"],
      shortDetail: "Majestic waterfalls on the US-Canada border.",
      title: "Niagara Falls",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A renowned museum housing an extensive collection of art and artifacts.",
      district: "Paris",
      images: [
        "https://media.architecturaldigest.com/photos/5900cc370638dd3b70018b33/16:9/w_2560%2Cc_limit/Secrets%2520of%2520Louvre%25201.jpg"
      ],
      latLng: ["48.86074510735849", "2.33764397932634"],
      shortDetail: "World-famous art museum in Paris.",
      title: "Louvre Museum",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A modern architectural masterpiece offering panoramic city views.",
      district: "Dubai",
      images: [
        "https://upload.wikimedia.org/wikipedia/en/thumb/9/93/Burj_Khalifa.jpg/1200px-Burj_Khalifa.jpg"
      ],
      latLng: ["25.19743967657877", "55.27435493809514"],
      shortDetail: "The tallest building in the world.",
      title: "Burj Khalifa",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A massive structure in Giza, one of the Seven Wonders of the Ancient World.",
      district: "Giza",
      images: [
        "https://upload.wikimedia.org/wikipedia/commons/e/e3/Kheops-Pyramid.jpg"
      ],
      latLng: ["29.979365636038597", "31.134215324781422"],
      shortDetail: "Ancient pyramid in Egypt.",
      title: "Great Pyramid of Giza",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A picturesque clock tower and one of London's most famous landmarks.",
      district: "London",
      images: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0wFiv81yZW2RvKQIUhQMso80aV0PMuLVacg&s"
      ],
      latLng: [],
      shortDetail: "Historic clock tower in London.",
      title: "Big Ben",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A tropical paradise with crystal-clear waters and stunning marine life.",
      district: "Maldives",
      images: [
        "https://miro.medium.com/v2/resize:fit:975/1*IOfsWfbO6xnXVXoqTqKy3w.jpeg"
      ],
      latLng: [],
      shortDetail: "Beautiful tropical islands in the Indian Ocean.",
      title: "Maldives Islands",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A large city square known for its significant historical events and landmarks.",
      district: "Beijing",
      images: [
        "https://cdn.britannica.com/59/129159-050-75E7FB3C/Tiananmen-end-Beijing.jpg"
      ],
      latLng: [],
      shortDetail: "Historic square in Beijing.",
      title: "Tiananmen Square",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A sprawling palace complex that showcases ancient Chinese architecture.",
      district: "Beijing",
      images: [
        "https://cdn.britannica.com/59/180959-050-54A641EE/Hall-of-Supreme-Harmony-Beijing-Forbidden-City.jpg"
      ],
      latLng: [],
      shortDetail: "Ancient palace in Beijing.",
      title: "Forbidden City",
      youtubeId: "",
    ),
    Attraction(
      description:
          "A stunning canyon carved by the Colorado River, offering breathtaking views.",
      district: "Arizona",
      images: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTct4kqJl6cqduGiWc9V8gn4km5z7xuJSBUqA&s"
      ],
      latLng: [],
      shortDetail: "Famous canyon in Arizona.",
      title: "Grand Canyon",
      youtubeId: "",
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
