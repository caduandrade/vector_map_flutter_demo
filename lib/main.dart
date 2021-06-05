import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_map_demo/brazil_states_page.dart';
import 'package:vector_map_demo/click_listener_page.dart';
import 'package:vector_map_demo/color_by_rule_page.dart';
import 'package:vector_map_demo/color_by_value_page.dart';
import 'package:vector_map_demo/contour_page.dart';
import 'package:vector_map_demo/default_colors_page.dart';
import 'package:vector_map_demo/enable_hover_by_value_page.dart';
import 'package:vector_map_demo/get_started_page.dart';
import 'package:vector_map_demo/gradient_page.dart';
import 'package:vector_map_demo/hover_layer_page.dart';
import 'package:vector_map_demo/hover_page.dart';
import 'package:vector_map_demo/label_page.dart';
import 'package:vector_map_demo/marker_page.dart';
import 'package:vector_map_demo/menu.dart';
import 'package:vector_map_demo/multi_layer_page.dart';
import 'package:vector_map_demo/parser_page.dart';

void main() {
  runApp(VectorMapDemoApp());
}

class VectorMapDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vector Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VectorMapDemoPage(),
    );
  }
}

class VectorMapDemoPage extends StatefulWidget {
  @override
  VectorMapDemoPageState createState() => VectorMapDemoPageState();
}

class VectorMapDemoPageState extends State<VectorMapDemoPage> {
  late List<MenuItem> _menuItems;
  ContentBuilder? _currentExampleBuilder;
  String? polygonsGeoJSON;
  String? pointsGeoJSON;
  String? brazilCountiesGeoJSON;
  String? brazilStatesGeoJSON;

  @override
  void initState() {
    super.initState();
    _menuItems = [
      MenuItem('Brazil states', _brazilStatesPage),
      MenuItem('Get Started', _getStartedPage),
      MenuItem('Default colors', _defaultColorsPage),
      MenuItem('Color by value', _colorByValuePage),
      MenuItem('Contour', _contourPage),
      MenuItem('Enable hover by value', _enableHoverByValuePage),
      MenuItem('Click listener', _clickListenerPage),
      MenuItem('Color by rule', _colorByRulePage),
      MenuItem('Gradient', _gradientPage),
      MenuItem('Parser', _parserPage),
      MenuItem('Hover', _hoverPage),
      MenuItem('Label', _labelPage),
      MenuItem('Multi layer', _multiLayerPage),
      MenuItem('Hover layer', _hoverLayerPage),
      MenuItem('Marker', _markerPage)
    ];
    if (_menuItems.isNotEmpty) {
      _currentExampleBuilder = _menuItems.first.builder;
    }
    rootBundle.loadString('assets/polygons.json').then((json) {
      // _printPolygonProperties(json);
      setState(() {
        polygonsGeoJSON = json;
      });
    });
    rootBundle.loadString('assets/points.json').then((json) {
      // _printPointsProperties(json);
      setState(() {
        pointsGeoJSON = json;
      });
    });
    rootBundle.loadString('assets/brazil_counties.json').then((json) {
      setState(() {
        brazilCountiesGeoJSON = json;
      });
    });
    rootBundle.loadString('assets/brazil_states.json').then((json) {
      setState(() {
        brazilStatesGeoJSON = json;
      });
    });
  }

  _printPolygonProperties(String geojson) async {
    print('Name | Seq | Rnd');
    print('--- | --- | ---');
    Map<String, dynamic> map = await json.decode(geojson);
    List features = map['features']!;
    for (Map<String, dynamic> feature in features) {
      Map<String, dynamic> properties = feature['properties'];
      String name = properties['Name'];
      int seq = properties['Seq'];
      String rnd = '';
      if (properties.containsKey('Rnd')) {
        rnd = properties['Rnd'];
        rnd = '"$rnd"';
      }
      print('"$name" | $seq | $rnd');
    }
  }

  _printPointsProperties(String geojson) async {
    print('Name | AN');
    print('--- | ---');
    Map<String, dynamic> map = await json.decode(geojson);
    List features = map['features']!;
    for (Map<String, dynamic> feature in features) {
      Map<String, dynamic> properties = feature['properties'];
      String name = properties['Name'];
      int atomicNumber = properties['AN'];
      print('"$name" | $atomicNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;
    if (polygonsGeoJSON == null ||
        pointsGeoJSON == null ||
        brazilStatesGeoJSON == null ||
        brazilCountiesGeoJSON == null) {
      body = Center(child: Text('Loading...'));
    } else {
      Widget exampleMenu = Container(
        child: MenuWidget(
            contentBuilderUpdater: _updateExampleContentBuilder,
            menuItems: _menuItems),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.blue))),
      );

      body = Row(
          children: [exampleMenu, Expanded(child: _buildExample())],
          crossAxisAlignment: CrossAxisAlignment.stretch);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Vector Map Demo'),
        ),
        body: body);
  }

  _updateExampleContentBuilder(ContentBuilder contentBuilder) {
    setState(() {
      _currentExampleBuilder = contentBuilder;
    });
  }

  Widget _buildExample() {
    if (_currentExampleBuilder != null) {
      return _currentExampleBuilder!();
    }
    return Center();
  }

  GetStartedPage _getStartedPage() {
    return GetStartedPage();
  }

  ColorByValuePage _colorByValuePage() {
    return ColorByValuePage();
  }

  DefaultColorsPage _defaultColorsPage() {
    return DefaultColorsPage();
  }

  ContourPage _contourPage() {
    return ContourPage();
  }

  EnableHoverByValuePage _enableHoverByValuePage() {
    return EnableHoverByValuePage();
  }

  ClickListenerPage _clickListenerPage() {
    return ClickListenerPage();
  }

  ColorByRulePage _colorByRulePage() {
    return ColorByRulePage();
  }

  GradientPage _gradientPage() {
    return GradientPage();
  }

  ParserPage _parserPage() {
    return ParserPage();
  }

  HoverPage _hoverPage() {
    return HoverPage();
  }

  LabelPage _labelPage() {
    return LabelPage();
  }

  MultiLayerPage _multiLayerPage() {
    return MultiLayerPage();
  }

  HoverLayerPage _hoverLayerPage() {
    return HoverLayerPage();
  }

  MarkerPage _markerPage() {
    return MarkerPage();
  }

  BrazilStatesPage _brazilStatesPage() {
    return BrazilStatesPage();
  }
}
