import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key key,
    @required this.photoUrl,
    @required this.name,
    this.radio,
  }) : super(key: key);

  final double radio;
  final String photoUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radio ?? 50.0,
      width: radio ?? 50.0,
      child: photoUrl != null
          ? ClipRRect(
              borderRadius:
                  BorderRadius.circular(radio != null ? radio / 2 : 25.0),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                  photoUrl,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Center(
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: radio != null ? (2 * radio) / 5 : 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
    );
  }
}
