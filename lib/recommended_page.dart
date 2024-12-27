import 'package:flutter/material.dart';

class RecommendedPage extends StatelessWidget {
  const RecommendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Recommended for your devices',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to "See All" page or perform some action
            },
            child: const Text(
              'See All',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      // Show image from assets
                      Image.asset(
                        'assets/test_image.png', // Replace with your asset path
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Handle bookmark action
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'AirPods Max — Silver',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Free Engraving',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A\$899.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorOption(Colors.grey),
                      const SizedBox(width: 4),
                      _buildColorOption(Colors.blue),
                      const SizedBox(width: 4),
                      _buildColorOption(Colors.green),
                      const SizedBox(width: 4),
                      _buildColorOption(Colors.pink),
                      const SizedBox(width: 4),
                      const Text(
                        '+1 more',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return CircleAvatar(
      radius: 8,
      backgroundColor: color,
    );
  }
}
