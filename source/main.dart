import 'dart:io';
import 'dart:convert';

void main() {
  final String workingDirectoryPath = Directory.current.path;
  final Directory workingDirectory = Directory(workingDirectoryPath);

  final String gitignoreFilePath = [workingDirectory.path, '.gitignore'].join(Platform.pathSeparator);
  final File gitignoreFile = File(gitignoreFilePath);

  if (!gitignoreFile.existsSync()) {
    return print('No .gitignore file was found in working directory');
  }

  final String vscodeDirectoryPath = [workingDirectory.path, '.vscode'].join(Platform.pathSeparator);
  final Directory vscodeDirectory = Directory(vscodeDirectoryPath);

  if (!vscodeDirectory.existsSync()) {
    vscodeDirectory.createSync();
  }

  final String settingsFilePath = [vscodeDirectoryPath, 'settings.json'].join(Platform.pathSeparator);
  final File settingsFile = File(settingsFilePath);

  if (!settingsFile.existsSync()) {
    settingsFile.writeAsStringSync('{}');
  }

  final String gitignoreFileContent = gitignoreFile.readAsStringSync();
  final Iterable gitignoreFileDirectives = gitignoreFileContent.split('\n').where((line) => line.length >= 1 && !line.startsWith('#'));

  String settingsFileContent = settingsFile.readAsStringSync();

  try {
    final Map settingsFileDirectives = json.decode(settingsFileContent);

    if (settingsFileDirectives['files.exclude'] == null) {
      settingsFileDirectives['files.exclude'] = {};
    }

    for (final directive in gitignoreFileDirectives) {
      if (settingsFileDirectives['files.exclude'][directive] != true) {
        settingsFileDirectives['files.exclude'][directive] = true; 
      }
    }

    settingsFileContent = JsonEncoder.withIndent('  ').convert(settingsFileDirectives);
    settingsFile.writeAsStringSync(settingsFileContent);
  }

  catch (exception) {
    print('The settings.json file is invalid');
  }
}