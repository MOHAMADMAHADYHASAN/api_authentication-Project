import 'package:authenticationfire/utils/utils.dart';
import 'package:authenticationfire/view_models/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:authenticationfire/widgets/round_button.dart'; // আপনার কাস্টম বাটন
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _postEditingController = TextEditingController();

  @override
  void dispose() {
    _postEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);

    const primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Create New Post",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's on your mind?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _postEditingController,
                  maxLines: 8,
                  maxLength: 300,
                  style: const TextStyle(fontSize: 16, height: 1.3),
                  decoration: InputDecoration(
                    hintText: "Type your thoughts here...",
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 140, right: 10),
                      child: Icon(
                        Icons.edit_note,
                        color: primaryColor.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              Consumer<PostViewModel>(
                builder: (context, value, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: RoundButton(
                      title: "Publish Post",
                      loading: value.loading,

                      onPress: () {
                        final postText = _postEditingController.text.trim();

                        if (postText.isEmpty) {
                          utils.snakBar(
                            "Please write something first!",
                            context,
                          );
                          return;
                        }

                        postViewModel.addPost(postText, context);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  "Your post will be visible to everyone.",
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
