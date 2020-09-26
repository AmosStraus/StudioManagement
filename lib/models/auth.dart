import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/models/data_from_server.dart';
import 'package:state_management_ex1/models/parse_date.dart';

/// This is where we define methods to interact with firebase auth for us ///
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase user one-time fetch
  User get getUser => _auth.currentUser;
  // auth change user stream. when everthe user signs in or out we get respose
  // down the stream. "null" for signed out. user object mapped on sign in.
  Stream<User> get user => _auth.authStateChanges();

  // sign in anonymously
  Future<User> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return (user);
    } catch (e) {
      print("ERROR " + e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("ERROR" + e.toString());
      return null;
    }
  }

  // sign in with mail
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Update user data
      await updateUserData(result.user);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with mail
  Future<User> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Update user data
      await createUserWithData(result.user, name);
      await result.user.updateProfile(displayName: name);
      return (result.user);
    } catch (e) {
      print("ERROR " + e.toString());
      return null;
    }
  }

  /// Sign in with Google
  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      // Update user data
      await updateUserData(result.user);
      return result.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) async {
    DocumentReference reportRef = FirebaseFirestore.instance
        .collection('Reports')
        .doc("${user.displayName}_${user.uid}");

    bool newUser = false;
    await reportRef.get().then((snapshot) {
      if (!snapshot.exists) {
        print("registered new user1");
        newUser = true;
      } else if (snapshot.data()['classHistory'] == null) {
        print("registered new user1");
        newUser = true;
      }
    });
    if (newUser) {
      return await reportRef.set({
        'uid': user.uid,
        'lastActivity': DateTime.now(),
        'name': user.displayName,
        'email': user.email,
        'classHistory': [],
      });
    } else {
      return await reportRef.set({
        'uid': user.uid,
        'lastActivity': DateTime.now(),
        'name': user.displayName,
        'email': user.email,
      }, SetOptions(merge: true));
    }
  }

  // Creates user
  Future<void> createUserWithData(User user, String name) async {
    DocumentReference reportRef = FirebaseFirestore.instance
        .collection('Reports')
        .doc("${name}_${user.uid}");

    return await reportRef.set({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'name': name,
      'email': user.email,
      'classHistory': [
        {'${DateTime.now()}': "${rawDateToDateString(DateTime.now())}_created"}
      ],
    }, SetOptions(merge: true));
  }

  Future<void> registerUserToClass(Activity activity, bool register) async {
    DocumentReference reportClassRef = FirebaseFirestore.instance
        .collection('Reports')
        .doc("${getUser.displayName}_${getUser.uid}");

    await DataFromServerInit.updateServerOnRegistration(
        activity.dateString, activity, register, getUser);

    if (register) {
      await reportClassRef.update({
        'classHistory': FieldValue.arrayUnion([
          {'${activity.rawDate}': "${activity.dateString}_${activity.name}"}
        ])
      });
    } else {
      await reportClassRef.update({
        'classHistory': FieldValue.arrayRemove([
          {'${activity.rawDate}': "${activity.dateString}_${activity.name}"}
        ])
      });
    }
  }
}
