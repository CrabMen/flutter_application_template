enum Flavor {
  env_dev,
  env_release,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.env_dev:
        return '模板工程(测试)';
      case Flavor.env_release:
        return '模板工程';
      default:
        return 'title';
    }
  }

}
