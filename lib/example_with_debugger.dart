import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

abstract class ExampleWithDebugger extends Example with ExtraWidgetsMixin {
  final MapDebugger debugger = MapDebugger();

  @override
  Widget? buildExtraWidget(BuildContext context, String name) {
    if (name == 'Debugger') {
      return MapDebuggerWidget(debugger);
    }
  }

  @override
  List<String> extraWidgetNames() => ['Debugger'];
}
