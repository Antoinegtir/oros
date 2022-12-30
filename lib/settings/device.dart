import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InformationsPage extends StatefulWidget {
  const InformationsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InformationsPageState createState() => _InformationsPageState();
}

class _InformationsPageState extends State<InformationsPage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'Name': data.name,
      'System Name': data.systemName,
      'System Version': data.systemVersion,
      'Model': data.model,
      'LocalizedModel': data.localizedModel,
      'Identifier For Vendor': data.identifierForVendor,
      'Username System': data.utsname.sysname,
      'Username': data.utsname.nodename,
      'Username Release': data.utsname.release,
      'Username Version': data.utsname.version,
      'Username Machine': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
    };
  }

  @override
  Widget build(BuildContext context) {
    final darkmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? const Color(0xfff2f2f6)
            : Colors.black;
    final lightmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white
            : Colors.black;
    final lightmodes =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? const Color.fromARGB(255, 155, 155, 155)
            : Colors.black;
    final darkmodes =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : const Color(0xff1c1c1e);
    return Scaffold(
        backgroundColor: darkmode,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            flexibleSpace: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                      width: MediaQuery.of(context).size.width / 1,
                      height: 200,
                    ))),
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leading: const BackButton(color: Colors.blue),
            title: Hero(
              tag: 'device',
              child: Text(
                kIsWeb
                    ? 'Web Browser info'
                    : Platform.isAndroid
                        ? 'Android Device Info'
                        : Platform.isIOS
                            ? 'iOS Device Info'
                            : Platform.isLinux
                                ? 'Linux Device Info'
                                : Platform.isMacOS
                                    ? 'MacOS Device Info'
                                    : Platform.isWindows
                                        ? 'Windows Device Info'
                                        : '',
                style: const TextStyle(color: Colors.blue),
              ),
            )),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              setState(() {
                Navigator.pop(context);
              });
            }
          },
          child: !Platform.isIOS
              ? ListView(
                  children: _deviceData.keys.map(
                    (String property) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 0, top: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                  color: darkmodes,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 13,
                                            bottom: 13,
                                            right: 30),
                                        child: Text(
                                          property,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: lightmode,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Text(
                                          '${_deviceData[property]}',
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: lightmodes),
                                        ),
                                      )),
                                    ],
                                  ))));
                    },
                  ).toList(),
                )
              : ListView(
                  children: _deviceData.keys.map(
                    (String property) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 0, top: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  color: darkmodes,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 13,
                                            bottom: 13,
                                            right: 20),
                                        child: Text(
                                          property,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: lightmode,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Text(
                                          '${_deviceData[property]}',
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: lightmodes),
                                        ),
                                      )),
                                    ],
                                  ))));
                    },
                  ).toList(),
                ),
        ));
  }
}
