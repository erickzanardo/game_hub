import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/domain/domain.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: authState.when(
        data: (authStatus) {
          if (authStatus == AuthStatus.authenticated) {
            return const Center(
              child: Text('Authenticated'),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const Text('Unauthenticated'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(authStateProvider.notifier).authenticate();
                    },
                    child: const Text('Log with google'),
                  ),
                ],
              ),
            );
          }
        },
        error: (err, stack) => Center(
          child: Text(err.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
