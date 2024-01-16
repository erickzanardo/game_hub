// ignore_for_file: subtype_of_sealed_class, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

void main() {
  group('GameVersion', () {
    test('can be instantiated', () {
      expect(
        GameVersion(
          id: '1',
          gameId: '1',
          version: '1',
          description: 'A new version',
          macosUrl: 'https://mac.example.com',
          windowsUrl: 'https://windows.example.com',
          linuxUrl: 'https://linux.example.com',
        ),
        isA<GameVersion>(),
      );
    });

    test('copyWith returns a new GameVersion', () {
      final gameVersion = GameVersion(
        id: '1',
        gameId: '1',
        version: '1',
        description: 'A new version',
        macosUrl: 'https://mac.example.com',
        windowsUrl: 'https://windows.example.com',
        linuxUrl: 'https://linux.example.com',
      );

      expect(
        gameVersion.copyWith(version: '2'),
        equals(
          GameVersion(
            id: '1',
            gameId: '1',
            version: '2',
            description: 'A new version',
            macosUrl: 'https://mac.example.com',
            windowsUrl: 'https://windows.example.com',
            linuxUrl: 'https://linux.example.com',
          ),
        ),
      );

      expect(
        gameVersion.copyWith(description: 'Stardustry 2'),
        equals(
          GameVersion(
            id: '1',
            gameId: '1',
            version: '1',
            description: 'Stardustry 2',
            macosUrl: 'https://mac.example.com',
            windowsUrl: 'https://windows.example.com',
            linuxUrl: 'https://linux.example.com',
          ),
        ),
      );

      expect(
        gameVersion.copyWith(macosUrl: 'https://mac.example.com/2'),
        equals(
          GameVersion(
            id: '1',
            gameId: '1',
            version: '1',
            description: 'A new version',
            macosUrl: 'https://mac.example.com/2',
            windowsUrl: 'https://windows.example.com',
            linuxUrl: 'https://linux.example.com',
          ),
        ),
      );

      expect(
        gameVersion.copyWith(windowsUrl: 'https://windows.example.com/2'),
        equals(
          GameVersion(
            id: '1',
            gameId: '1',
            version: '1',
            description: 'A new version',
            macosUrl: 'https://mac.example.com',
            windowsUrl: 'https://windows.example.com/2',
            linuxUrl: 'https://linux.example.com',
          ),
        ),
      );

      expect(
        gameVersion.copyWith(linuxUrl: 'https://linux.example.com/2'),
        equals(
          GameVersion(
            id: '1',
            gameId: '1',
            version: '1',
            description: 'A new version',
            macosUrl: 'https://mac.example.com',
            windowsUrl: 'https://windows.example.com',
            linuxUrl: 'https://linux.example.com/2',
          ),
        ),
      );
    });
  });
  group('GameVersionsRepository', () {
    late FirebaseFirestore firestore;
    late CollectionReference<Map<String, dynamic>> gameVersionsCollection;

    setUp(() {
      firestore = MockFirebaseFirestore();
      gameVersionsCollection = MockCollectionReference();

      when(() => firestore.collection('games_versions'))
          .thenReturn(gameVersionsCollection);
    });

    test('can be instantiated', () {
      expect(
        GameVersionsRepository(firestore: firestore),
        isA<GameVersionsRepository>(),
      );
    });

    test('fetchGameVersions returns a list of a game versions', () async {
      final gameVersionsRepository =
          GameVersionsRepository(firestore: firestore);

      mockQueryOnCollection(
        collection: gameVersionsCollection,
        createQuery: (collection) {
          final query = MockQuery();
          when(
            () => collection.where(
              'game_id',
              isEqualTo: '1',
            ),
          ).thenReturn(query);
          return query;
        },
        result: {
          '1': {
            'game_id': '1',
            'version': '1',
            'description': 'A new version',
            'macos_url': 'https://mac.example.com',
            'windows_url': 'https://windows.example.com',
            'linux_url': 'https://linux.example.com',
          },
        },
      );

      final games = await gameVersionsRepository.fetchGameVersions('1');

      expect(
        games,
        equals([
          GameVersion(
            id: '1',
            gameId: '1',
            version: '1',
            description: 'A new version',
            macosUrl: 'https://mac.example.com',
            windowsUrl: 'https://windows.example.com',
            linuxUrl: 'https://linux.example.com',
          )
        ]),
      );
    });

    test('fetch returns a game version', () async {
      final gameVersionsRepository =
          GameVersionsRepository(firestore: firestore);

      final docRef = MockDocumentReference();
      when(() => gameVersionsCollection.doc('1')).thenReturn(docRef);

      when(docRef.get).thenAnswer(
        (_) async {
          final snapshot = MockDocumentSnapshot();
          when(() => snapshot.id).thenReturn('1');
          when(() => snapshot.data()).thenReturn({
            'id': '1',
            'game_id': '',
            'description': 'A Great game releasing soon!',
            'version': '',
          });
          return snapshot;
        },
      );

      final game = await gameVersionsRepository.fetch('1');

      expect(
        game,
        equals(
          GameVersion(
            id: '1',
            gameId: '',
            description: 'A Great game releasing soon!',
            version: '',
          ),
        ),
      );
    });

    test('create throws UnimplementedError', () async {
      final gameVersionsRepository =
          GameVersionsRepository(firestore: firestore);

      expect(
        () => gameVersionsRepository.create(
          GameVersion(
            id: '',
            gameId: '',
            version: '1',
            description: 'A Great game releasing soon!',
          ),
          context: RootCrudContext(),
        ),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('delete throws UnimplementedError', () async {
      final gameVersionsRepository =
          GameVersionsRepository(firestore: firestore);

      expect(
        () => gameVersionsRepository.delete(''),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('update throws UnimplementedError', () async {
      final gameVersionsRepository =
          GameVersionsRepository(firestore: firestore);

      expect(
        () => gameVersionsRepository.update(
          GameVersion(
            id: '',
            gameId: '',
            version: '1',
            description: 'A Great game releasing soon!',
          ),
        ),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
