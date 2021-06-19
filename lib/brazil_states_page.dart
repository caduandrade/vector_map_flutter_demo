import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

import 'example_page.dart';

class BrazilStatesPage extends StatefulWidget {
  @override
  BrazilStatesPageState createState() => BrazilStatesPageState();
}

class BrazilStatesPageState extends ExamplePageState {
  @override
  bool isSized() {
    return false;
  }

  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource brazilStates = await MapDataSource.geoJSON(
        geojson: brazilStatesGeoJSON, keys: ['REGIAO']);

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
        theme:
            MapValueTheme(contourColor: Colors.black, key: 'REGIAO', colors: {
          'Centro-Oeste': Colors.blue,
          'Sudeste': Colors.green,
          'Sul': Colors.orange,
          'Nordeste': Colors.red,
          'Norte': Colors.yellow
        }),
        highlightTheme: MapHighlightTheme(color: Colors.grey[800]));

    VectorMap map = VectorMap(debugger: debugger, layers: [layer]);

    return map;
  }
}
