import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class MappedRadiusExample extends Example {
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
    String polygonsGeoJson = await GeoJsonAsset.polygons();
    String pointsGeoJson = await GeoJsonAsset.points();

    MapDataSource polygons =
        await MapDataSource.geoJson(geoJson: polygonsGeoJson);
    MapLayer polygonsLayer = MapLayer(dataSource: polygons);
    _controller.addLayer(polygonsLayer);

    MapDataSource points = await MapDataSource.geoJson(
        geoJson: pointsGeoJson, keys: ['AN'], labelKey: 'AN');
    MapLayer pointsLayer = MapLayer(
        dataSource: points,
        theme: MapTheme(
            color: Colors.black,
            labelVisibility: (feature) => true,
            markerBuilder: CircleMakerBuilder.map(
                key: 'AN', radiuses: {41: 25, 22: 20, 14: 10, 10: 10})));
    _controller.addLayer(pointsLayer);
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
