class VehicleInfoResponse {
  final String message;
  final Vehicle driver;

  VehicleInfoResponse({
    required this.message,
    required this.driver,
  });

  factory VehicleInfoResponse.fromJson(Map<String, dynamic> json) {
    return VehicleInfoResponse(
      message: json['message'],
      driver: Vehicle.fromJson(json['driver']),
    );
  }
}

class Vehicle {
  final String id;
  final String cityName;
  final String vehicleRc;
  final String vehicleType;

  Vehicle({
    required this.id,
    required this.cityName,
    required this.vehicleRc,
    required this.vehicleType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      cityName: json['cityName'],
      vehicleRc: json['vehicleRc'],
      vehicleType: json['vehicleType'],
    );
  }
}
