part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeOrderAcceptedState extends HomeState {}

final class ToggleOnShowOrderPopUpState extends HomeState {
  final AvailabilityResponse availabilityResponse;
  ToggleOnShowOrderPopUpState({required this.availabilityResponse});
}

final class ToggleError extends HomeActionState {}

final class MapLoadingState extends HomeState {}

final class MapLoadedState extends HomeState {}

final class MapErrorState extends HomeState {
  final String errorMessage;
  MapErrorState(this.errorMessage);
}
final class LiveLocationUpdated extends HomeState {
  final double lat;
  final double lng;
  final bool isAvailable; // ✅ Add this

  LiveLocationUpdated({
    required this.lat,
    required this.lng,
    required this.isAvailable,
  });
}
