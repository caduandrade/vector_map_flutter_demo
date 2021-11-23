import 'package:demoflu/demoflu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class CustomizationLegendExample extends Example {
  @override
  Widget buildMainWidget(BuildContext context) => MainWidget();
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  VectorMapController _controller = VectorMapController();
  List<MapAddon>? _addons;

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  void _loadGeoJson() async {
    String geoJson = await GeoJsonAsset.polygons();

    MapDataSource polygons = await MapDataSource.geoJson(
        geoJson: geoJson, keys: ['Gts'], labelKey: 'Gts');
    MapLayer layer = MapLayer(
        id: 1,
        dataSource: polygons,
        theme: MapGradientTheme(
            contourColor: Colors.white,
            labelVisibility: (feature) => true,
            key: 'Gts',
            colors: [Colors.blue, Colors.yellow, Colors.red]));
    _controller.addLayer(layer);
    setState(() {
      _buildAddons(layer);
    });
  }

  _buildAddons(MapLayer layer) {
    _addons = [
      GradientLegend(
          layer: layer,
          barBorder: Border.all(width: 2),
          barHeight: 50,
          barWidth: 30)
    ];
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(
        controller: _controller,
        layersPadding: EdgeInsets.fromLTRB(8, 8, 56, 8),
        addons: _addons);
    return map;
  }
}
