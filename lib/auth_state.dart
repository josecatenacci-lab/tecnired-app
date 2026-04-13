import 'dart:async';
import 'auth_service.dart';

class AuthState {
  AuthState._();
  static final instance = AuthState._();
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get stream => _controller.stream;

  void notify() => _controller.add(AuthService.instance.isLoggedIn);
}