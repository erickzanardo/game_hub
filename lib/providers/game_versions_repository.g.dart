// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_versions_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameVersionsRepositoryHash() =>
    r'744d24bd878a1ffa6d41269aeb7f08a68c426d10';

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

/// See also [gameVersionsRepository].
@ProviderFor(gameVersionsRepository)
const gameVersionsRepositoryProvider = GameVersionsRepositoryFamily();

/// See also [gameVersionsRepository].
class GameVersionsRepositoryFamily extends Family<GameVersionsRepository> {
  /// See also [gameVersionsRepository].
  const GameVersionsRepositoryFamily();

  /// See also [gameVersionsRepository].
  GameVersionsRepositoryProvider call({
    FirebaseFirestore? firestore,
  }) {
    return GameVersionsRepositoryProvider(
      firestore: firestore,
    );
  }

  @override
  GameVersionsRepositoryProvider getProviderOverride(
    covariant GameVersionsRepositoryProvider provider,
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
  String? get name => r'gameVersionsRepositoryProvider';
}

/// See also [gameVersionsRepository].
class GameVersionsRepositoryProvider
    extends AutoDisposeProvider<GameVersionsRepository> {
  /// See also [gameVersionsRepository].
  GameVersionsRepositoryProvider({
    FirebaseFirestore? firestore,
  }) : this._internal(
          (ref) => gameVersionsRepository(
            ref as GameVersionsRepositoryRef,
            firestore: firestore,
          ),
          from: gameVersionsRepositoryProvider,
          name: r'gameVersionsRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameVersionsRepositoryHash,
          dependencies: GameVersionsRepositoryFamily._dependencies,
          allTransitiveDependencies:
              GameVersionsRepositoryFamily._allTransitiveDependencies,
          firestore: firestore,
        );

  GameVersionsRepositoryProvider._internal(
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
    GameVersionsRepository Function(GameVersionsRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GameVersionsRepositoryProvider._internal(
        (ref) => create(ref as GameVersionsRepositoryRef),
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
  AutoDisposeProviderElement<GameVersionsRepository> createElement() {
    return _GameVersionsRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameVersionsRepositoryProvider &&
        other.firestore == firestore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, firestore.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameVersionsRepositoryRef
    on AutoDisposeProviderRef<GameVersionsRepository> {
  /// The parameter `firestore` of this provider.
  FirebaseFirestore? get firestore;
}

class _GameVersionsRepositoryProviderElement
    extends AutoDisposeProviderElement<GameVersionsRepository>
    with GameVersionsRepositoryRef {
  _GameVersionsRepositoryProviderElement(super.provider);

  @override
  FirebaseFirestore? get firestore =>
      (origin as GameVersionsRepositoryProvider).firestore;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
