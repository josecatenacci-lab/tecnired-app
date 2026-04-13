import 'dart:async';
import 'auth_service.dart';

class AuthState {
  AuthState._();
  static final instance = AuthState._();

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get stream => _controller.stream;

  void notify() {
    if (!_controller.isClosed) {
      _controller.add(AuthService.instance.isLoggedIn);
    }
  }

void init() {
  _controller.add(AuthService.instance.isLoggedIn);
}

  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}