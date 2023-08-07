import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

final mockFSI = FakeFirebaseFirestore();
final mockFAI = MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
        uid: 'uuid123456789',
        email: 'test@test.com',
        displayName: 'test test'
    )
);

final mockGoogleSignIn = MockGoogleSignIn();