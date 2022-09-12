import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/config/storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Uninitialized()) {
    on<AppStarted>(_onAppStartedEvent);
    on<LoggedIn>(_onLoggedInEvent);
    on<LoggedOut>(_onLoggedoutEvent);
  }

  Future<void> _onAppStartedEvent(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    var token = await _getToken();
    if (token.isEmpty) {
      emit(Unauthenticated());
    }
    emit(Authenticated());
  }

  Future<String> _getToken() async {
    return await Storage().secureStorage.read(key: 'access_token') ?? '';
  }

  Future<void> _onLoggedInEvent(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    Storage().token = event.token;
    await _saveToken(event.token);
    emit(Authenticated());
  }

  Future<void> _saveToken(String token) async {
    return await Storage()
        .secureStorage
        .write(key: 'access_token', value: token);
  }

  Future<void> _onLoggedoutEvent(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    Storage().token = '';
    await _deleteToken();
  }

  Future<void> _deleteToken() async {
    return await Storage().secureStorage.delete(key: 'access_token');
  }
}
