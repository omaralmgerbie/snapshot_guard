import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:snapshot_guard/snapshot_guard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hide =false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    late bool hide;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      hide =
          await SnapshotGuard.toggleGuard() ??false;
    } on PlatformException {
      hide = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hide = hide;
    });
  }

  bool _isSnapshotHidden = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('ui is "${_hide ? 'hidden' : 'visible'}"'),
              ElevatedButton(
                onPressed: () async {
                  final result = await SnapshotGuard.toggleGuard();
                  if(result!= null) {
                    setState(() {
                    _isSnapshotHidden = result ;
                  });
                  }
                  log('hideSnapshot: $result');
                },
                child:  Text('Hide snapshot $_isSnapshotHidden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
