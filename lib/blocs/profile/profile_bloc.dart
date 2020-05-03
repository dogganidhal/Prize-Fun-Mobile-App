import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_prize/blocs/profile/profile_event.dart';
import 'package:fun_prize/blocs/profile/profile_state.dart';
import 'package:fun_prize/exceptions/auth.dart';
import 'package:fun_prize/service/auth_service.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthService _authService = AuthService();

  @override
  ProfileState get initialState => ProfileState(isLoading: false);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      yield ProfileState(isLoading: true);
      final user = await _authService.loadCurrentUser();
      yield ProfileState(isLoading: false, user: user);
    }

    if (event is EditProfileEvent) {
      yield ProfileState(
        isLoading: true,
        user: state.user
      );
      try {
        await _authService.updateUser(
          email: event.email,
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          address: event.address,
          age: event.age
        );
        yield ProfileState(
          isLoading: false,
          user: state.user
        );
      } on AuthException catch (exception) {
        debugPrint(exception.toString());
      }
    }
  }
}