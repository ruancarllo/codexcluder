# About the software

This [command-line](https://en.wikipedia.org/wiki/Command-line_interface) program is a simple tool for hiding files mapped by a [.gitingore](https://git-scm.com/docs/gitignore) file in the [Visual Studio Code](https://code.visualstudio.com) development environment.

## Compilation

To transform this tool's code into an executable binary, install and configure the [Dart](https://dart.dev) language SDK on your computer, open the source code folder in your terminal, and run the following command:

```shell
dart compile exe "main.dart" -o "codexclude"
```

You can add this binary to your `$PATH` environment variable to make it available globally on your system, from the command:

```shell
codexclude
```

## License

This project is licensed under the terms of [BSD Zero Clause License](LICENSE.md), so feel free to use it to help you with any ideas.