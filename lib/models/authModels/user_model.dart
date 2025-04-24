import '../generic/result_model.dart';

class User {
  final String? id;
  final String email;
  final String? password;
  final String? fullName;
  final String? state;
  final String? city;
  final String? locality;
  final String? token;

  User({
    this.token,
    this.id,
    required this.email,
    required this.password,
    this.fullName,
    this.state,
    this.city,
    this.locality,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token']?? '',
      id: json['_id']?? '',
      email: json['email']?? '',
      password: json['password']?? '',
      fullName: json['fullName']?? '',
      state: json['state']?? '',
      city: json['city']?? '',
      locality: json['locality']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token' : token,
      'email': email,
      '_id': id,
      'password': password,
      'fullName': fullName,
      'state': state,
      'city': city,
      'locality': locality,
    };
  }
}
