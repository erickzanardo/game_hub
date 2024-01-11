import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: NesContainer(
            width: 600,
            child: Column(
              children: [
                Text(
                  'Admin Dashboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                NesButton(
                  type: NesButtonType.primary,
                  onPressed: () {
                    context.go('/admin/games');
                  },
                  child: const Text('Games'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
