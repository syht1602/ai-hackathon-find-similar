import 'dart:convert';

class Car {
  Car({
    required this.id,
    required this.title,
    required this.badge,
    required this.price,
    required this.currency,
    required this.marketShare,
    required this.photos,
    required this.tags,
    required this.details,
  });

  final String id;
  final String title;
  final String badge; // "New" or "Old"
  final num price;
  final String currency;
  final num marketShare;
  final List<String> photos;
  final List<String> tags;
  final Map<String, dynamic> details; // flexible structure for later parsing

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String,
      title: json['title'] as String,
      badge: json['badge'] as String? ?? '',
      price: json['price'] as num,
      currency: json['currency'] as String? ?? 'USD',
      marketShare: json['marketShare'] as num? ?? 0,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      details: (json['details'] as Map<String, dynamic>?) ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'badge': badge,
    'price': price,
    'currency': currency,
    'marketShare': marketShare,
    'photos': photos,
    'tags': tags,
    'details': details,
  };

  static List<Car> listFromJson(String jsonStr) {
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Car.fromJson(e as Map<String, dynamic>)).toList();
  }
}
