import 'package:flutter/material.dart';
import 'package:settingsbundlewithflutter/base_service_point.dart';
import 'package:settingsbundlewithflutter/home_service.dart';
import 'package:settingsbundlewithflutter/native_config_bridge.dart';

import 'model/user.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final appEnvironment = await ConfigHostApi().appEnvironment();
    final appType = appEnvironment?.type;
    if (appType == null) {
      return;
    }

    _user = await HomeService(BaseServicePoint.baseUrl(appType)).getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _UserTitle(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user?.image != null) _UserAvatar(photoUrl: _user!.image!),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await ConfigHostApi().userToken();
          print(data);
        },
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.photoUrl,
  });

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(photoUrl),
    );
  }
}

class _UserTitle extends StatelessWidget {
  const _UserTitle();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ConfigHostApi().userToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data ?? '');
        }
        return const Text('Loading...');
      },
    );
  }
}
