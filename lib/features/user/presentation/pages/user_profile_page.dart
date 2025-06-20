import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo.dart';
import 'package:treesense/features/user/presentation/widgets/user_name.dart';
import 'package:treesense/features/user/presentation/widgets/user_email.dart';
import 'package:treesense/features/user/presentation/widgets/user_language.dart';
import 'package:treesense/features/user/presentation/widgets/user_logout.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/shared/widgets/dialogs/show_photo_dialog.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userControllerProvider);
    final user = state.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return WarningMessage(
                title: MessageLoader.get('login_error'),
                message: state.error!,
              );
            }

            if (user == null) {
              return Center(child: Text(MessageLoader.get('error_unknow')));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header con botón de back
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => context.pop(),
                      tooltip: MessageLoader.get('save_tree_form_back'),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                GestureDetector(
                  onTap:
                      () => showPhotoDialog(
                        context: context,
                        photo: user.photo,
                        placeholderAsset: 'assets/icons/user.png',
                      ),
                  child: Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: profileDetailsColor, width: 1),
                    ),
                    child: UserProfilePhoto(photo: user.photo, radius: 80),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxl),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 3,
                  color: profileDetailsColor,
                ),

                const SizedBox(height: AppSpacing.xl),

                Align(
                  alignment: Alignment.centerLeft,
                  child: UserNameWidget(userName: user.userName),
                ),
                const SizedBox(height: AppSpacing.xl),

                Align(
                  alignment: Alignment.centerLeft,
                  child: UserEmailWidget(email: user.email),
                ),
                const SizedBox(height: AppSpacing.xl),

                Align(
                  alignment: Alignment.centerLeft,
                  child: UserLanguageWidget(language: user.language),
                ),

                const Spacer(),

                // Usar el botón de logout del módulo
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const LogoutButton(),
                ),

                const SizedBox(height: AppSpacing.lg),
              ],
            );
          },
        ),
      ),
    );
  }
}
