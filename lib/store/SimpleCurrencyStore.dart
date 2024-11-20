import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:simple_currency/utils/logger.dart';

import '../objectbox.g.dart';

// late final ObjectBox _objectBox;
late final Store store;

abstract class SimpleCurrencyStore {

  static final log = Logger('SimpleCurrencyStore');

  static Future<void> initializeStore() async {
    /*_objectBox = await ObjectBox._create();
    store = _objectBox.store;*/

    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    store = await openStore(directory: path.join(docsDir.path, "simple-currency-db"));
    // return SimpleCurrencyStore._create(store);
    

    /*if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      admin = Admin(store);
    }

    // (Optional) Close at some later point.
    // admin?.close();

    if (kDebugMode && FeatureFlags.wipeDatabaseOnStart) {
      log.w('***********************************************************************');
      log.w('**** FeatureFlags.wipeDatabaseOnStart set to true, WIPING ALL DATA ****');
      log.w('***********************************************************************');
      spot<AUserDao>().deleteAll(areYouReallySure: true);
      spot<APostDao>().deleteAll(areYouReallySure: true);
    }*/
  }
}
