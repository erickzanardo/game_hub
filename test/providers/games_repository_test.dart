import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _GamesRepositoryRefMock extends Mock implements GamesRepositoryRef {}

class _FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

void main() {
  test('returns the repository', () {
    expect(
      gamesRepository(
        _GamesRepositoryRefMock(),
        firestore: _FirebaseFirestoreMock(),
      ),
      isA<GamesRepository>(),
    );
  });
}
