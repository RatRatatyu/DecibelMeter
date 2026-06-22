import 'package:sound_metter/uiStyle/style.dart';
import 'package:flutter/material.dart';

enum LayoutType { compact, medium, expanded }

class AppLayout {
  final LayoutType type;
  final IAppSizes sizes;

  const AppLayout(this.type, this.sizes);

  bool get isCompact => type == LayoutType.compact;
  bool get isMedium => type == LayoutType.medium;
  bool get isExpanded => type == LayoutType.expanded;

}


class LayoutProvider extends InheritedWidget {
  final AppLayout layout;

  const LayoutProvider({
    super.key,
    required super.child,
    required this.layout,
  });

  static AppLayout of(BuildContext context) {
    final  result = context.dependOnInheritedWidgetOfExactType<LayoutProvider>();
    assert(result != null, 'No LayoutProvider found in context');
    return result!.layout;
  }

  @override
  bool updateShouldNotify(LayoutProvider oldWidget) {
    return oldWidget.layout.type != layout.type ||
        oldWidget.layout.sizes.grid != layout.sizes.grid;
  }
}
