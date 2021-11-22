import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class LinesExample extends Example {
  @override
  Widget buildMainWidget(BuildContext context) => MainWidget();
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  VectorMapController _controller = VectorMapController();

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  void _loadGeoJson() async {
    String brazilGeoJson = await GeoJsonAsset.brazil();
    String linesGeoJson = await GeoJsonAsset.brazilLines();

    MapHighlightTheme highlightTheme = MapHighlightTheme(color: Colors.green);

    MapDataSource brazil = await MapDataSource.geoJson(geoJson: brazilGeoJson);

    MapLayer brazilLayer =
        MapLayer(dataSource: brazil, highlightTheme: highlightTheme);
    _controller.addLayer(brazilLayer);

    MapDataSource lines = await MapDataSource.geoJson(geoJson: linesGeoJson);
    MapLayer linesLayer = MapLayer(
        dataSource: lines,
        theme: MapTheme(color: Colors.black),
        highlightTheme: highlightTheme);
    _controller.addLayer(linesLayer);
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
