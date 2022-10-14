import 'package:autobot/components/depenencies.dart';
import 'package:autobot/essentials/command_line_app/command_line_app.dart';
import 'package:autobot/shared/base_paths/base_paths.dart';
import 'package:autobot/shared/file_and_dir_paths/config_folder_structure.dart';
import 'package:autobot/shared/when/when.dart';

class ConfigFolder {
  static ConfigFolderStructure findFirstAt(BasePaths basePaths) {
    final customPath = basePaths.customDir;

    final basePath = when(ConfigFolderStructure.at(basePaths.localDir).exists)
        .then(() => basePaths.localDir)
        .orWhen(ConfigFolderStructure.at(basePaths.globalDir).exists)
        .then(() => basePaths.globalDir)
        .orWhen(customPath != null && ConfigFolderStructure.at(customPath).exists)
        .then(() => basePaths.customDir!)
        .orNone();

    if (basePath.isNone()) {
      provide<CLAController>()
          .terminate(Print('No ${ConfigFolderConstants.folderNames.main} found'));
    }

    return ConfigFolderStructure.at(basePath.get());
  }
}
