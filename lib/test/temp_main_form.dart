import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:treesense/features/tree/presentation/pages/form/type_selection_page.dart';
import '/core/theme/app_theme.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/router/app_router.dart';

// TODO: eliminar este provider temporal cuando se integre el controller real
enum TreeCensusType { arbolConPlantera, arbolSinPlantera, planteraVacia }

final treeTypeProvider = StateProvider<TreeCensusType?>((ref) => null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MessageLoader.load();

  runApp(const ProviderScope(child: TreeSenseTestApp()));
}

class TreeSenseTestApp extends StatelessWidget {
  const TreeSenseTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: MessageLoader.get('app_title'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarySeedColor),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
