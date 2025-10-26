import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walkit/modules/api/backend.dart';
import 'package:walkit/modules/auth/google_auth.dart';
import 'package:walkit/modules/formatter.dart';
import 'package:walkit/modules/model/providers.dart';
import 'package:walkit/pages/landing/landing.dart';
import 'package:walkit/themes/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  static const platform = MethodChannel("com.walkitapp.walkit/navigation");
  // late final StreamSubscription<bool> _signOutListener;

  var notify = false;
  var step = false;
  var back = false;
  // tracks the current visible wallet
  var walletState = true;

  @override
  void initState() {
    setPermissions();
    // Example: listen to a signOut stream
    ApiClient().accessTokenStream.listen((signedOut) {
      if (signedOut == null) {
        // Clear the stack and push LandingPage
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => LandingPage(
                    inviteCode: null,
                  )),
          (route) => false, // removes ALL previous pages
        );
      }
    });

    ///
    super.initState();
  }

  @override
  void dispose() {
    // _signOutListener.cancel();
    super.dispose();
  }

  Future<void> openPrivacyPolicy() async {
    try {
      await platform.invokeMethod("openPrivacyPolicy");
    } on PlatformException catch (e) {
      print("Failed to open Privacy Policy: ${e.message}");
    }
  }

  setPermissions() async {
    // Global Health instance
    final health = Health();
    // configure the health plugin before use.
    await health.configure();

    const List<HealthDataType> kdataTypes = [HealthDataType.STEPS];

    notify = await Permission.notification.isGranted;
    step = await health.hasPermissions(kdataTypes) ?? false;
    back = await Permission.ignoreBatteryOptimizations.isGranted;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(trekknUserProvider);

    ///
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),

      ///
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ///
          Text(
            "Personal",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {},
                    title: Text("Name"),
                    trailing: Text("${user.username}")),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {},
                  title: Text("Email"),
                  trailing: Text("${user.email}"),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {
                    setState(() {
                      walletState = !walletState;
                    });
                  },
                  title: Text("Wallets"),
                  //   slicing to display the first 4 and last 5 characters of the wallet address.
                  trailing: Text(
                    walletState
                        ? (user.evmAddr != null && user.evmAddr!.length >= 9
                            ? "${user.evmAddr!.substring(0, 6)}...${user.evmAddr!.substring(user.evmAddr!.length - 5)}"
                            : user.evmAddr ?? "")
                        : (user.solAddr != null && user.solAddr!.length >= 9
                            ? "${user.solAddr!.substring(0, 6)}...${user.solAddr!.substring(user.solAddr!.length - 5)}"
                            : user.solAddr ?? ""),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {},
                  title: Text("User Since"),
                  trailing: Text(
                    formatDate(
                      DateTime.parse(
                          user.dateJoined ?? DateTime.now().toString()),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          ///
          Text(
            "General",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              // borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {
                    ref.read(themeModeProvider.notifier).changeTheme();
                  },
                  title: Text("App Theme"),
                  trailing: ref.watch(themeModeProvider) == ThemeMode.light
                      ? Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.amber,
                        )
                      : Icon(
                          Icons.mode_night_outlined,
                          color: Colors.blue[900],
                        ),
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.all(0),
                //   onTap: () {},
                //   title: Text("Terms & Conditions"),
                // ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () {
                    // push to license page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LicensePage(),
                      ),
                    );
                  },
                  title: Text("Licenses"),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: openPrivacyPolicy,
                  title: Text("Privacy Policy"),
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.all(0),
                //   onTap: () {
                //     // opens google page
                //   },
                //   title: Text("Issue Report"),
                // ),

                ///
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // can't dismiss by tapping outside
                      builder: (BuildContext context) {
                        return PopScope(
                          canPop: false, // ❌ block back button / swipe

                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                    await signOutFromGoogle();
                    await signOutFromServer();
                    // if (!context.mounted) return;
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  title: Text("Sign Out"),
                  trailing: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          ///
          Text(
            "Permissions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SwitchListTile(
                  value: notify,
                  onChanged: (value) {},
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Notifications"),
                ),
                SwitchListTile(
                  value: step,
                  onChanged: (value) {},
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Read Step Data"),
                ),
                SwitchListTile(
                  value: back,
                  onChanged: (value) {},
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Background Access"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
