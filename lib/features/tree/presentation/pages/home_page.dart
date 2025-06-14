import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_widget.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeListAsyncValue = ref.watch(treeUploadedByUser);
    final userState = ref.watch(userControllerProvider);
    final userPhoto = userState.user?.photo;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top row: Profile photo + New Tree button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'Ver perfil',
                    child: GestureDetector(
                      onTap: () => context.push('/profile'),
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: UserProfilePhoto(photo: userPhoto, radius: 30),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/tree-census/type'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarySeedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.xl),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    child: Text(
                      MessageLoader.get('new_tree'),
                      style: AppTextStyles.bottomTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              //Últimas cargas
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        MessageLoader.get('last_uploads_title'),
                        style: AppTextStyles.titleStyle,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              Expanded(
                child: treeListAsyncValue.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stackTrace) => WarningMessage(
                        title: MessageLoader.get('error_get_last_upload'),
                        message: error.toString(),
                      ),
                  data: (treeList) {
                    if (treeList.isEmpty) {
                      return Center(
                        child: Text(
                          MessageLoader.get('empty_upload_list'),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: treeList.length,
                      itemBuilder: (context, index) {
                        final tree = treeList[index];
                        return TreeCard(tree: tree);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
