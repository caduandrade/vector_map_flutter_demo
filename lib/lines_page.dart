import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';

import 'example_page.dart';

class LinesPage extends StatefulWidget {
  @override
  LinesPageState createState() => LinesPageState();
}

class LinesPageState extends ExamplePageState {
  @override
  Future<DataSources> loadDataSources() async {
    MapDataSource brazil = await MapDataSource.geoJSON(geojson: brazilGeoJSON);
    MapDataSource lines =
        await MapDataSource.geoJSON(geojson: brazilLinesGeoJSON);
    return DataSources(brazil: brazil, brazilLines: lines);
  }

  @override
  Widget buildContent() {
    MapHighlightTheme highlightTheme = MapHighlightTheme(color: Colors.green);

    MapLayer brazilLayer =
        MapLayer(dataSource: brazil, highlightTheme: highlightTheme);
    MapLayer brazilLinesLayer = MapLayer(
        dataSource: brazilLines,
        theme: MapTheme(color: Colors.black),
        highlightTheme: highlightTheme);

    VectorMap map = VectorMap(layers: [brazilLayer, brazilLinesLayer]);
    return map;
  }
}
