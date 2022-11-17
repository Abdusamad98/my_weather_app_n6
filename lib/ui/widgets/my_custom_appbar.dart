import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSize {
  const MyCustomAppBar(
      {Key? key, required this.onSearchTap, required this.title})
      : super(key: key);

  final VoidCallback onSearchTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      title: Text(title,style: TextStyle(color: Colors.black),),
      actions: [
        IconButton(
            onPressed: onSearchTap,
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ))
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.yellow,

      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
