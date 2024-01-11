import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<Session?> build() async {
    final authRepository = ref.read(authRepositoryProvider());
    final session = await authRepository.currentUser();

    final sub = authRepository.authStateChanges.listen((newUser) async {
      final user = await newUser;
      state = AsyncValue.data(user);
    });

    ref.onDispose(() {
      sub.cancel();
    });

    return session;
  }

  Future<void> authenticate() async {
    state = const AsyncValue.loading();

    final authRepository = ref.read(authRepositoryProvider());
    await authRepository.authenticate();
  }
}
