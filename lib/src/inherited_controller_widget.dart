import 'package:flutter/material.dart';
import 'package:inherited_controller_widget/src/inherited_controller.dart';
import 'package:inherited_controller_widget/src/inherited_sub_controller.dart';

/// use this directly in MaterialApp(), access the controller by calling
class InheritedControllerWidget extends InheritedWidget {
  const InheritedControllerWidget({
    super.key,
    required this.controller,
    required super.child,
  });

  final InheritedController controller;

  static InheritedControllerWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
  }

  static InheritedControllerWidget of(BuildContext context) {
    final InheritedControllerWidget? result = maybeOf(context);
    assert(result != null, 'No InheritedControllerWidget found in context');
    return result!;
  }

  /// returns the relevant controller stored in [InheritedController]
  static T? getController<T extends InheritedSubController>(
    BuildContext context,
    dynamic key,
  ) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
    if (inheritedWidget != null) {
      return inheritedWidget.controller.subControllers[key] as T;
    }
    return null;
  }

  @override
  bool updateShouldNotify(InheritedControllerWidget oldWidget) => false;
}
