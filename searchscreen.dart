import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SearchScreen({super.key});

  // Function to fetch image URLs
  Future<List<String>> fetchImages() async {
    final Map<String, String> imageMap = {
      'id1': 'https://images.unsplash.com/photo-1746263665199-24fff5aff18e?w=500&auto=format&fit=crop&q=60',
      'id2': 'https://images.unsplash.com/photo-1583130879758-db8ac95a9b68?w=500&auto=format&fit=crop&q=60',
      'id3': 'https://images.unsplash.com/photo-1560008581-09826d1de69e?w=500&auto=format&fit=crop&q=60',
      'id4': 'https://images.unsplash.com/photo-1681937430218-b5d637a49c20?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDUyfHx8ZW58MHx8fHx8',
      'id5': 'https://images.unsplash.com/photo-1634635561487-bc52e62f1fa6?w=500&auto=format&fit=crop&q=60',
      'id6': 'https://images.unsplash.com/photo-1695234502713-9084080ea54f?w=500&auto=format&fit=crop&q=60',
      'id7': 'https://images.unsplash.com/photo-1725429976958-4108bffbd131?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIyfHx8ZW58MHx8fHx8',
      'id8': 'https://images.unsplash.com/photo-1580233929334-aad6ec0e899f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDI0fHx8ZW58MHx8fHx8',
      'id9': 'https://plus.unsplash.com/premium_photo-1671974489983-083171c0215e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIwfHx8ZW58MHx8fHx8',
      'id10': 'https://images.unsplash.com/photo-1733748914677-c7ffc261f566?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDM3fHx8ZW58MHx8fHx8',
      'id11': 'https://plus.unsplash.com/premium_photo-1663945779273-ebc45569fb9f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHx8',
      'id12': 'https://plus.unsplash.com/premium_photo-1671974489965-b9366888cef7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1pbi1zYW1lLXNlcmllc3wxfHx8ZW58MHx8fHx8',
      'id13': 'https://images.unsplash.com/photo-1730708526003-e5f4f2dfc191?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHx8',
      'id14': 'https://images.unsplash.com/photo-1719826025831-a143651dba09?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDIxfHx8ZW58MHx8fHx8',
      'id15': 'https://images.unsplash.com/photo-1679004592552-66ce42c85ca8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDM0fHx8ZW58MHx8fHx8',
    };

    return imageMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFF262626),
                      ),
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintStyle: TextStyle(fontSize: 16, color: Color(0XFF8E8E93)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.live_tv, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Image Grid
            Expanded(
              child: FutureBuilder<List<String>>(
                future: fetchImages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading images", style: TextStyle(color: Colors.white)),
                    );
                  } else {
                    final imageUrls = snapshot.data ?? [];

                    if (imageUrls.isEmpty) {
                      return const Center(
                        child: Text("No images found", style: TextStyle(color: Colors.white)),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}