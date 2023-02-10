// ignore_for_file: library_prefixes

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:quiz_bet/config/constants.dart';
import 'package:quiz_bet/layer_data/models/tokens.dart';

class AppHiveBoxes {
  ///BOXES
  late Box authBox;

  AppHiveBoxes._privateConstructor();

  static final AppHiveBoxes _instance = AppHiveBoxes._privateConstructor();

  static AppHiveBoxes get instance => _instance;

  ///OPEN HIVE BOXES
  initHiveBoxes() async {
    ///REGISTER HIVE ADAPTERS
    await initHiveAdapters();

    authBox = await Hive.openBox<Tokens>(
      Constants.authBox,
    );


    ///INIT DEFAULT BOX VALUES
    initSettingsBox();
  }

  void initSettingsBox() async {}

  Future<void> initHiveAdapters() async {
    //INIT HIVE
    Directory directory = await pathProvider.getApplicationSupportDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(TokensAdapter());
  }
}
