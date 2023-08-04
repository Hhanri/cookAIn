import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

final mockFSI = FakeFirebaseFirestore();
final mockFAI = MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
        isAnonymous: true,
        uid: 'uuid123456789',
        email: 'test@test.com',
        displayName: 'test test'
    )
);