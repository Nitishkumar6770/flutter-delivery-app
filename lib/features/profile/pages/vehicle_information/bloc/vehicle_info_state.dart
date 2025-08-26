part of 'vehicle_info_bloc.dart';

@immutable
sealed class VehicleInfoState {}

final class VehicleInfoInitial extends VehicleInfoState {}

final class VehicleInfoLoading extends VehicleInfoState {}

final class VehicleInfoLoaded extends VehicleInfoState {
  final VehicleInfoResponse vehicleInfoResponse;
  VehicleInfoLoaded({required this.vehicleInfoResponse});
}

final class VehicleInfoError extends VehicleInfoState {
  final String errorMessage;
  VehicleInfoError({required this.errorMessage});
}
