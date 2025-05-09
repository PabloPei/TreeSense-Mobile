import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_widget';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeListAsyncValue = ref.watch(treeUploadedByUser);

    return Scaffold(
      appBar: AppBar(title: Text(MessageLoader.get('last_uploads'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (context.mounted) {
                  context.go('/tree-census');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(MessageLoader.get('new_tree')),
            ),
          ),
          Expanded(
            child: treeListAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error:
                  (error, stackTrace) => Center(
                    child: Text(
                      '${MessageLoader.get('error_get_last_upload')}: $error',
                    ),
                  ),

              data: (treeList) {
                if (treeList.isEmpty) {
                  return Center(
                    child: Text(MessageLoader.get('empty_upload_list')),
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
    );
  }
}
