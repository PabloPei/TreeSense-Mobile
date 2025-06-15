import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/user/domain/usecases/get_current_user.dart';
import 'package:treesense/features/user/presentation/state/user_provider.dart';
import 'package:treesense/features/user/presentation/state/user_state.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, UserState>((ref) {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      return UserController(getCurrentUser);
    });

class UserController extends StateNotifier<UserState> {
  final GetCurrentUser getCurrentUser;

  UserController(this.getCurrentUser) : super(UserState()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await getCurrentUser();
      state = state.copyWith(user: user);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    final AuthStorage _authStorage = AuthStorage();

    await _authStorage.clearTokens();

    state = state.copyWith(user: null, isLoading: false, error: null);
  }
}
