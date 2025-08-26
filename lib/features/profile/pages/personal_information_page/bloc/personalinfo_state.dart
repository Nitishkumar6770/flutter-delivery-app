part of 'personalinfo_bloc.dart';

@immutable
sealed class PersonalinfoState {}

final class PersonalinfoInitial extends PersonalinfoState {}

final class PersonalinfoLoading extends PersonalinfoState {}

final class PersonalinfoLoaded extends PersonalinfoState {
  final PersonalInfoResponse personalInfoResponse;
  PersonalinfoLoaded({required this.personalInfoResponse});
}

final class PersonalinfoError extends PersonalinfoState {
  final String errormessage;
  PersonalinfoError({required this.errormessage});
}
