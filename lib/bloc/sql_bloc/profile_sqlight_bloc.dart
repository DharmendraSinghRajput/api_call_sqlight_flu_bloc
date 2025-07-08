import 'package:api_call_sqlight_flu_bloc/bloc/sql_bloc/profile_sqlight_event.dart';
import 'package:api_call_sqlight_flu_bloc/bloc/sql_bloc/profile_sqlight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/register_user_repository.dart';
import '../../utils/showToast.dart';

class ProfileSqlightBloc extends Bloc<ProfileSqlightEvent, ProfileSqlightState> {
  ProfileSqlightBloc() : super(ProfileInitialState()) {
    on<AddUserEvent>((event, emit) async {
      showToast("User added successfully"+event.user.lastName);
      emit(UserLoadingState());
      try {
        await UserRepository().registerUser(event.user);
        final users = await UserRepository().getAllUsers();
        emit(UserSuccessState(users));
      } catch (e) {
        emit(UserErrorState('Registration Failed'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final success = await UserRepository().loginUser(event.email, event.password);
        if (success) {
          final users = await UserRepository().getAllUsers(); // Optional
          emit(UserSuccessState(users));
        } else {
          emit(UserErrorState("Invalid email or password"));
        }
      } catch (e) {
        emit(UserErrorState("Login failed: ${e.toString()}"));
      }
    });

/*  ProfileSqlightBloc() : super(ProfileInitialState()) {
    on<ProfileSqlightEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await UserRepository().getAllUsers();
        emit(UserSuccessState(users));
      } catch (e) {
        emit(UserErrorState("Failed to load users: ${e.toString()}"));
      }
    });*/

/*    // Add a new user
    on<AddUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        AppLogger().info('ProfileBloc', 'User added: ${event.user}');
        await UserRepository().registerUser(event.user);
        final users = await UserRepository().getAllUsers();
        emit(UserSuccessState(users));
       // showToast("User added successfully"+event.user.firstName);

      } catch (e) {
        emit(UserErrorState("Failed to add user: ${e.toString()}"));
      }
    });*/

    // Delete a user
/*    on<DeleteUser>((event, emit) async {
      emit(UserLoading());
      try {
        await repository.removeUser(event.id);
        final users = await repository.getAllUsers();
        emit(UserSuccess(users)); // Emit updated user list
      } catch (e) {
        emit(UserError("Failed to delete user: ${e.toString()}"));
      }
    });*/
  }
}