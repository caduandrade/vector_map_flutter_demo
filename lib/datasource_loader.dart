import 'package:vector_map/vector_map.dart';
import 'package:vector_map_demo/geojson_asset.dart';

class DataSourceLoader {
  static Future<MapDataSource> polygons() async {
    String geoJson = await GeoJsonAsset.polygons();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> points() async {
    String geoJson = await GeoJsonAsset.points();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> brazilCounties() async {
    String geoJson = await GeoJsonAsset.brazilCounties();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> brazilStates() async {
    String geoJson = await GeoJsonAsset.brazilStates();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> world() async {
    String geoJson = await GeoJsonAsset.world();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> worldMarkers() async {
    String geoJson = await GeoJsonAsset.worldMarkers();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> brazilLines() async {
    String geoJson = await GeoJsonAsset.brazilLines();
    return MapDataSource.geoJson(geoJson: geoJson);
  }

  static Future<MapDataSource> brazil() async {
    String geoJson = await GeoJsonAsset.brazil();
    return MapDataSource.geoJson(geoJson: geoJson);
  }
}
