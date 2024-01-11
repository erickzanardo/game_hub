import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:nes_ui/nes_ui.dart';

class CrudView<T> extends ConsumerWidget {
  const CrudView({
    required this.title,
    required this.repository,
    required this.listItemBuilder,
    required this.crudContext,
    this.actionsBuilder,
    super.key,
  });

  const CrudView.root({
    required this.title,
    required this.repository,
    required this.listItemBuilder,
    this.actionsBuilder,
    super.key,
  }) : crudContext = const RootCrudContext();

  final String title;
  final CrudRepositoryAdapter<T> repository;
  final CrudContext crudContext;
  final Widget Function(BuildContext, T) listItemBuilder;
  final List<Widget> Function(BuildContext, T)? actionsBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(
      crudListProvider(
        adapter: repository,
        crudContext: crudContext,
      ),
    );

    return Scaffold(
      body: listState.when(
        data: (items) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: NesContainer(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Divider(),
                    Expanded(
                      child: NesSingleChildScrollView(
                        child: Column(
                          children: [
                            for (final item in items)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: NesContainer(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: listItemBuilder(context, item),
                                      ),
                                      NesIconButton(icon: NesIcons.remove),
                                      if (actionsBuilder != null)
                                        ...actionsBuilder!(context, item),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      ),
    );
  }
}
