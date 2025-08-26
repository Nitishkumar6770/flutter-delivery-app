class AvailabilityResponse {
  final String message;
  final bool isAvailable;

  AvailabilityResponse({
    required this.message,
    required this.isAvailable,
  });

  factory AvailabilityResponse.fromJson(Map<String, dynamic> json) {
    return AvailabilityResponse(
      message: json['message'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isAvailable': isAvailable,
    };
  }
}
