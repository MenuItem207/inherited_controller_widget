import 'package:flutter/material.dart';
import 'package:inherited_controller_widget/src/inherited_controller.dart';

/// wrap this directly around MaterialApp(), access the controller by calling
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
  static T? getControllerMaybe<T>(
    BuildContext context,
  ) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
    if (inheritedWidget != null) {
      return inheritedWidget.controller.subControllersMap[T] as T;
    }
    return null;
  }

  /// returns the relevant controller stored in [InheritedController]
  static T getController<T>(
    BuildContext context,
  ) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
    assert(inheritedWidget != null, 'No InheritedControllerWidget found');
    return inheritedWidget!.controller.subControllersMap[T] as T;
  }

  /// replaces a controller
  static void replaceController(
    BuildContext context,
    dynamic newController, {
    /// provide this if you want to notify specific children
    String? updateKey,
  }) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
    inheritedWidget!.controller.subControllersMap[newController.runtimeType] =
        newController;

    if (updateKey != null) {
      inheritedWidget.controller.valueNotifiersMap[updateKey]!
          .notifyListeners();
    }
  }

  @override
  bool updateShouldNotify(InheritedControllerWidget oldWidget) {
    return false;
  }
}
