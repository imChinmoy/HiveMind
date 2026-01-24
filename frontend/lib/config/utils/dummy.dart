class DummyUtils {
  static List<Map<String, dynamic>> getServers() {
    return dummyServers;
  }
}




final List<Map<String, dynamic>> dummyServers = [
  {
    "id": "srv_001",
    "name": "Dev Lounge",
    "icon": "https://cdn-icons-png.flaticon.com/512/5968/5968292.png",
    "isLive": true,
    "liveTitle": "Live Flutter Coding",
    "viewerCount": 128,
    "channels": [
      {"id": "ch_001", "name": "general"},
      {"id": "ch_002", "name": "flutter"},
      {"id": "ch_003", "name": "backend"},
      {"id": "ch_004", "name": "announcements"},
    ],
    "members": [
      {
        "id": "u1",
        "username": "Chinmoy",
        "avatar": "https://i.pravatar.cc/150?img=1",
        "status": "online",
      },
      {
        "id": "u2",
        "username": "Aarav",
        "avatar": "https://i.pravatar.cc/150?img=2",
        "status": "offline",
      },
      {
        "id": "u3",
        "username": "Riya",
        "avatar": "https://i.pravatar.cc/150?img=3",
        "status": "online",
      },
    ],
  },
  {
    "id": "srv_002",
    "name": "Campus Hub",
    "icon": "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
    "isLive": false,
    "liveTitle": null,
    "viewerCount": 0,
    "channels": [
      {"id": "ch_005", "name": "general"},
      {"id": "ch_006", "name": "events"},
      {"id": "ch_007", "name": "placements"},
    ],
    "members": [
      {
        "id": "u4",
        "username": "Rahul",
        "avatar": "https://i.pravatar.cc/150?img=4",
        "status": "online",
      },
      {
        "id": "u5",
        "username": "Sneha",
        "avatar": "https://i.pravatar.cc/150?img=5",
        "status": "offline",
      },
    ],
  },
  {
    "id": "srv_003",
    "name": "Gaming Arena",
    "icon": "https://cdn-icons-png.flaticon.com/512/3612/3612569.png",
    "isLive": true,
    "liveTitle": "Valorant Night",
    "viewerCount": 342,
    "channels": [
      {"id": "ch_008", "name": "general"},
      {"id": "ch_009", "name": "valorant"},
      {"id": "ch_010", "name": "clips"},
    ],
    "members": [
      {
        "id": "u6",
        "username": "ShadowX",
        "avatar": "https://i.pravatar.cc/150?img=6",
        "status": "online",
      },
      {
        "id": "u7",
        "username": "Nova",
        "avatar": "https://i.pravatar.cc/150?img=7",
        "status": "online",
      },
      {
        "id": "u8",
        "username": "Pixel",
        "avatar": "https://i.pravatar.cc/150?img=8",
        "status": "offline",
      },
    ],
  },
];
