class Trainer {
  final String id;
  String name;
  String specialty;
  String bio;
  String photoUrl;
  double rating;
  List<String> classes; // List of class names or IDs

  Trainer({
    required this.id,
    required this.name,
    required this.specialty,
    required this.bio,
    required this.photoUrl,
    this.rating = 0.0,
    List<String>? classes,
  }) : classes = classes ?? [];

  void updateProfile({
    String? name,
    String? specialty,
    String? bio,
    String? photoUrl,
    double? rating,
  }) {
    if (name != null) this.name = name;
    if (specialty != null) this.specialty = specialty;
    if (bio != null) this.bio = bio;
    if (photoUrl != null) this.photoUrl = photoUrl;
    if (rating != null) this.rating = rating;
  }

  void addClass(String className) {
    if (!classes.contains(className)) {
      classes.add(className);
    }
  }

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      bio: json['bio'] as String,
      photoUrl: json['photoUrl'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      classes: (json['classes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'bio': bio,
      'photoUrl': photoUrl,
      'rating': rating,
      'classes': classes,
    };
  }
}
