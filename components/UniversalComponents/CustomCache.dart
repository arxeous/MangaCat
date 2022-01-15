import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Class - CustomCache
// Functionality - This class allows us to control how many image we may want to cache, and for how long we want to cache them for. This allows for the app to look fast since images will be able to be loaded instantly
//                  if the user has already seen them. The actual code is pretty simple, we just specicy the above variables by naming stalePeriod and maxNrOfCacheObjects respectively.



class CustomCache {
  static customCahce() {
    return CacheManager(
      Config(
          'customCache',
          stalePeriod: Duration(days: 1),
          maxNrOfCacheObjects: 100,
      ),
    );
  }
}