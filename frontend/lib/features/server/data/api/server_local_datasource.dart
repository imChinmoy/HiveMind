import 'package:frontend/features/server/data/models/server_model.dart';
import 'package:hive/hive.dart';

abstract class ServerLocalDatasource {
  Future<void> cacheMyServers(List<ServerModel> servers);
  Future<List<ServerModel>> getCachedMyServers();

  Future<void> cacheExploreServers(List<ServerModel> servers);
  Future<List<ServerModel>> getCachedExploreServers();

  Future<void> clearMyServersCache();
  Future<void> clearExploreServersCache();
  Future<void> clearAll();
}

class ServerLocalDatasourceImpl implements ServerLocalDatasource {
  final Box _myServersBox = Hive.box('myServers');
  final Box _exploreServersBox = Hive.box('exploreServers');

  @override
  Future<void> cacheMyServers(List<ServerModel> servers) async {
    final jsonList = servers.map((s) => s.toJson()).toList();
    await _myServersBox.put('myServers', jsonList);
    await _myServersBox.put('cachedAt', DateTime.now().toIso8601String());
  }

  @override
  Future<List<ServerModel>> getCachedMyServers() async {
    final data = _myServersBox.get('myServers');
    if (data == null) return [];

    final List rawList = data;
    return rawList
        .map((e) => ServerModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

 
  @override
  Future<void> cacheExploreServers(List<ServerModel> servers) async {
    final jsonList = servers.map((s) => s.toJson()).toList();
    await _exploreServersBox.put('exploreServers', jsonList);
    await _exploreServersBox.put('cachedAt', DateTime.now().toIso8601String());
  }

  @override
  Future<List<ServerModel>> getCachedExploreServers() async {
    final data = _exploreServersBox.get('exploreServers');
    if (data == null) return [];

    final List rawList = data;
    return rawList
        .map((e) => ServerModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

 
  @override
  Future<void> clearMyServersCache() async {
    await _myServersBox.clear();
  }

  @override
  Future<void> clearExploreServersCache() async {
    await _exploreServersBox.clear();
  }

  @override
  Future<void> clearAll() async {
    await _myServersBox.clear();
    await _exploreServersBox.clear();
  }
}
