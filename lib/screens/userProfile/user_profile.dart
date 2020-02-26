import 'package:flutter/material.dart';
import 'package:flutter_food_donation/providers/user_profile.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  Widget _buildCoverImage(BuildContext context, Size screenSize) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height / 4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cover_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          width: 50,
          right: 5,
          bottom: 0,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Icon(
              Icons.photo_camera,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/user1.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
          ),
          Positioned(
            width: 50,
            right: 0,
            bottom: 0,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.photo_camera),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserName(String username) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      username,
      style: _nameTextStyle,
    );
  }

  Widget _buildBio(BuildContext context, String bio) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).primaryColor,
      fontSize: 16.0,
    );

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8.0),
      child: Text(
        bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildDetailsItem(
      BuildContext context, IconData icon, String label, String info) {
    TextStyle _labelStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20.0,
    );
    TextStyle _infoStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
    );
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
        ),
        Text(
          label,
          style: _labelStyle,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
        ),
        Text(
          info,
          style: _infoStyle,
        )
      ],
    );
  }

  Widget _buildPersonalDetails(BuildContext context, String name,
      String emailAddress, String phoneNumber) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildDetailsItem(context, Icons.person, 'Name: ', name),
          _buildDetailsItem(
              context, Icons.email, 'EmailAddress: ', emailAddress),
          _buildDetailsItem(
              context, Icons.phone, 'Contact Number: ', phoneNumber),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? screenSize.height / 3
                      : screenSize.height / 2,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                children: <Widget>[
                  _buildCoverImage(context, screenSize),
                  Column(
                    children: <Widget>[
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? SizedBox(height: 150)
                          : SizedBox(height: 50),
                      _buildProfileImage(context),
                    ],
                  )
                ],
              )),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Consumer<UserProfileProvider>(
                      builder: (context, userProfileProvider, child) {
                    return Column(
                      children: <Widget>[
                        _buildUserName(
                            userProfileProvider.userProfileModel.userName),
                        _buildBio(
                            context, userProfileProvider.userProfileModel.bio),
                        Card(
                            margin: EdgeInsets.all(20),
                            child: _buildPersonalDetails(
                                context,
                                userProfileProvider.userProfileModel.userName,
                                userProfileProvider
                                    .userProfileModel.emailAddress,
                                userProfileProvider
                                    .userProfileModel.phoneNumber)),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/user1.jpg')),
                                ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: new TextField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a Post...",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                )
              ]),
            ),
            Consumer<UserProfileProvider>(
                builder: (context, userProfileProvider, child) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image(
                                height: 50,
                                width: 50,
                                image:
                                    AssetImage('assets/images/cover_image.png'),
                              ),
                              Text(
                                  userProfileProvider.userProfileModel.userName)
                            ],
                          ),
                          Container(
                            child: Text(userProfileProvider
                                .userProfileModel.posts[index]),
                          )
                        ],
                      ),
                    );
                  },
                  childCount: userProfileProvider.userProfileModel.posts.length,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
