import 'package:frontend/features/server/data/models/server_model.dart';
import 'package:frontend/features/server/data/models/channel_model.dart';
import 'package:frontend/features/server/data/models/message_model.dart';
import 'package:hive/hive.dart';

abstract class ServerLocalDatasource {
  Future<void> cacheMyServers(List<ServerModel> servers);
  Future<List<ServerModel>> getCachedMyServers();

  Future<void> cacheExploreServers(List<ServerModel> servers);
  Future<List<ServerModel>> getCachedExploreServers();

  Future<void> cacheChannels(String serverId, List<ChannelModel> channels);
  Future<List<ChannelModel>> getCachedChannels(String serverId);

  Future<void> cacheMessages(String channelId, List<MessageModel> messages);
  Future<List<MessageModel>> getCachedMessages(String channelId);

  Future<void> clearMyServersCache();
  Future<void> clearExploreServersCache();
  Future<void> clearChannelsCache(String serverId);
  Future<void> clearMessagesCache(String channelId);
  Future<void> clearAll();
}

class ServerLocalDatasourceImpl implements ServerLocalDatasource {
  final Box _myServersBox = Hive.box('myServers');
  final Box _exploreServersBox = Hive.box('exploreServers');
  final Box _channelsBox = Hive.box('channels');
  final Box _messagesBox = Hive.box('messages');

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
  Future<void> cacheChannels(
    String serverId,
    List<ChannelModel> channels,
  ) async {
    final jsonList = channels.map((c) => c.toJson()).toList();
    await _channelsBox.put(serverId, jsonList);
  }

  @override
  Future<List<ChannelModel>> getCachedChannels(String serverId) async {
    final data = _channelsBox.get(serverId);
    if (data == null) return [];

    final List rawList = data;
    return rawList
        .map((e) => ChannelModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> cacheMessages(
    String channelId,
    List<MessageModel> messages,
  ) async {
    final jsonList = messages.map((m) => m.toJson()).toList();
    await _messagesBox.put(channelId, jsonList);
  }

  @override
  Future<List<MessageModel>> getCachedMessages(String channelId) async {
    final data = _messagesBox.get(channelId);
    if (data == null) return [];

    final List rawList = data;
    return rawList
        .map((e) => MessageModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> clearChannelsCache(String serverId) async {
    await _channelsBox.delete(serverId);
  }

  @override
  Future<void> clearMessagesCache(String channelId) async {
    await _messagesBox.delete(channelId);
  }

  @override
  Future<void> clearAll() async {
    await _myServersBox.clear();
    await _exploreServersBox.clear();
    await _channelsBox.clear();
    await _messagesBox.clear();
  }
}
