import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map_demo/brazil_counties.dart';
import 'package:vector_map_demo/brazil_states.dart';
import 'package:vector_map_demo/click_listener.dart';
import 'package:vector_map_demo/contour/contour_thickness.dart';
import 'package:vector_map_demo/get_started.dart';
import 'package:vector_map_demo/lines.dart';
import 'package:vector_map_demo/marker/circle/circle_marker.dart';
import 'package:vector_map_demo/marker/circle/fixed_radius.dart';
import 'package:vector_map_demo/marker/circle/mapped_radius.dart';
import 'package:vector_map_demo/marker/circle/property_radius.dart';
import 'package:vector_map_demo/marker/circle/proportion_radius.dart';
import 'package:vector_map_demo/contour/no_contour.dart';
import 'package:vector_map_demo/theme/color_by_rule.dart';
import 'package:vector_map_demo/theme/color_by_value.dart';
import 'package:vector_map_demo/theme/label/label_rule.dart';
import 'package:vector_map_demo/theme/label/label_style.dart';
import 'package:vector_map_demo/theme/label/label_visibility.dart';

void main() {
  Size? maxSize;
  //maxSize = Size(400, 300);
  runApp(DemoFluApp(
      title: 'Vector map (?)',
      widgetBackground: Colors.white,
      resizable: true,
      maxSize: maxSize,
      appMenuBuilder: () {
        return [
          MenuItem(name: 'Get started', builder: () => GetStartedExample()),
          MenuItem(name: 'Theme', italic: true),
          MenuItem(
              name: 'Label',
              builder: () => LabelVisibilityExample(),
              indentation: 2),
          MenuItem(
              name: 'Rule', builder: () => LabelRuleExample(), indentation: 3),
          MenuItem(
              name: 'Style',
              builder: () => LabelStyleExample(),
              indentation: 3),
          MenuItem(
              name: 'Color by property value',
              builder: () => ColorByValueExample(),
              indentation: 2),
          MenuItem(
              name: 'Color by rule',
              builder: () => ColorByRuleExample(),
              indentation: 2),
          MenuItem(name: 'Contour', italic: true),
          MenuItem(
              name: 'Thickness',
              builder: () => ContourThicknessExample(),
              indentation: 2),
          MenuItem(
              name: 'No contour',
              builder: () => NoContourExample(),
              indentation: 2),
          MenuItem(name: 'Marker', italic: true),
          MenuItem(
              name: 'Circle',
              builder: () => CircleMarkerExample(),
              indentation: 2),
          MenuItem(
              name: 'Fixed radius',
              builder: () => FixedRadiusExample(),
              indentation: 3),
          MenuItem(
              name: 'Radius by mapping values',
              builder: () => MappedRadiusExample(),
              indentation: 3),
          MenuItem(
              name: 'Radius by property values',
              builder: () => PropertyRadiusExample(),
              indentation: 3),
          MenuItem(
              name: 'Radius in proportion to property values',
              builder: () => ProportionRadiusExample(),
              indentation: 3),
          MenuItem(
              name: 'Click listener',
              builder: () => ClickListenerExample(),
              consoleEnabled: true),
          MenuItem(name: 'Brazil', italic: true),
          MenuItem(
              name: 'Counties',
              builder: () => BrazilCountiesExample(),
              indentation: 2),
          MenuItem(
              name: 'States',
              builder: () => BrazilStatesExample(),
              indentation: 2),
          MenuItem(name: 'Lines (BETA)', builder: () => LinesExample()),
        ];
      }));
}
