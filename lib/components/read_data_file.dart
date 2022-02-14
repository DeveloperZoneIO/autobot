import 'package:autobot/common/collection_util.dart';
import 'package:autobot/components/read_yaml.dart';
import 'package:autobot/components/yaml_to_map.dart';

Map<String, dynamic> readDataFromFiles(List<String> paths) {
  final yamls = paths.map(readYaml);
  final contentMaps = yamls.map(yamlToMap);
  return contentMaps.isEmpty ? {} : contentMaps.reduce(merge);
}

Map<String, dynamic>? tryReadDataFromFile(List<String> paths) {
  try {
    return readDataFromFiles(paths);
  } catch (_) {
    return null;
  }
}
