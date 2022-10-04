class Vehicles {
  String type;
  String documentId;
  String description;
  String capacity;
  String dimension;
  String image;
  List extraService;

  Vehicles({
    required this.documentId,
    required this.type,
    required this.description,
    required this.capacity,
    required this.dimension,
    required this.image,
    required this.extraService,
  });
}

class LocationList {
  String name;
  String location;
  LocationList({
    required this.name,
    required this.location,
  });
}
