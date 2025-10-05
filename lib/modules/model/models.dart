/// ---------------- TrekknUser ----------------
class TrekknUser {
  String? id;
  String? deviceId;
  String? email;
  String? displayname;
  String? username;
  int? goal;
  int? balance;
  int? aura;
  int? level;
  int? streak;
  String? inviteUrl;
  String? invitedBy;
  String? dateJoined;
  String? solAddr;
  String? evmAddr;

  TrekknUser({
    this.id,
    this.deviceId,
    this.email,
    this.username,
    this.goal,
    this.balance,
    this.aura,
    this.level,
    this.streak,
    this.displayname,
    this.dateJoined,
    this.inviteUrl,
    this.invitedBy,
    this.solAddr,
    this.evmAddr,
  });

  factory TrekknUser.fromJson(Map<String, dynamic> json) {
    return TrekknUser(
      id: json['id'],
      deviceId: json['device_id'],
      email: json['email'],
      displayname: json['displayname'],
      username: json['username'],
      goal: json['goal'],
      balance: json['balance'],
      aura: json['aura'],
      level: json['level'],
      streak: json['streak'],
      inviteUrl: json['invite_url'],
      invitedBy: json['invited_by'],
      dateJoined: json['date_joined'],
      solAddr: json["sol_addr"],
      evmAddr: json["evm_addr"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "device_id": deviceId,
      "email": email,
      "displayname": displayname,
      "username": username,
      "goal": goal,
      "balance": balance,
      "aura": aura,
      "level": level,
      "streak": streak,
      "invite_url": inviteUrl,
      "invited_by": invitedBy,
      "dateJoined": dateJoined,
      "sol_addr": solAddr,
      "evm_addr": evmAddr,
    };
  }
}

/// ---------------- DailyActivity ----------------
class DailyActivity {
  final String id;
  final String userId;
  final int stepCount;
  final DateTime timestamp;
  final double amountRewarded;
  final double conversionRate;
  final int auraGained;
  final String source;

  DailyActivity({
    required this.id,
    required this.userId,
    required this.stepCount,
    required this.timestamp,
    required this.amountRewarded,
    required this.conversionRate,
    required this.auraGained,
    required this.source,
  });

  factory DailyActivity.fromJson(Map<String, dynamic> json) {
    return DailyActivity(
      id: json['id'],
      userId: json['user'],
      stepCount: json['step_count'] ?? 0,
      timestamp: DateTime.parse(json['timestamp']),
      amountRewarded: (json['amount_rewarded'] ?? 0).toDouble(),
      conversionRate: (json['conversion_rate'] ?? 0).toDouble(),
      auraGained: json['aura_gained'] ?? 0,
      source: json['source'] ?? "steps",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": userId,
      "step_count": stepCount,
      "timestamp": timestamp.toIso8601String(),
      "amount_rewarded": amountRewarded,
      "conversion_rate": conversionRate,
      "aura_gained": auraGained,
      "source": source,
    };
  }
}

/// ---------------- Mission ----------------
class Mission {
  final String id;
  final String? asset; // image URL from API
  final String name;
  final String description;
  final int requirementSteps;
  final int auraReward;

  Mission({
    required this.id,
    this.asset,
    required this.name,
    required this.description,
    this.requirementSteps = 0,
    this.auraReward = 0,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'],
      asset: json['asset'],
      name: json['name'],
      description: json['description'],
      requirementSteps: json['requirement_steps'] ?? 0,
      auraReward: json['aura_reward'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "asset": asset,
      "name": name,
      "description": description,
      "requirement_steps": requirementSteps,
      "aura_reward": auraReward,
    };
  }
}

/// ---------------- UserMission ----------------
class UserMission {
  final String id;
  final String userId;
  final Mission mission;
  final DateTime? achieved;
  final bool isCompleted;

  UserMission({
    required this.id,
    required this.userId,
    required this.mission,
    this.achieved,
    this.isCompleted = false,
  });

  factory UserMission.fromJson(Map<String, dynamic> json) {
    return UserMission(
      id: json['id'],
      userId: json['user'],
      mission: Mission.fromJson(json['mission']),
      achieved:
          json['achieved'] != null ? DateTime.parse(json['achieved']) : null,
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": userId,
      "mission": mission.toJson(),
      "achieved": achieved?.toIso8601String(),
      "is_completed": isCompleted,
    };
  }
}

/// ---------------- UserEventLog ----------------
class UserEventLog {
  String? id;
  String? userId;
  String? eventType;
  String? description;
  DateTime? timestamp;
  Map<String, dynamic>? metadata;

  UserEventLog({
    this.id,
    this.userId,
    this.eventType,
    this.description,
    this.timestamp,
    this.metadata,
  });

  factory UserEventLog.fromJson(Map<String, dynamic> json) {
    return UserEventLog(
      id: json['id'],
      userId: json['user'],
      eventType: json['event_type'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": userId,
      "event_type": eventType,
      "description": description,
      "timestamp": timestamp?.toIso8601String(),
      "metadata": metadata,
    };
  }
}

class LeaderboardEntry {
  String? displayname;
  String? username;
  int? totalSteps;

  LeaderboardEntry({
    this.displayname,
    this.username,
    this.totalSteps,
  });

  /// A factory constructor for creating a new `LeaderboardEntry` instance
  /// from a map. This is used for decoding JSON.
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      displayname: json['displayname'],
      username: json['username'],
      totalSteps: json['total_steps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "displayname": displayname,
      "username": username,
      "total_steps": totalSteps
    };
  }

  // Optional: Override toString for easy printing and debugging.
  @override
  String toString() {
    return 'LeaderboardEntry(displayname: $displayname, username: $username, totalSteps: $totalSteps)';
  }
}
