import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/example_with_debugger.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class WorldExample extends ExampleWithDebugger{
  @override
  Widget buildMainWidget(BuildContext context) =>MainWidget(debugger);

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
    String worldGeoJson = await GeoJsonAsset.world();
    String worldMarkersGeoJson = await GeoJsonAsset.worldMarkers();

    MapDataSource world = await MapDataSource.geoJson(geoJson: worldGeoJson);
    _controller.addLayer(MapLayer(dataSource: world,theme: MapTheme(contourColor: Colors.white, color: Colors.grey)));

    MapDataSource worldMarkers = await MapDataSource.geoJson(
        geoJson: worldMarkersGeoJson, keys: ['size']);
    _controller.addLayer(MapLayer(dataSource: worldMarkers, theme: MapGradientTheme(
        contourColor: Colors.white,
        key: 'size',
        colors: [Colors.blue.withAlpha(100), Colors.green.withAlpha(100)],
        markerBuilder: CircleMakerBuilder.property(key: 'size'))));
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }



}
