import 'package:flup_sudoku/database/util/abstract_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveImpl extends AbstractHive {

  const HiveImpl();

  @override
  Future<void> init([String? subDir]) async => await Hive.initFlutter(subDir);

  @override
  Future<Box<E>> openBox<E>(String name, HiveCipher encryptionCipher, bool Function(int entries, int deletedEntries) strategy) => Hive.openBox(name, encryptionCipher: encryptionCipher, compactionStrategy: strategy);

}