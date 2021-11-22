import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/example_with_debugger.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class BrazilCountiesExample extends ExampleWithDebugger {
  @override
  Widget buildMainWidget(BuildContext context) => MainWidget(debugger);
}

class MainWidget extends StatefulWidget {
  const MainWidget(this.debugger);
  final MapDebugger debugger;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  late VectorMapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VectorMapController(debugger: widget.debugger);
    _loadGeoJson();
  }

  void _loadGeoJson() async {
    String geoJson = await GeoJsonAsset.brazilCounties();

    MapDataSource brazilCounties = await MapDataSource.geoJson(
        geoJson: geoJson, keys: ['id'], parseToNumber: ['id']);
    MapLayer layer = MapLayer(
        dataSource: brazilCounties,
        theme: MapGradientTheme(
            contourColor: Colors.green[800],
            key: 'id',
            colors: [Colors.yellow, Colors.lightGreen]),
        highlightTheme: MapHighlightTheme(color: Colors.green[900]));
    _controller.addLayer(layer);
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
        controller: _controller,
        placeHolder: Center(child: Text('Loading...')));
  }
}
