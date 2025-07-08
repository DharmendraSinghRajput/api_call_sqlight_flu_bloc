import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // for @immutable

import '../../model/User.dart';

@immutable
sealed class ProfileSqlightState extends Equatable {
  const ProfileSqlightState(); // Required for const constructors in subclasses
}

// Initial state
final class ProfileInitialState extends ProfileSqlightState {
  const ProfileInitialState();

  @override
  List<Object?> get props => [];
}

// Loading state
final class UserLoadingState extends ProfileSqlightState {
  const UserLoadingState();

  @override
  List<Object?> get props => [];
}

// Success state with list of users
final class UserSuccessState extends ProfileSqlightState {
  final List<User> users;
  const UserSuccessState(this.users);
  @override
  List<Object?> get props => [users];
}

// Login success state
final class UserSuccessLoginState extends ProfileSqlightState {
  final String email;
  final String password;

  const UserSuccessLoginState(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Error state
final class UserErrorState extends ProfileSqlightState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
