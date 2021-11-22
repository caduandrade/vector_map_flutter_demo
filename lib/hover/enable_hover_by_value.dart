import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class EnableHoverByValueExample extends Example {
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
    String geoJson = await GeoJsonAsset.polygons();

    MapDataSource polygons =
        await MapDataSource.geoJson(geoJson: geoJson, keys: ['Seq']);
    // coloring only the 'Darwin' feature
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapValueTheme(key: 'Seq', colors: {4: Colors.green}),
        highlightTheme: MapHighlightTheme(color: Colors.green[900]!));
    _controller.addLayer(layer);
  }

  @override
  Widget build(BuildContext context) {
    // enabling hover only for the 'Darwin' feature
    VectorMap map = VectorMap(
        controller: _controller,
        hoverRule: (feature) {
          return feature.getValue('Seq') == 4;
        });
    return map;
  }
}
