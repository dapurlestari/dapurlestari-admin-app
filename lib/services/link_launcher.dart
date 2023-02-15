
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'constant_lib.dart';
import 'logger.dart';

class LinkLauncher {
  static Future<void> url(String url) async {
    try {
      Future.delayed(Duration.zero, () async {
        launchUrlString(url, mode: LaunchMode.externalApplication).onError((e, stackTrace) {
          logError(e, logLabel: 'launch_url');
          Fluttertoast.showToast(msg: ConstLib.urlLauncherFailed);
          return false;
        });
      });
    } catch (e) {
      logError(e, logLabel: 'launch_url');
      Fluttertoast.showToast(msg: ConstLib.urlLauncherFailed);
    }
  }
}
