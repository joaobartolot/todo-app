import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/provider/home_provider.dart';

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
            child: Container(
              height: 50.0,
              width: 50.0,
              child: photoUrl != null
                  ? photoUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80',
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).accentColor),
                          ),
                          child: Center(
                            child: Text(
                              name[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Theme.of(context).accentColor),
                      ),
                    ),
            ),
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
