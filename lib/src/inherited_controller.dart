import 'package:flutter/material.dart';
import 'package:inherited_controller_widget/src/inherited_sub_controller.dart';

const Map<String, ValueNotifier> defaultNotifiersMap = {};

/// controller that handles [InheritedControllerWidget]
class InheritedController {
  InheritedController({
    required this.subControllersList,
    this.valueNotifiersMap = defaultNotifiersMap,
  });

  /// call this function in main()
  Future init() async {
    for (dynamic subController in subControllersList) {
      // call init if is sub controller
      if (subController is InheritedSubController) {
        await subController.init();
      }
      subControllersMap[subController.runtimeType] =
          subController; // fill up map
    }
  }

  /// a Map of controllers to store your inherited controllers in
  final List subControllersList;

  /// maps the [Type] to the class
  final Map subControllersMap = {};

  /// maps a string (key) to its respective value notifier
  final Map<String, ValueNotifier> valueNotifiersMap;
}
