import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class ColorByValueExample extends Example {
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

    MapDataSource polygons = await MapDataSource.geoJson(
        geoJson: geoJson, keys: ['Seq'], labelKey: 'Seq');
    MapLayer layer = MapLayer(
        dataSource: polygons,
        theme: MapValueTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Seq',
            colors: {
              2: Colors.green,
              4: Colors.red,
              6: Colors.orange,
              8: Colors.blue
            }));
    _controller.addLayer(layer);
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
