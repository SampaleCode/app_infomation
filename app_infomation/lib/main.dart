import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App Information',
      home: AppInfoPage(),
    );
  }
}

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

Widget _infoListTile(String title, String subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle.isEmpty ? 'Not Set' : subtitle),
  );
}

class _AppInfoPageState extends State<AppInfoPage> {
  PackageInfo _packageInfo =
      PackageInfo(appName: "", packageName: "", version: "", buildNumber: "");

  @override
  void initState() {
    super.initState();
    _initInfo();
  }

  Future<void> _initInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
        elevation: 4,
      ),
      body: ListView(
        children: [
          _infoListTile("App Name", _packageInfo.appName),
          _infoListTile("Package Name", _packageInfo.packageName),
          _infoListTile("App Version", _packageInfo.version),
          _infoListTile("Build Number", _packageInfo.buildNumber),
          _infoListTile("Build Signature", _packageInfo.buildSignature),
          _infoListTile("Installer Store",
              _packageInfo.installerStore ?? 'not available'),
        ],
      ),
    );
  }
}
