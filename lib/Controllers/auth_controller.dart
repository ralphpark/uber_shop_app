
// 새로운 사용자 등록
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Function to select image from gallery or camera
  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No image selected or Capture.');
    }
  }

  //파이어베이스 이미지 업로드
  _uploadImageToStorage(Uint8List? image,)async{
    //이미지 폴더 생성 및 파일명 UID로 저장
    Reference ref = _storage.ref().child('profileImages').child(_auth.currentUser!.uid);
    //업로드
    UploadTask uploadTask = ref.putData(image!);
    //업로드 완료
    TaskSnapshot snapshot =  await uploadTask;
    //다운로드 URL 반환
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // 파이어베이스에서 사용자 생성 시간이 있기 때문에 Future 사용한다.
  Future<String> createNewUser(
    String email,
    String fullName,
    String password,
    Uint8List? image,
  ) async {
    String res = 'some error occurred';

    try {
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String downloadUrl = await _uploadImageToStorage(image);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'email': email,
        'profileImage': downloadUrl,
        'fullName': fullName,
        'buyerId': userCredential.user!.uid,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //로그인 Function to login the created user
  Future<String> loginUser(String email, String password) async {
    String res = 'some error occurred';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = 'success';
    }  catch (e) {
      res = e.toString();
    }
    return res;
  }
}
