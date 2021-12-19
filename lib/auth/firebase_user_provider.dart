import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DjtechfinwalletFirebaseUser {
  DjtechfinwalletFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

DjtechfinwalletFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DjtechfinwalletFirebaseUser> djtechfinwalletFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DjtechfinwalletFirebaseUser>(
            (user) => currentUser = DjtechfinwalletFirebaseUser(user));
