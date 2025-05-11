import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_series/Screens/Profile/postscreen.dart';
import 'package:instagram_series/Widgets/uihelper.dart';
import 'package:instagram_series/Screens/Login/loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePicUrl = 'https://media.istockphoto.com/id/846730696/photo/portrait-teenager.jpg?s=1024x1024&w=is&k=20&c=lpu_mbymDu-ihFay4xJ8uCQSvk_Q0oNoNW_DGuWzOWk=';
  String username = 'Samar_hadia';
  int postCount = 11;
  int followersCount = 834;
  int followingCount = 162;
  String name = 'Samar Hadia 🌸💫';
  String bio1 = 'Spreading smiles & good vibes ✨';
  String bio2 = 'Dancing through life one day at a time 💃';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          setState(() {
            profilePicUrl = userData['profilePic'] ?? profilePicUrl;
            username = userData['username'] ?? username;
            postCount = userData['postCount'] ?? postCount;
            followersCount = userData['followersCount'] ?? followersCount;
            followingCount = userData['followingCount'] ?? followingCount;
            name = userData['name'] ?? name;
            bio1 = userData['bio1'] ?? bio1;
            bio2 = userData['bio2'] ?? bio2;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelper.CustomImage(imgurl: "lock.png"),
              const SizedBox(width: 5),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: UiHelper.CustomImage(imgurl: "Shape.png"),
              onSelected: (value) {
                if (value == 'logout') {
                  _logout(context);
                }
                // Handle other menu items here
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'archive',
                    child: Text('Archive'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'qr',
                    child: Text('QR Code'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'saved',
                    child: Text('Saved'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Log Out'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC0CB),
                Color(0xFFF72585),
                Color(0xFF7209B7),
              ],
            ),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profilePicUrl),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(width: 50),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                postCount.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Posts",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                followersCount.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              Text(
                                followingCount.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        bio1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        bio2,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 360,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: Colors.pink[200],
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "New 🌟",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: UiHelper.CustomImage(imgurl: "Oval (1).png"),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Besties 👯♀️",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: UiHelper.CustomImage(imgurl: "Oval (2).png"),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Sports🏸",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            child: UiHelper.CustomImage(imgurl: "Oval (3).png"),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Food Tales 🍽️",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      indicatorColor: Colors.pink,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.grid_on),
                          text: "My Magic Moments ✨",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: PostScreenProfile(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}