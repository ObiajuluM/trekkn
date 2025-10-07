import 'package:flutter/foundation.dart';

final licenses = LicenseRegistry.addLicense(() async* {
  yield const LicenseEntryWithLineBreaks(
    ['Walk It Branding Assets'],
    '''MIT License text.\n All rights reserved...\n WWW.''',
  );
});
