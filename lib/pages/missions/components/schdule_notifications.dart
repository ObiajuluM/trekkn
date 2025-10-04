import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduledNotificationsPage extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const ScheduledNotificationsPage({
    super.key,
    required this.flutterLocalNotificationsPlugin,
  });

  @override
  State<ScheduledNotificationsPage> createState() =>
      _ScheduledNotificationsPageState();
}

class _ScheduledNotificationsPageState
    extends State<ScheduledNotificationsPage> {
  List<PendingNotificationRequest> _pendingNotifications = [];

  @override
  void initState() {
    super.initState();
    _loadPendingNotifications();
  }

  Future<void> _loadPendingNotifications() async {
    final pending = await widget.flutterLocalNotificationsPlugin
        .pendingNotificationRequests();
    setState(() {
      _pendingNotifications = pending;
    });
  }

  Future<void> _cancelAllNotifications() async {
    ///
    final prefs = await SharedPreferences.getInstance();

    ///
    await widget.flutterLocalNotificationsPlugin.cancelAll();

    ///
    await prefs.setBool('walk_reminder_scheduled', false);

    _loadPendingNotifications();
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return "Unknown time";
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('EEEE, MMM d, yyyy – h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheduled Notifications"),
        actions: [
          if (_pendingNotifications.isNotEmpty)
            Visibility(
              maintainInteractivity: true,
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: false,
              child: IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: _cancelAllNotifications,
                tooltip: "Cancel All",
              ),
            ),
        ],
      ),
      body: _pendingNotifications.isEmpty
          ? const Center(
              child: Text(
                "No scheduled notifications found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              itemCount: _pendingNotifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = _pendingNotifications[index];
                return ListTile(
                  leading: const Icon(Icons.notifications_active_rounded,
                      color: Colors.blue),
                  title: Text(notification.title ?? "No Title",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text(notification.body ?? "No message"),
                  trailing: Text("#${notification.id}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadPendingNotifications,
        label: const Text("Refresh"),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
