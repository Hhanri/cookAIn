import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

final mockFSI = FakeFirebaseFirestore(
    securityRules: '''rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    match /ingredients/{ingredients} {
      allow read, write: if ingredients == request.auth.uid;
      
      match /recipes/{recipes} {
      	allow read, write: if ingredients == request.auth.uid;
      }
      
      match /chat/{message} {
      	allow read, write: if ingredients == request.auth.uid;
      }
    }
  }
}''',
    authObject: mockFAI.authForFakeFirestore
);
final mockFAI = MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
        uid: 'uuid123456789',
        email: 'test@test.com',
        displayName: 'test test'
    )
);

final mockGoogleSignIn = MockGoogleSignIn();