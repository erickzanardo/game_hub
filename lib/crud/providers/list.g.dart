// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$crudListHash() => r'9e8f6f694e57e70d5c83ff4abe5b7d23794c01ca';

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

abstract class _$CrudList extends BuildlessAutoDisposeAsyncNotifier<List> {
  late final CrudRepositoryAdapter<dynamic> adapter;
  late final CrudContext crudContext;

  FutureOr<List> build({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
  });
}

/// See also [CrudList].
@ProviderFor(CrudList)
const crudListProvider = CrudListFamily();

/// See also [CrudList].
class CrudListFamily extends Family<AsyncValue<List>> {
  /// See also [CrudList].
  const CrudListFamily();

  /// See also [CrudList].
  CrudListProvider call({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
  }) {
    return CrudListProvider(
      adapter: adapter,
      crudContext: crudContext,
    );
  }

  @override
  CrudListProvider getProviderOverride(
    covariant CrudListProvider provider,
  ) {
    return call(
      adapter: provider.adapter,
      crudContext: provider.crudContext,
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
  String? get name => r'crudListProvider';
}

/// See also [CrudList].
class CrudListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CrudList, List> {
  /// See also [CrudList].
  CrudListProvider({
    required CrudRepositoryAdapter<dynamic> adapter,
    required CrudContext crudContext,
  }) : this._internal(
          () => CrudList()
            ..adapter = adapter
            ..crudContext = crudContext,
          from: crudListProvider,
          name: r'crudListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$crudListHash,
          dependencies: CrudListFamily._dependencies,
          allTransitiveDependencies: CrudListFamily._allTransitiveDependencies,
          adapter: adapter,
          crudContext: crudContext,
        );

  CrudListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.adapter,
    required this.crudContext,
  }) : super.internal();

  final CrudRepositoryAdapter<dynamic> adapter;
  final CrudContext crudContext;

  @override
  FutureOr<List> runNotifierBuild(
    covariant CrudList notifier,
  ) {
    return notifier.build(
      adapter: adapter,
      crudContext: crudContext,
    );
  }

  @override
  Override overrideWith(CrudList Function() create) {
    return ProviderOverride(
      origin: this,
      override: CrudListProvider._internal(
        () => create()
          ..adapter = adapter
          ..crudContext = crudContext,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        adapter: adapter,
        crudContext: crudContext,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CrudList, List> createElement() {
    return _CrudListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CrudListProvider &&
        other.adapter == adapter &&
        other.crudContext == crudContext;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, adapter.hashCode);
    hash = _SystemHash.combine(hash, crudContext.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CrudListRef on AutoDisposeAsyncNotifierProviderRef<List> {
  /// The parameter `adapter` of this provider.
  CrudRepositoryAdapter<dynamic> get adapter;

  /// The parameter `crudContext` of this provider.
  CrudContext get crudContext;
}

class _CrudListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CrudList, List>
    with CrudListRef {
  _CrudListProviderElement(super.provider);

  @override
  CrudRepositoryAdapter<dynamic> get adapter =>
      (origin as CrudListProvider).adapter;
  @override
  CrudContext get crudContext => (origin as CrudListProvider).crudContext;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
