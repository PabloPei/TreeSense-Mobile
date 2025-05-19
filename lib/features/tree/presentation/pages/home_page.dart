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
                    onPressed: () => context.go('/tree-census'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarySeedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 52,
                        vertical: 18,
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

              // Title: Últimas cargas + Filtro
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        MessageLoader.get('last_uploads_title'),
                        style: AppTextStyles.titleStyle,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Agregá lógica de filtro acá
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.grey),
                      tooltip: 'Filtrar',
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
