import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/user/presentation/pages/user_profile_page.dart';
import '/core/theme/app_theme.dart';

//TODO: borrar en produccion
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MessageLoader.load();

  runApp(const ProviderScope(child: TreeSenseTestApp()));
}

class TreeSenseTestApp extends StatelessWidget {
  const TreeSenseTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MessageLoader.get('app_title'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarySeedColor),
        useMaterial3: true,
      ),
      home: const UserProfilePage(),
    );
  }
}
