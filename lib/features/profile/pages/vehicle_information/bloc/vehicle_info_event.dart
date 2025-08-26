part of 'vehicle_info_bloc.dart';

@immutable
sealed class VehicleInfoEvent {}
final class VehicleInfoFetchEvent extends VehicleInfoEvent {}
