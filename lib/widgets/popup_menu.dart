import 'package:flutter/material.dart';
import 'package:map/providers/theme_changer.dart';
import 'package:provider/provider.dart';

class PopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeChanger>(context);
    return PopupMenuButton<int>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: const Text('dark'),
          onTap: () {
            provider.setDark();
          },
        ),
        PopupMenuItem(
          value: 2,
          child: const Text('light'),
          onTap: () {
            provider.setLight();
          },
        ),
        PopupMenuItem(
          value: 3,
          child: const Text('satellite'),
          onTap: () {
            provider.setSatellite();
          },
        ),
        PopupMenuItem(
          value: 4,
          child: const Text('navigation'),
          onTap: () {
            provider.setNavigation();
          },
        ),
      ],
      icon: const Icon(
        Icons.layers,
        color: Colors.black,
      ),
    );
  }
}
