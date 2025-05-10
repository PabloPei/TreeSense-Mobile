import 'package:treesense/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUser();
}
