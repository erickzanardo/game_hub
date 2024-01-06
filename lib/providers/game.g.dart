// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getGameHash() => r'aed5a9aff0199f7a605e92ae8b34708bc97fe380';

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

abstract class _$GetGame extends BuildlessAutoDisposeAsyncNotifier<Game> {
  late final String gameId;

  FutureOr<Game> build(
    String gameId,
  );
}

/// See also [GetGame].
@ProviderFor(GetGame)
const getGameProvider = GetGameFamily();

/// See also [GetGame].
class GetGameFamily extends Family<AsyncValue<Game>> {
  /// See also [GetGame].
  const GetGameFamily();

  /// See also [GetGame].
  GetGameProvider call(
    String gameId,
  ) {
    return GetGameProvider(
      gameId,
    );
  }

  @override
  GetGameProvider getProviderOverride(
    covariant GetGameProvider provider,
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
  String? get name => r'getGameProvider';
}

/// See also [GetGame].
class GetGameProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetGame, Game> {
  /// See also [GetGame].
  GetGameProvider(
    String gameId,
  ) : this._internal(
          () => GetGame()..gameId = gameId,
          from: getGameProvider,
          name: r'getGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGameHash,
          dependencies: GetGameFamily._dependencies,
          allTransitiveDependencies: GetGameFamily._allTransitiveDependencies,
          gameId: gameId,
        );

  GetGameProvider._internal(
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
  FutureOr<Game> runNotifierBuild(
    covariant GetGame notifier,
  ) {
    return notifier.build(
      gameId,
    );
  }

  @override
  Override overrideWith(GetGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetGameProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetGame, Game> createElement() {
    return _GetGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGameProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetGameRef on AutoDisposeAsyncNotifierProviderRef<Game> {
  /// The parameter `gameId` of this provider.
  String get gameId;
}

class _GetGameProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetGame, Game>
    with GetGameRef {
  _GetGameProviderElement(super.provider);

  @override
  String get gameId => (origin as GetGameProvider).gameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
