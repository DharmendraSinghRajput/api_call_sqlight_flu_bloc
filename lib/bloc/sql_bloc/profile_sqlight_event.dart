import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // for @immutable

import '../../model/User.dart';

@immutable
sealed class ProfileSqlightEvent extends Equatable {
  const ProfileSqlightEvent(); // Add a const constructor
}

// Add user event
final class AddUserEvent extends ProfileSqlightEvent {
  final User user;
  const AddUserEvent(this.user); // Use const constructor
  @override
  List<Object?> get props => [user];
}

// Login event
final class LoginEvent extends ProfileSqlightEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

// Delete user event
final class DeleteUserEvent extends ProfileSqlightEvent {
  final int id;

  const DeleteUserEvent(this.id);

  @override
  List<Object?> get props => [id];
}
