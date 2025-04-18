import '../generic/result_model.dart';

class User {
  final String? id;
  final String email;
  final String? password;
  final String? fullName;
  final String? state;
  final String? city;
  final String? locality;
  final Result? result;
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
    this.result,
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
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
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
      'result': result?.toJson(),
    };
  }
}
