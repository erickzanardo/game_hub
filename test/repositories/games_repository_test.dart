// ignore_for_file: subtype_of_sealed_class, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

void main() {
  group('Game', () {
    test('can be instantiated', () {
      expect(
        Game(
          id: '1',
          name: 'Stardustry',
          description: 'A Great game releasing soon!',
          thumb: '',
        ),
        isA<Game>(),
      );
    });

    test('copyWith returns a new Game', () {
      final game = Game(
        id: '1',
        name: 'Stardustry',
        description: 'A Great game releasing soon!',
        thumb: '',
      );

      expect(
          game.copyWith(name: 'Stardustry 2'),
          equals(
            Game(
              id: '1',
              name: 'Stardustry 2',
              description: 'A Great game releasing soon!',
              thumb: '',
            ),
          ));

      expect(
          game.copyWith(description: 'Stardustry 2'),
          equals(
            Game(
              id: '1',
              name: 'Stardustry',
              description: 'Stardustry 2',
              thumb: '',
            ),
          ));
    });
  });
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
  group('GamesRepository', () {
    late FirebaseFirestore firestore;
    late CollectionReference<Map<String, dynamic>> gamesCollection;
    late CollectionReference<Map<String, dynamic>> gamesAccessCollection;
    late CollectionReference<Map<String, dynamic>> gameVersionsCollection;

    setUp(() {
      firestore = MockFirebaseFirestore();
      gamesCollection = MockCollectionReference();
      gamesAccessCollection = MockCollectionReference();
      gameVersionsCollection = MockCollectionReference();

      when(() => firestore.collection('games')).thenReturn(gamesCollection);
      when(() => firestore.collection('games_access'))
          .thenReturn(gamesAccessCollection);
      when(() => firestore.collection('games_versions'))
          .thenReturn(gameVersionsCollection);
    });

    test('can be instantiated', () {
      expect(
        GamesRepository(firestore: firestore),
        isA<GamesRepository>(),
      );
    });

    test('fetchGame returns a game', () async {
      final gamesRepository = GamesRepository(firestore: firestore);

      final docRef = MockDocumentReference();
      when(() => gamesCollection.doc('1')).thenReturn(docRef);

      when(docRef.get).thenAnswer(
        (_) async {
          final snapshot = MockDocumentSnapshot();
          when(() => snapshot.id).thenReturn('1');
          when(() => snapshot.data()).thenReturn({
            'name': 'Stardustry',
            'description': 'A Great game releasing soon!',
            'thumb': '',
          });
          return snapshot;
        },
      );

      final game = await gamesRepository.fetchGame('1');

      expect(
        game,
        equals(
          Game(
            id: '1',
            name: 'Stardustry',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
        ),
      );
    });

    test('fetchGames returns a list of games', () async {
      final gamesRepository = GamesRepository(firestore: firestore);

      mockQueryOnCollection(
        collection: gamesAccessCollection,
        createQuery: (collection) {
          final query = MockQuery();
          when(
            () => collection.where(
              'user_id',
              isEqualTo: '1',
            ),
          ).thenReturn(query);
          return query;
        },
        result: {
          '1': {'game_id': '1', 'user_id': '1'},
          '2': {'game_id': '2', 'user_id': '1'},
        },
      );

      mockQueryOnCollection(
        collection: gamesCollection,
        createQuery: (collection) {
          final query = MockQuery();

          when(
            () => collection.where(
              FieldPath.documentId,
              whereIn: ['1', '2'],
            ),
          ).thenReturn(query);
          return query;
        },
        result: {
          '1': {
            'name': 'Stardustry',
            'description': 'A Great game releasing soon!',
            'thumb': '',
          },
          '2': {
            'name': 'Treelings',
            'description': 'A Great game releasing soon!',
            'thumb': '',
          },
        },
      );

      final games = await gamesRepository.fetchUserGames('1');

      expect(
        games,
        equals([
          Game(
            id: '1',
            name: 'Stardustry',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
          Game(
            id: '2',
            name: 'Treelings',
            description: 'A Great game releasing soon!',
            thumb: '',
          ),
        ]),
      );
    });

    test('fetchGameVersions returns a list of a game versions', () async {
      final gamesRepository = GamesRepository(firestore: firestore);

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

      final games = await gamesRepository.fetchGameVersions('1');

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
  });
}
