import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/crud/providers/form.dart';
import 'package:game_hub/crud/repository.dart';
import 'package:nes_ui/nes_ui.dart';

class CrudForm<T> extends ConsumerWidget {
  const CrudForm({
    required this.repository,
    required this.crudContext,
    this.id,
    super.key,
  });

  final String? id;
  final CrudRepositoryAdapter<T> repository;
  final CrudContext crudContext;

  static Future<void> show<T>(
    BuildContext context, {
    required CrudRepositoryAdapter<T> repository,
    required CrudContext crudContext,
    String? id,
  }) async {
    await NesDialog.show(
      context: context,
      builder: (_) {
        return CrudForm(
          id: id,
          repository: repository,
          crudContext: crudContext,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = crudFormProvider(
      adapter: repository,
      crudContext: crudContext,
      id: id,
    );
    final formState = ref.watch(provider);

    return formState.when(
      data: (state) {
        return SizedBox(
          width: 600,
          child: Column(
            children: [
              for (final field in state.fields)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: state.values[field.field]?.value,
                    onChanged: (value) {
                      ref.read(provider.notifier).updateValue(
                            field: field.field,
                            value: value,
                          );
                    },
                    decoration: InputDecoration(
                      labelText: field.label,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NesButton(
                    type: NesButtonType.normal,
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                  NesButton(
                    type: NesButtonType.primary,
                    child: const Text('Save'),
                    onPressed: () async {
                      ref.read(provider.notifier).save();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
      error: (err, stack) {
        return Center(
          child: Text(err.toString()),
        );
      },
      loading: () => const Center(
        child: NesPixelRowLoadingIndicator(),
      ),
    );
  }
}
