import 'package:flutter/material.dart';
import 'package:instagram_series/Screens/Messages/messagescreen.dart';
import 'package:instagram_series/Widgets/uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [
    Post(
      userName: "Jenny",
      userLocation: "London, England",
      imageUrl: "https://images.unsplash.com/photo-1542228935-eb10cfc468a3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMzfHx8ZW58MHx8fHx8",
      caption: "Living my best life ✨💃",
      likeCount: 44686,
      isLiked: false,
      isSaved: false,
      profileImage: "girl.png", // Jenny's profile image
    ),
    Post(
      userName: "Sarah",
      userLocation: "New York, USA",
      imageUrl: "https://media.istockphoto.com/id/1131147190/photo/close-up-of-young-beautiful-lady-in-sunglasses.webp?a=1&s=612x612&w=0&k=20&c=e9t0954K1GElDtCDOCevtQerthyNuH4Fv3T8N9lGGS8=",
      caption: "Enjoying a beautiful day 🌞",
      likeCount: 2345,
      isLiked: false,
      isSaved: false,
      profileImage: "girl2.png", // Sarah's profile image
    ),
    Post(
      userName: "Sophia",
      userLocation: "Paris, France",
      imageUrl: "https://plus.unsplash.com/premium_photo-1706563799492-a1e17d9b92cf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE2fHx8ZW58MHx8fHx8",
      caption: "Wanderlust and Paris dust 🗼💕",
      likeCount: 18923,
      isLiked: false,
      isSaved: false,
      profileImage: "girl3.png", // Sophia's profile image
    ),
    Post(
      userName: "Michael",
      userLocation: "Pittsburgh, PA, USA",
      imageUrl: "https://images.unsplash.com/photo-1729280747162-6c31c4a6abaf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHx8",
      caption: "Streets whisper stories—I'm here to listen 🚶‍♂️🌆",
      likeCount: 32567,
      isLiked: false,
      isSaved: false,
      profileImage: "boy.png", // Michael's profile image
    ),
  ];

  final List<StoryContent> arrContent = [
    StoryContent(img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s", name: "Your Story"),
    StoryContent(img: "https://images.pexels.com/photos/1090393/pexels-photo-1090393.jpeg?auto=compress&cs=tinysrgb&w=600", name: "karennne"),
    StoryContent(img: "https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&w=600", name: "Alice"),
    StoryContent(img: "https://images.pexels.com/photos/1524105/pexels-photo-1524105.jpeg?auto=compress&cs=tinysrgb&w=600", name: "kieron_d"),
    StoryContent(img: "https://images.unsplash.com/photo-1542228935-eb10cfc468a3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMzfHx8ZW58MHx8fHx8", 
     name: "Jenny"),
    StoryContent(img: "https://media.istockphoto.com/id/1131147190/photo/close-up-of-young-beautiful-lady-in-sunglasses.webp?a=1&s=612x612&w=0&k=20&c=e9t0954K1GElDtCDOCevtQerthyNuH4Fv3T8N9lGGS8=", 
     name: "Sarah"),
    StoryContent(img: "https://plus.unsplash.com/premium_photo-1706563799492-a1e17d9b92cf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE2fHx8ZW58MHx8fHx8",name: "Sophia"),
    StoryContent(img: "https://images.unsplash.com/photo-1729280747162-6c31c4a6abaf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHx8",name: "Michael"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF72585), // Vibrant pink
                Color(0xFF7209B7), // Purple
                Color(0xFF3A0CA3), // Deep purple-blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: UiHelper.CustomImage(imgurl: "Camera Icon.png"),
        title: UiHelper.CustomImage(imgurl: "Instagram Logo (1).png"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: UiHelper.CustomImage(imgurl: "IGTV.png"),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageScreen()));
            },
            icon: UiHelper.CustomImage(imgurl: "Messanger.png"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemCount: arrContent.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isYourStory = index == 0;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isYourStory ? Colors.white : Colors.pink,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 24, // Reduced size
                              backgroundColor: Colors.black,
                              backgroundImage: isYourStory
                                  ? null
                                  : NetworkImage(arrContent[index].img),
                              child: isYourStory
                                  ? Icon(Icons.person, size: 25, color: Colors.white)
                                  : null,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            arrContent[index].name,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // Posts
            for (int i = 0; i < posts.length; i++) buildPost(i),
          ],
        ),
      ),
    );
  }

  Widget buildPost(int index) {
    return Column(
      children: [
        // Post Header
        Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF72585),
                Color(0xFF7209B7),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5,
                ),
              ),
              child: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: UiHelper.CustomImage(imgurl: posts[index].profileImage),
                  ),
                ),
              ),
            ),
            title: Text(
              posts[index].userName,
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
            subtitle: Text(
              posts[index].userLocation,
              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8)),
            ),
            trailing: PopupMenuButton<String>(
              icon: UiHelper.CustomImage(imgurl: "More Icon.png"),
              color: Colors.grey[900],
              onSelected: (value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.black87,
                      title: Text(
                        'OK! done',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'Unfollow',
                  child: Row(
                    children: [
                      Icon(Icons.person_remove, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text('Unfollow', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'About this account',
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text('About this account', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Report',
                  child: Row(
                    children: [
                      Icon(Icons.report_problem, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text('Report', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Share',
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text('Share', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        // Post Image
        Container(
          clipBehavior: Clip.antiAlias,
          height: 375,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Image.network(
            posts[index].imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        // Post Actions
        Row(
          children: [
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  posts[index].isLiked = !posts[index].isLiked;
                  posts[index].isLiked
                      ? posts[index].likeCount++
                      : posts[index].likeCount--;
                });
              },
              child: Icon(
                posts[index].isLiked ? Icons.favorite : Icons.favorite_border,
                color: posts[index].isLiked ? Colors.red : Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: 20),
            Icon(Icons.comment, color: Colors.white, size: 26),
            SizedBox(width: 20),
            Icon(Icons.send, color: Colors.white, size: 26),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  posts[index].isSaved = !posts[index].isSaved;
                });
                if (posts[index].isSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade300,
                              Colors.green.shade400,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Post Saved',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                  );
                }
              },
              child: Icon(
                posts[index].isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: posts[index].isSaved ? Colors.green : Colors.white,
                size: 26,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 10),
        // Likes Row
        Row(
          children: [
            SizedBox(width: 20),
            UiHelper.CustomImage(imgurl: "Ovalone.png"),
            SizedBox(width: 5),
            Text(
              "Liked by Sarah and ${posts[index].likeCount} others",
              style: TextStyle(fontSize: 13, color: Color(0XFFF9F9F9)),
            ),
          ],
        ),
        // Caption Row
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              "${posts[index].userName} ",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0XFFF9F9F9)),
            ),
            Text(
              posts[index].caption,
              style: TextStyle(fontSize: 13, color: Color(0XFFF9F9F9)),
            ),
          ],
        ),
      ],
    );
  }
}

class Post {
  String userName;
  String userLocation;
  String imageUrl;
  String caption;
  int likeCount;
  bool isLiked;
  bool isSaved;
  String profileImage; // New field for profile image

  Post({
    required this.userName,
    required this.userLocation,
    required this.imageUrl,
    required this.caption,
    required this.likeCount,
    required this.isLiked,
    required this.isSaved,
    required this.profileImage, // Added to constructor
  });
}

class StoryContent {
  String img;
  String name;

  StoryContent({required this.img, required this.name});
}