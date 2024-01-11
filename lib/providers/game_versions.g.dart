// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_versions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameVersionsHash() => r'c6bc5fccdf8a6f9cae6c230e3c9f32af67915211';

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

abstract class _$GameVersions
    extends BuildlessAutoDisposeAsyncNotifier<List<GameVersion>> {
  late final String gameId;

  FutureOr<List<GameVersion>> build(
    String gameId,
  );
}

/// See also [GameVersions].
@ProviderFor(GameVersions)
const gameVersionsProvider = GameVersionsFamily();

/// See also [GameVersions].
class GameVersionsFamily extends Family<AsyncValue<List<GameVersion>>> {
  /// See also [GameVersions].
  const GameVersionsFamily();

  /// See also [GameVersions].
  GameVersionsProvider call(
    String gameId,
  ) {
    return GameVersionsProvider(
      gameId,
    );
  }

  @override
  GameVersionsProvider getProviderOverride(
    covariant GameVersionsProvider provider,
  ) {
    return call(
      provider.gameId,
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
  String? get name => r'gameVersionsProvider';
}

/// See also [GameVersions].
class GameVersionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GameVersions, List<GameVersion>> {
  /// See also [GameVersions].
  GameVersionsProvider(
    String gameId,
  ) : this._internal(
          () => GameVersions()..gameId = gameId,
          from: gameVersionsProvider,
          name: r'gameVersionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameVersionsHash,
          dependencies: GameVersionsFamily._dependencies,
          allTransitiveDependencies:
              GameVersionsFamily._allTransitiveDependencies,
          gameId: gameId,
        );

  GameVersionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameId,
  }) : super.internal();

  final String gameId;

  @override
  FutureOr<List<GameVersion>> runNotifierBuild(
    covariant GameVersions notifier,
  ) {
    return notifier.build(
      gameId,
    );
  }

  @override
  Override overrideWith(GameVersions Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameVersionsProvider._internal(
        () => create()..gameId = gameId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameId: gameId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GameVersions, List<GameVersion>>
      createElement() {
    return _GameVersionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameVersionsProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameVersionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<GameVersion>> {
  /// The parameter `gameId` of this provider.
  String get gameId;
}

class _GameVersionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GameVersions,
        List<GameVersion>> with GameVersionsRef {
  _GameVersionsProviderElement(super.provider);

  @override
  String get gameId => (origin as GameVersionsProvider).gameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
