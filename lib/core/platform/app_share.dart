import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Store listing + share helpers for Settings / streak CTAs.
abstract final class AppShare {
  static const androidPackageId = 'com.ffslabs.decluttr';

  /// Replace when the App Store listing exists.
  static const iosAppStoreId = '0000000000';

  static Uri get storeListingUri {
    if (Platform.isIOS) {
      return Uri.parse('https://apps.apple.com/app/id$iosAppStoreId');
    }
    return Uri.parse(
      'https://play.google.com/store/apps/details?id=$androidPackageId',
    );
  }

  static Future<bool> openStoreListing() async {
    final uri = storeListingUri;
    if (!await canLaunchUrl(uri)) return false;
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> shareText(String message) {
    return SharePlus.instance.share(ShareParams(text: message));
  }
}
