import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';

class HelpSupportView extends StatelessWidget {
  HelpSupportView({super.key});

  final TextEditingController _problemController = TextEditingController();

  Future<void> _sendProblem() async {
    if (_problemController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('supportMessages').add({
      'message': _problemController.text,
      'timestamp': DateTime.now(),
      'user_name': FirebaseServices.getCurrentUser()?.displayName,
      'user_email': FirebaseServices.getCurrentUser()?.email,
    });

    _problemController.clear();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await url_launcher.launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Helps & Supports", actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "video guide لسه مش صورت لما اصور هحدث الرابط",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => _launchUrl(
                  "https://www.linkedin.com/in/abdullah-samir-07635b333",
                ),
                child: Text("watch the video"),
              ),
              SizedBox(height: 20),

              Text(
                "contact us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.phone, color: Colors.green),
                    onPressed: () => _launchUrl("https://wa.me/201000550411"),
                  ),
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.blue),
                    onPressed: () =>
                        _launchUrl("https://www.facebook.com/abdullah.dooda"),
                  ),
                  IconButton(
                    icon: Icon(Icons.email, color: Colors.red),
                    onPressed: () => _launchUrl("abdullhsamir2@gmail.com"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Text(
                "send your problem",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _problemController,
                decoration: InputDecoration(
                  hintText: "write your problem here...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _sendProblem();
                  showSnackbar(
                    context: context,
                    message: "the problem has been sent successfully",
                  );
                },
                child: Text("send"),
              ),
              SizedBox(height: 20),

              Text(
                "admin password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(
                "Admin123",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
