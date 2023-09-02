import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exceptions/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, tente outro e-mail!');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no TodoList pelo Google. Utilize essa opção para logar!');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário!');
      }
    }
  }
}