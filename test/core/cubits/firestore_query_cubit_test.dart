import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/mock_firebase.dart';

class _MockFirestoreQueryCubit extends FirestoreQueryCubit<_TestType> {
  _MockFirestoreQueryCubit({required super.query});
}
typedef _TestType = Map<String, dynamic>;

void main() async {

  final fsi = mockFSI;
  final fai = mockFAI;

  final collectionRef = fsi
    .collection('ingredients')
    .doc(fai.currentUser?.uid)
    .collection('recipes');

  final cubit = _MockFirestoreQueryCubit(query: collectionRef);

  final mockAfterAddingDoc = '''{
  "ingredients": {
    "${fai.currentUser?.uid}": {
      "recipes": {
        "testDocument": {
          "key": "value"
        }
      }
    }
  }
}''';

  group('firestore query cubit test', () {

    test('initial state', () {
      expect(cubit.state, const FirestoreQueryInitial<_TestType>());
    });

    test('start listening on empty collection', () async {
      cubit.fetchMore();
      await Future.delayed(const Duration(milliseconds: 10));
      expect(cubit.state, const FirestoreQueryEmpty<_TestType>());
    });

    test('add document to collection', () async {
      await collectionRef.doc('testDocument').set({'key': 'value'});
      expect(fsi.dump(), mockAfterAddingDoc);
      expect(cubit.state, const TypeMatcher<FirestoreQueryLoaded<_TestType>>());
    });

  });
}