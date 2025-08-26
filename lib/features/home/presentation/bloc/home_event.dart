part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class OrderAcceptedEvent extends HomeEvent {}
final class UpdateDriverLocation extends HomeEvent {}
final class OrderReejected extends HomeEvent {}
final class ToggleAvailability extends HomeEvent {}

