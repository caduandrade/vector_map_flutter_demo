import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/main.dart';

import 'menu.dart';

class DataSources {
  DataSources(
      {this.polygons,
      this.points,
      this.brazilStates,
      this.brazilCounties,
      this.world,
      this.worldMarkers,
      this.brazil,
      this.brazilLines});

  final MapDataSource? polygons;
  final MapDataSource? points;
  final MapDataSource? brazilStates;
  final MapDataSource? brazilCounties;
  final MapDataSource? world;
  final MapDataSource? worldMarkers;
  final MapDataSource? brazil;
  final MapDataSource? brazilLines;
}

abstract class ExamplePageState extends State<StatefulWidget> {
  late List<MenuItem> _menuItems;
  ContentBuilder? _currentBuilder;

  MultiSplitViewController _horizontalController =
      MultiSplitViewController(initialWeights: [.1, .8, .1]);
  MultiSplitViewController _verticalController =
      MultiSplitViewController(initialWeights: [.1, .8, .1]);

  late String polygonsGeoJSON;
  late String pointsGeoJSON;
  late String brazilCountiesGeoJSON;
  late String brazilStatesGeoJSON;
  late String worldGeoJSON;
  late String worldMarkersGeoJSON;
  late String brazilLinesGeoJSON;
  late String brazilGeoJSON;

  DataSources? _dataSources;

  MapDebugger? debugger;

  @override
  void initState() {
    super.initState();
    _menuItems = buildMenuItems();
    if (_menuItems.isNotEmpty) {
      _currentBuilder = _menuItems.first.builder;
    }

    debugger = buildDebugger();

    VectorMapDemoPageState? state =
        context.findAncestorStateOfType<VectorMapDemoPageState>();
    if (state != null) {
      this.polygonsGeoJSON = state.polygonsGeoJSON!;
      this.pointsGeoJSON = state.pointsGeoJSON!;
      this.brazilCountiesGeoJSON = state.brazilCountiesGeoJSON!;
      this.brazilStatesGeoJSON = state.brazilStatesGeoJSON!;
      this.worldGeoJSON = state.worldGeoJSON!;
      this.worldMarkersGeoJSON = state.worldMarkersGeoJSON!;
      this.brazilGeoJSON = state.brazilGeoJSON!;
      this.brazilLinesGeoJSON = state.brazilLinesGeoJSON!;
      loadDataSources().then((value) {
        setState(() {
          _dataSources = value;
        });
      });
    } else {
      throw StateError('VectorMapDemoPageState should not be null');
    }
  }

  MapDebugger? buildDebugger() {
    return null;
  }

  Future<DataSources> loadDataSources();

  _updateContentBuilder(ContentBuilder contentBuilder) {
    setState(() {
      _currentBuilder = contentBuilder;
    });
  }

  bool isSized() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];

    if (_menuItems.isNotEmpty) {
      rowChildren.add(Container(
        child: MenuWidget(
            contentBuilderUpdater: _updateContentBuilder,
            menuItems: _menuItems),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.blue))),
      ));
    }

    Widget? content;
    if (_dataSources != null) {
      content = buildContent();
    } else {
      content = Text('Loading...');
    }
    Scaffold scaffold =
        Scaffold(key: UniqueKey(), body: Center(child: content));

    MaterialApp materialApp = MaterialApp(
        theme: buildThemeData(),
        debugShowCheckedModeBanner: false,
        home: scaffold);

    MultiSplitView horizontal = MultiSplitView(
        children: [_buildEmptyArea(), materialApp, _buildEmptyArea()],
        minimalWeight: .1,
        controller: _horizontalController);

    MultiSplitView vertical = MultiSplitView(
        axis: Axis.vertical,
        children: [_buildEmptyArea(), horizontal, _buildEmptyArea()],
        minimalWeight: .1,
        controller: _verticalController);

    if (isSized()) {
      SizedBox sizedBox = SizedBox(child: vertical, width: 591, height: 350);
      Center center = Center(child: sizedBox);
      rowChildren.add(Expanded(child: center));
    } else {
      rowChildren.add(Expanded(child: vertical));
    }

    if (debugger != null) {
      rowChildren.add(Container(
        child: SizedBox(child: MapDebuggerWidget(debugger!), width: 200),
        padding: EdgeInsets.all(8),
        decoration:
            BoxDecoration(border: Border(left: BorderSide(color: Colors.blue))),
      ));
    }

    Row row = Row(
        children: rowChildren, crossAxisAlignment: CrossAxisAlignment.stretch);
    return MultiSplitViewTheme(
        child: Container(child: row, color: Colors.white),
        data: MultiSplitViewThemeData(dividerThickness: 20));
  }

  Widget _buildEmptyArea() {
    return Container(color: Colors.white);
  }

  ThemeData? buildThemeData() {
    return ThemeData(scaffoldBackgroundColor: Colors.white);
  }

  List<MenuItem> buildMenuItems() {
    return [];
  }

  MapDataSource get polygons {
    return _dataSources!.polygons!;
  }

  MapDataSource get points {
    return _dataSources!.points!;
  }

  MapDataSource get brazilCounties {
    return _dataSources!.brazilCounties!;
  }

  MapDataSource get brazilStates {
    return _dataSources!.brazilStates!;
  }

  MapDataSource get world {
    return _dataSources!.world!;
  }

  MapDataSource get worldMarkers {
    return _dataSources!.worldMarkers!;
  }

  MapDataSource get brazil {
    return _dataSources!.brazil!;
  }

  MapDataSource get brazilLines {
    return _dataSources!.brazilLines!;
  }

  Widget buildContent() {
    if (_currentBuilder != null) {
      return _currentBuilder!();
    }
    return Center();
  }
}
