class Money {
  final String currency;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  Money({
    required this.currency,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      currency: json['Currency'],
      price: double.tryParse(json['Price'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'Currency': currency,
    'Price': price,
    'CreatedAt': createdAt.toIso8601String(),
    'UpdatedAt': updatedAt.toIso8601String(),
  };
}
