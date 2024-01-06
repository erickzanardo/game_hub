// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamesRepositoryHash() => r'c5f7f64cf83bb1ab9042751d5b924a76f90340dd';

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

/// See also [gamesRepository].
@ProviderFor(gamesRepository)
const gamesRepositoryProvider = GamesRepositoryFamily();

/// See also [gamesRepository].
class GamesRepositoryFamily extends Family<GamesRepository> {
  /// See also [gamesRepository].
  const GamesRepositoryFamily();

  /// See also [gamesRepository].
  GamesRepositoryProvider call({
    FirebaseFirestore? firestore,
  }) {
    return GamesRepositoryProvider(
      firestore: firestore,
    );
  }

  @override
  GamesRepositoryProvider getProviderOverride(
    covariant GamesRepositoryProvider provider,
  ) {
    return call(
      firestore: provider.firestore,
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
  String? get name => r'gamesRepositoryProvider';
}

/// See also [gamesRepository].
class GamesRepositoryProvider extends AutoDisposeProvider<GamesRepository> {
  /// See also [gamesRepository].
  GamesRepositoryProvider({
    FirebaseFirestore? firestore,
  }) : this._internal(
          (ref) => gamesRepository(
            ref as GamesRepositoryRef,
            firestore: firestore,
          ),
          from: gamesRepositoryProvider,
          name: r'gamesRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gamesRepositoryHash,
          dependencies: GamesRepositoryFamily._dependencies,
          allTransitiveDependencies:
              GamesRepositoryFamily._allTransitiveDependencies,
          firestore: firestore,
        );

  GamesRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.firestore,
  }) : super.internal();

  final FirebaseFirestore? firestore;

  @override
  Override overrideWith(
    GamesRepository Function(GamesRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GamesRepositoryProvider._internal(
        (ref) => create(ref as GamesRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        firestore: firestore,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GamesRepository> createElement() {
    return _GamesRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GamesRepositoryProvider && other.firestore == firestore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, firestore.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GamesRepositoryRef on AutoDisposeProviderRef<GamesRepository> {
  /// The parameter `firestore` of this provider.
  FirebaseFirestore? get firestore;
}

class _GamesRepositoryProviderElement
    extends AutoDisposeProviderElement<GamesRepository>
    with GamesRepositoryRef {
  _GamesRepositoryProviderElement(super.provider);

  @override
  FirebaseFirestore? get firestore =>
      (origin as GamesRepositoryProvider).firestore;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
