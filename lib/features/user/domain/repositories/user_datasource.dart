import 'package:treesense/features/user/domain/entities/user.dart';

abstract class UserDatasource {
  Future<User> getCurrentUser();
}
