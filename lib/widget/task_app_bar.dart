import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/provider/home_provider.dart';
import 'package:todo_firebase/widget/profile_photo.dart';

class TaskAppBar extends StatelessWidget {
  final AnimationController controller;
  final String photoUrl;
  final String name;

  const TaskAppBar({
    Key key,
    this.controller,
    this.photoUrl,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return Container(
      height: 75.0,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => provider.animateProfileMenu(controller),
            child: ProfilePhoto(photoUrl: photoUrl, name: name),
          ),
          Text(
            'Your tasks',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: 35.0,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => provider.isAdding = !provider.isAdding,
          ),
        ],
      ),
    );
  }
}
