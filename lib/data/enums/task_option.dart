import 'package:assessment/resources/utils/extensions.dart';

enum TaskOption {
  all,
  completed,
  uncompleted;

  String get title {
    switch (this) {
      case TaskOption.all:
        return '';
      default:
        return name.capitalize;
    }
  }
}
