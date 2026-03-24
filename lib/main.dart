/// GameVault app entry point.
///
/// Initialises Hive, Riverpod, and launches the Flutter app.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise local storage
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: GameVaultApp(),
    ),
  );
}
