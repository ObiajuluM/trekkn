enum Flavor {
  prod,
  dev,
}

// # singleton class: ensures there is only one global instance of a class
class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  // final String googleClientId;

  // declare static variable with the same type as class to create the singleton
  static FlavorConfig? _instance;

  //  create private constructor
  FlavorConfig._(
    this.flavor,
    // this.googleClientId,
    String? baseUrl,
  ) : baseUrl = baseUrl ?? "https://api.walkitapp.com/";

  // factory constructor: checks if instance is null, if it is, create one, else return existing one
  factory FlavorConfig({
    required Flavor flavor,
    // required String googleClientId,
    required String baseUrl,
  }) {
    _instance ??= FlavorConfig._(
      flavor,
      // googleClientId,
      baseUrl,
    );
    return _instance!;
  }

  // static getter: to get an instance of the class without needing to instantiate it
  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception("FlavorConfig not initialized");
    }
    return _instance!;
  }

  Flavor get currentFlavor => flavor;

  // static checkers
  bool get isProd => flavor == Flavor.prod;

  bool get isDev => flavor == Flavor.dev;
}
