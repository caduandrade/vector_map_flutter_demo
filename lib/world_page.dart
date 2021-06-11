import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

import 'example_page.dart';

class WorldPage extends StatefulWidget {
  @override
  WorldPageState createState() => WorldPageState();
}

class WorldPageState extends ExamplePageState {
  @override
  bool isSized() {
    return false;
  }

  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource world = await MapDataSource.geoJSON(geojson: worldGeoJSON);
    MapDataSource worldMarkers = await MapDataSource.geoJSON(
        geojson: worldMarkersGeoJSON, keys: ['size']);

    return DataSources(world: world, worldMarkers: worldMarkers);
  }

  @override
  MapDebugger? buildDebugger() {
    MapDebugger debugger = MapDebugger();
    return debugger;
  }

  @override
  Widget buildContent() {
    MapLayer layer1 = MapLayer(
        dataSource: world,
        theme: MapTheme(contourColor: Colors.white, color: Colors.grey));
    MapLayer layer2 = MapLayer(
        dataSource: worldMarkers,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            key: 'size',
            colors: [Colors.blue.withAlpha(100), Colors.green.withAlpha(100)],
            markerBuilder: CircleMakerBuilder.property(key: 'size')));

    VectorMap map = VectorMap(debugger: debugger, layers: [layer1, layer2]);

    return map;
  }
}
