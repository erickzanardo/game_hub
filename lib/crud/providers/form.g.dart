// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$crudFormHash() => r'37309ac64eec9802276b3e633280d0ca63032255';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CrudForm
    extends BuildlessAutoDisposeAsyncNotifier<CrudFormState> {
  late final CrudRepositoryAdapter<dynamic> adapter;
  late final CrudContext crudContext;
  late final String? id;

  FutureOr<CrudFormState> build({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
    required String? id,
  });
}

/// See also [CrudForm].
@ProviderFor(CrudForm)
const crudFormProvider = CrudFormFamily();

/// See also [CrudForm].
class CrudFormFamily extends Family<AsyncValue<CrudFormState>> {
  /// See also [CrudForm].
  const CrudFormFamily();

  /// See also [CrudForm].
  CrudFormProvider call({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
    required String? id,
  }) {
    return CrudFormProvider(
      adapter: adapter,
      crudContext: crudContext,
      id: id,
    );
  }

  @override
  CrudFormProvider getProviderOverride(
    covariant CrudFormProvider provider,
  ) {
    return call(
      adapter: provider.adapter,
      crudContext: provider.crudContext,
      id: provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'crudFormProvider';
}

/// See also [CrudForm].
class CrudFormProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CrudForm, CrudFormState> {
  /// See also [CrudForm].
  CrudFormProvider({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
    required String? id,
  }) : this._internal(
          () => CrudForm()
            ..adapter = adapter
            ..crudContext = crudContext
            ..id = id,
          from: crudFormProvider,
          name: r'crudFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$crudFormHash,
          dependencies: CrudFormFamily._dependencies,
          allTransitiveDependencies: CrudFormFamily._allTransitiveDependencies,
          adapter: adapter,
          crudContext: crudContext,
          id: id,
        );

  CrudFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.adapter,
    required this.crudContext,
    required this.id,
  }) : super.internal();

  final CrudRepositoryAdapter<dynamic> adapter;
  final CrudContext crudContext;
  final String? id;

  @override
  FutureOr<CrudFormState> runNotifierBuild(
    covariant CrudForm notifier,
  ) {
    return notifier.build(
      adapter: adapter,
      crudContext: crudContext,
      id: id,
    );
  }

  @override
  Override overrideWith(CrudForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: CrudFormProvider._internal(
        () => create()
          ..adapter = adapter
          ..crudContext = crudContext
          ..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        adapter: adapter,
        crudContext: crudContext,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CrudForm, CrudFormState>
      createElement() {
    return _CrudFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CrudFormProvider &&
        other.adapter == adapter &&
        other.crudContext == crudContext &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, adapter.hashCode);
    hash = _SystemHash.combine(hash, crudContext.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CrudFormRef on AutoDisposeAsyncNotifierProviderRef<CrudFormState> {
  /// The parameter `adapter` of this provider.
  CrudRepositoryAdapter<dynamic> get adapter;

  /// The parameter `crudContext` of this provider.
  CrudContext get crudContext;

  /// The parameter `id` of this provider.
  String? get id;
}

class _CrudFormProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CrudForm, CrudFormState>
    with CrudFormRef {
  _CrudFormProviderElement(super.provider);

  @override
  CrudRepositoryAdapter<dynamic> get adapter =>
      (origin as CrudFormProvider).adapter;
  @override
  CrudContext get crudContext => (origin as CrudFormProvider).crudContext;
  @override
  String? get id => (origin as CrudFormProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
