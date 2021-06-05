import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

import 'example_page.dart';

class BrazilCountiesPage extends StatefulWidget {
  @override
  BrazilCountiesPageState createState() => BrazilCountiesPageState();
}

class BrazilCountiesPageState extends ExamplePageState {
  @override
  bool isSized() {
    return false;
  }

  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource brazilStates = await MapDataSource.geoJSON(
        geojson: brazilCountiesGeoJSON, keys: ['id'], parseToNumber: ['id']);

    return DataSources(brazilStates: brazilStates);
  }

  @override
  MapDebugger? buildDebugger() {
    MapDebugger debugger = MapDebugger();
    return debugger;
  }

  @override
  Widget buildContent() {
    MapLayer layer = MapLayer(
        dataSource: brazilStates,
        theme: MapTheme.gradient(
            contourColor: Colors.green[800],
            key: 'id',
            colors: [Colors.yellow, Colors.lightGreen]),
        hoverTheme: MapTheme(color: Colors.green[900]));

    VectorMap map = VectorMap(debugger: debugger, layers: [layer]);

    return map;
  }
}
