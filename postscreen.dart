import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostScreenProfile extends StatefulWidget {
  const PostScreenProfile({Key? key}) : super(key: key);

  @override
  State<PostScreenProfile> createState() => _PostScreenProfileState();
}

class _PostScreenProfileState extends State<PostScreenProfile> {
  List<String> imageUrls = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .get();

      final urls = querySnapshot.docs
          .map((doc) => doc['imgUrl'] as String)
          .toList();

      setState(() {
        imageUrls = urls;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading images: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : GridView.builder(
                  itemCount: imageUrls.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}