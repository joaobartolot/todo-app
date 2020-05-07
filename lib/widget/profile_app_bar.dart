import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/provider/profile_provider.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Consumer<ProfileProvider>(
                builder: (context, provider, _) => !provider.isEditing
                    ? IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).accentColor,
                          size: 35,
                        ),
                      )
                    : IconButton(
                        onPressed: () => provider.isEditing = false,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).accentColor,
                          size: 35,
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your profile',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, provider, _) => Align(
                alignment: Alignment.centerRight,
                child: provider.isEditing
                    ? IconButton(
                        onPressed: () => provider.saveChanges(),
                        icon: Icon(
                          Icons.check,
                          color: Theme.of(context).accentColor,
                          size: 25,
                        ),
                      )
                    : IconButton(
                        onPressed: () => provider.isEditing = true,
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).accentColor,
                          size: 25,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
