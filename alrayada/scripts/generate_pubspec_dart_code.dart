// ignore_for_file: avoid_print

import 'dart:io' show File, Process, exit;

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

// Extract data like the app version from pubspec.yaml file into Dart code

void main(List<String> args) async {
  final pubspecYamlFile = File('./pubspec.yaml');
  final pubspecYamlText = await pubspecYamlFile.readAsString();
  final pubspecYaml = loadYaml(pubspecYamlText) as YamlMap;

  final fullVersion = pubspecYaml['version'].toString();
  final version = fullVersion.split('+')[0];
  final versionBuildNumber = fullVersion.split('+')[1];
  final topics = (pubspecYaml['topics'] as YamlList?)?.map((e) => "'$e'");

  final pubspecDartClassFileDestination =
      (pubspecYaml['pubspec_extract'] as YamlMap)['destination'] as String?;

  if (pubspecDartClassFileDestination == null) {
    print(
      'The class file destination is not set in pubspec.yaml. Add pubspec_extract.destination to ${path.basename(pubspecYamlFile.path)}',
    );
    exit(1);
  }

  final generatedDartFile = '''
class Pubspec {
  Pubspec._();

  static const name = '${pubspecYaml['name']}';
  static const fullVersion = '$fullVersion';
  static const version = '$version';
  static const versionBuildNumber = $versionBuildNumber;
  static const description = '${pubspecYaml['description'] ?? ''}';
  static const repository = '${pubspecYaml['repository'] ?? ''}';
  static const homepage = '${pubspecYaml['homepage'] ?? ''}';
  static const issueTracker = '${pubspecYaml['issue_tracker'] ?? ''}';
  static const documentation = '${pubspecYaml['documentation'] ?? ''}';
  static const topics = [${topics?.join(', ') ?? ''}];
}
''';

  final pubspecFileDestination = File(pubspecDartClassFileDestination);
  if (!(await pubspecFileDestination.exists())) {
    print(
      "The file `${pubspecYamlFile.path}` doesn't exist. Please create it first.",
    );
    exit(1);
  }
  await pubspecFileDestination.writeAsString(generatedDartFile);
  await Process.run('dart', ['format', pubspecFileDestination.path]);
}
