import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/example_with_debugger.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class BrazilStatesExample extends ExampleWithDebugger {
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
    String geoJson = await GeoJsonAsset.brazilStates();

    MapDataSource dataSource =
        await MapDataSource.geoJson(geoJson: geoJson, keys: ['REGIAO']);
    MapLayer layer = MapLayer(
        dataSource: dataSource,
        theme:
            MapValueTheme(contourColor: Colors.black, key: 'REGIAO', colors: {
          'Centro-Oeste': Colors.blue,
          'Sudeste': Colors.green,
          'Sul': Colors.orange,
          'Nordeste': Colors.red,
          'Norte': Colors.yellow
        }),
        highlightTheme: MapHighlightTheme(color: Colors.grey[800]));
    _controller.addLayer(layer);
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
        controller: _controller,
        placeHolder: Center(child: Text('Loading...')));
  }
}
