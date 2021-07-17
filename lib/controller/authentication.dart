import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final googleSignInObj = GoogleSignIn();

Future<bool> googleSignIn() async {
  GoogleSignInAccount? googleSignInAccount = await googleSignInObj.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await auth.signInWithCredential(credential);
    User? user = auth.currentUser;

    print(user!.uid);

    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

Future<User> signIn(String email, String password) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return Future.value(user);
  } catch (e) {
    switch (e) {
      case 'user-disabled':
        print("user-disabled");
        break;
      case 'invalid-email':
        print("invalid-email");
        break;

      case 'user-not-found':
        print("user-not-found");
        break;

      case 'wrong-password':
        print("wrong-password");
        break;
    }
    return Future.value(null);
  }
}

Future<User> signUp(String email, String password) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return Future.value(user);
  } catch (e) {
    switch (e) {
      case 'email-already-in-use':
        print("email-already-in-use");
        break;
      case 'invalid-email':
        print("invalid-email");
        break;

      case 'operation-not-allowed':
        print("operation-not-allowed");
        break;

      case 'weak-password':
        print("weak-password");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOut() async {
  User? user = auth.currentUser;
  if (user!.providerData[1].providerId == "google.com") {
    await googleSignInObj.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}
