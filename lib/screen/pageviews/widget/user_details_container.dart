import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/auth_methods.dart';
import 'package:skype_clone/screen/chatscreens/widgets/cached_image.dart';
import 'package:skype_clone/screen/login_screen.dart';
import 'package:skype_clone/screen/pageviews/widget/shimmering_lodo.dart';
import 'package:skype_clone/widgets/appbar.dart';

class UserDetailsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggeOut = await AuthMethods().signOut();

      if (isLoggeOut) {
        //navigate to loginpage and remove all remaining pages in bg, cant go back!
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.maybePop(
                context,
              ),
            ),
            centerTitle: true,
            title: ShimmeringLogo(),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                onPressed: () => signOut(),
              ),
            ],
          ),
          UserDetailsBody(),
        ],
      ),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          CachedImage(
            user.profilePhoto,
            isRound: true,
            radius: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
