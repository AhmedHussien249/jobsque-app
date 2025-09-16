import 'package:flutter/material.dart';

class LoginAndSecurityView extends StatelessWidget {
  const LoginAndSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Login and security"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Account access",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          _buildItem(
            title: "Email address",
            subtitle: "rafifdian12@gmail.com",
            onTap: () {},
          ),
          _buildItem(
            title: "Phone number",
            onTap: () {},
          ),
          _buildItem(
            title: "Change password",
            onTap: () {},
          ),
          _buildItem(
            title: "Two-step verification",
            subtitle: "Non active",
            subtitleColor: Colors.grey,
            onTap: () {},
          ),
          _buildItem(
            title: "Face ID",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    String? subtitle,
    Color? subtitleColor,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor ?? Colors.black,
                    fontSize: 14,
                  ),
                )
              : null,
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
