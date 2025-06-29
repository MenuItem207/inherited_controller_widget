import 'package:flutter/material.dart';
import 'package:inherited_controller_widget/src/inherited_controller.dart';

/// usage:
/// [RandomSubController randomSubController = getController<RandomSubController>();]
/// reduces the boilerplate needed [InheritedControllerWidget.getController<RandomSubController>()]
T getController<T>(BuildContext context) {
  return InheritedControllerWidget.getController<T>(context);
}

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
  static void replaceController(BuildContext context, dynamic newController) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();
    inheritedWidget!.controller.subControllersMap[newController.runtimeType] =
        newController;
    inheritedWidget.controller.shouldNotify = true;
  }

  /// can be called even after initial initialisation, handle your own init()
  static void addSubController<T>(BuildContext context, T newSubController) {
    final InheritedControllerWidget? inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedControllerWidget>();

    inheritedWidget!.controller.subControllersMap[T] = newSubController;
    inheritedWidget.controller.shouldNotify = true;
  }

  @override
  bool updateShouldNotify(InheritedControllerWidget oldWidget) {
    if (controller.shouldNotify) {
      controller.shouldNotify = false;
      return true;
    }

    return false;
  }
}
