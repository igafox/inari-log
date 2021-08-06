import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);

final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);