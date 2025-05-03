import 'user_impl.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  
   @override
     Future<UserModel> login(String email, String password) async {
    // Simulated API call -> replace with the true api call 
    await Future.delayed(Duration(seconds: 1));
    return UserModel(id: '123', email: email);
  }

}
