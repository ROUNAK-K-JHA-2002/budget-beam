import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void createUser(User user) {
  FirebaseFirestore.instance.collection('users').doc().set({
    'name': user.displayName,
    'email': user.email,
  });
}

void updateUser(User user) {
  FirebaseFirestore.instance.collection('users').doc().update({
    'name': user.displayName,
    'email': user.email,
  });
}

void getUser(User user) {
  FirebaseFirestore.instance.collection('users').doc().get();
}
