import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import './app.dart';

abstract class PathDirs {
  static late String data;
  static late String tmp;

  static Future<void> initialize() async {
    data = path.join(
      (await path_provider.getApplicationDocumentsDirectory()).path,
      Config.code,
    );

    tmp = path.join(
      (await path_provider.getTemporaryDirectory()).path,
      Config.code,
    );
  }

  static String get otherData => path.join(data, 'other-data');

  static String get tenka => path.join(data, 'tenka');
}
