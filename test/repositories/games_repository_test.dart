// ignore_for_file: subtype_of_sealed_class, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class _MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class _MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class _MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class _MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class _MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class _MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

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
  group('GamesRepository', () {
    late FirebaseFirestore firestore;
    late CollectionReference<Map<String, dynamic>> collection;

    setUp(() {
      firestore = _MockFirebaseFirestore();
      collection = _MockCollectionReference();
      when(() => firestore.collection('games')).thenReturn(collection);
    });

    test('can be instantiated', () {
      expect(
        GamesRepository(firestore: firestore),
        isA<GamesRepository>(),
      );
    });

    test('fetchGame returns a game', () async {
      final gamesRepository = GamesRepository(firestore: firestore);

      final docRef = _MockDocumentReference();
      when(() => collection.doc('1')).thenReturn(docRef);

      when(docRef.get).thenAnswer(
        (_) async {
          final snapshot = _MockDocumentSnapshot();
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

      final query = _MockQuery();
      when(
        () => collection.where(
          'users',
          arrayContainsAny: ['1', '*'],
        ),
      ).thenReturn(query);

      when(query.get).thenAnswer(
        (_) async {
          final querySnapshot = _MockQuerySnapshot();

          final game1 = _MockQueryDocumentSnapshot();
          when(() => game1.id).thenReturn('1');
          when(() => game1.data()).thenReturn({
            'name': 'Stardustry',
            'description': 'A Great game releasing soon!',
            'thumb': '',
          });

          final game2 = _MockQueryDocumentSnapshot();
          when(() => game2.id).thenReturn('2');
          when(() => game2.data()).thenReturn({
            'name': 'Treelings',
            'description': 'A Great game releasing soon!',
            'thumb': '',
          });

          when(() => querySnapshot.docs).thenReturn([game1, game2]);

          when(() => querySnapshot.docs).thenReturn([
            game1,
            game2,
          ]);

          return querySnapshot;
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
  });
}
