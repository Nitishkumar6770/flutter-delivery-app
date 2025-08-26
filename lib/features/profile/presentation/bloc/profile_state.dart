part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final DriverProfileResponse driver;
  ProfileLoaded({required this.driver});
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
