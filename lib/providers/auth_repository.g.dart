// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'50fd3e70e00877e1f3eede39ad424528fa8d9614';

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

/// See also [authRepository].
@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryFamily();

/// See also [authRepository].
class AuthRepositoryFamily extends Family<AuthRepository> {
  /// See also [authRepository].
  const AuthRepositoryFamily();

  /// See also [authRepository].
  AuthRepositoryProvider call({
    FirebaseAuth? firebaseAuth,
  }) {
    return AuthRepositoryProvider(
      firebaseAuth: firebaseAuth,
    );
  }

  @override
  AuthRepositoryProvider getProviderOverride(
    covariant AuthRepositoryProvider provider,
  ) {
    return call(
      firebaseAuth: provider.firebaseAuth,
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
  String? get name => r'authRepositoryProvider';
}

/// See also [authRepository].
class AuthRepositoryProvider extends AutoDisposeProvider<AuthRepository> {
  /// See also [authRepository].
  AuthRepositoryProvider({
    FirebaseAuth? firebaseAuth,
  }) : this._internal(
          (ref) => authRepository(
            ref as AuthRepositoryRef,
            firebaseAuth: firebaseAuth,
          ),
          from: authRepositoryProvider,
          name: r'authRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authRepositoryHash,
          dependencies: AuthRepositoryFamily._dependencies,
          allTransitiveDependencies:
              AuthRepositoryFamily._allTransitiveDependencies,
          firebaseAuth: firebaseAuth,
        );

  AuthRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.firebaseAuth,
  }) : super.internal();

  final FirebaseAuth? firebaseAuth;

  @override
  Override overrideWith(
    AuthRepository Function(AuthRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthRepositoryProvider._internal(
        (ref) => create(ref as AuthRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        firebaseAuth: firebaseAuth,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AuthRepository> createElement() {
    return _AuthRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthRepositoryProvider &&
        other.firebaseAuth == firebaseAuth;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, firebaseAuth.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthRepositoryRef on AutoDisposeProviderRef<AuthRepository> {
  /// The parameter `firebaseAuth` of this provider.
  FirebaseAuth? get firebaseAuth;
}

class _AuthRepositoryProviderElement
    extends AutoDisposeProviderElement<AuthRepository> with AuthRepositoryRef {
  _AuthRepositoryProviderElement(super.provider);

  @override
  FirebaseAuth? get firebaseAuth =>
      (origin as AuthRepositoryProvider).firebaseAuth;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
