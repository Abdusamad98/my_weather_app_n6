import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather_app/ui/widgets/search_delegate_view.dart';
import 'package:my_weather_app/utils/my_utils.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSize {
  const MyCustomAppBar({
    Key? key,
    required this.onSearchTap,
    required this.title,
  }) : super(key: key);

  final ValueChanged<String> onSearchTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      title: Text(
        title,
        style:const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              var searchText = await showSearch(
                context: context,
                delegate:
                    SearchDelegateView(suggestionList: MyUtils.getPlaceNames()),
              );
              onSearchTap.call(searchText);
            },
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
