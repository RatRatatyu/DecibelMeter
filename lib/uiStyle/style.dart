
abstract class IAppSizes {
  double get grid;
  double get iconSize;

  // padding
  double get xs => grid * 0.5;
  double get s  => grid * 1.0;
  double get m  => grid * 2.0;
  double get l  => grid * 6.0;

  // Icons
  double get iconSm => iconSize * 0.75;
  double get iconMd => iconSize;
  double get iconLg => iconSize * 1.5;
}

class MobileSizes extends IAppSizes {
  @override
  double get grid => 8.0;
  @override
  double get iconSize => 24.0;
}

class TabletSizes extends IAppSizes {
  @override
  double get grid => 16.0;
  @override
  double get iconSize => 28.0;
}


























