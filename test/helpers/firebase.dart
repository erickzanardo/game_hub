// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {
  @override
  dynamic operator [](Object field) {
    return data()?[field];
  }
}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  @override
  dynamic operator [](Object field) {
    return data()[field];
  }
}

void mockDocumentOnCollection({
  required String id,
  required CollectionReference collection,
  Map<String, dynamic> result = const {},
}) {
  final documentReference = MockDocumentReference();
  when(() => documentReference.id).thenReturn(id);
  when(() => collection.doc(id)).thenReturn(documentReference);

  final documentSnapshot = MockDocumentSnapshot();
  when(() => documentSnapshot.data()).thenReturn(result);
  when(() => documentSnapshot.exists).thenReturn(true);

  when(documentReference.get).thenAnswer((_) async => documentSnapshot);
}

void mockInexistentDocumentOnCollection({
  required String id,
  required CollectionReference collection,
}) {
  final documentReference = MockDocumentReference();
  when(() => documentReference.id).thenReturn(id);
  when(() => collection.doc(id)).thenReturn(documentReference);

  final documentSnapshot = MockDocumentSnapshot();
  when(() => documentSnapshot.data()).thenReturn(null);
  when(() => documentSnapshot.exists).thenReturn(false);

  when(documentReference.get).thenAnswer((_) async => documentSnapshot);
}

void mockQueryOnCollection({
  required CollectionReference collection,
  required Query Function(CollectionReference) createQuery,
  required Map<String, Map<String, dynamic>> result,
}) {
  final querySnapshot = MockQuerySnapshot();

  final documents = <MockQueryDocumentSnapshot>[];
  for (final entry in result.entries) {
    final document = MockQueryDocumentSnapshot();
    when(() => document.id).thenReturn(entry.key);
    when(() => document.data()).thenReturn(entry.value);
    when(() => document.exists).thenReturn(true);
    documents.add(document);
  }
  when(() => querySnapshot.docs).thenAnswer((_) => documents);

  final query = createQuery(collection);
  when(() => query.get()).thenAnswer((_) async => querySnapshot);
}

void mockFetchAllOnCollection({
  required CollectionReference collection,
  required Map<String, Map<String, dynamic>> result,
}) {
  final querySnapshot = MockQuerySnapshot();

  final documents = <MockQueryDocumentSnapshot>[];
  for (final entry in result.entries) {
    final document = MockQueryDocumentSnapshot();
    when(() => document.id).thenReturn(entry.key);
    when(() => document.data()).thenReturn(entry.value);
    when(() => document.exists).thenReturn(true);
    documents.add(document);
  }
  when(() => querySnapshot.docs).thenAnswer((_) => documents);

  when(() => collection.get()).thenAnswer((_) async => querySnapshot);
}
