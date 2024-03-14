
// 새로운 사용자 등록
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 파이어베이스에서 사용자 생성 시간이 있기 때문에 Future 사용한다.
  Future<String> createNewUser(
    String email,
    String fullName,
    String password,
  ) async {
    String res = 'some error occurred';

    try {
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'email': email,
        'fullName': fullName,
        'buyerId': userCredential.user!.uid,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
