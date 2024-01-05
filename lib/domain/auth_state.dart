import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

@riverpod
class AuthState extends _$AuthState {

  @override
  Future<AuthStatus> build() async {
    return AuthStatus.unauthenticated;
  }

  Future<void> authenticate() async {
    state = const AsyncValue.loading();

    state = const AsyncValue.data(AuthStatus.authenticated);
  }
}
