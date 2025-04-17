class Validation {
  final String? validationType;
  final String? message;

  Validation({this.validationType, this.message});

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
      validationType: json['validationType'],
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'validationType': validationType,
      'message': message,
    };
  }
}
