import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_hub/providers/providers.dart';
import 'package:game_hub/repositories/repositories.dart';
import 'package:mocktail/mocktail.dart';

class _GameVersionsRepositoryRefMock extends Mock
    implements GameVersionsRepositoryRef {}

class _FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

void main() {
  test('returns the repository', () {
    expect(
      gameVersionsRepository(
        _GameVersionsRepositoryRefMock(),
        firestore: _FirebaseFirestoreMock(),
      ),
      isA<GameVersionsRepository>(),
    );
  });
}
