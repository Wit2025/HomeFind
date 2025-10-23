import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/my_account/widget/edit_profile_form_widget.dart';
import 'package:homefind/screens/profile/pages/my_account/widget/gradient_button_widget.dart';
import 'package:homefind/screens/profile/pages/my_account/widget/info_tile_widget.dart';
import 'package:homefind/screens/profile/pages/my_account/widget/profile_picture_widget.dart';
import 'package:homefind/widgets/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  File? _profileImage;
  String _name = 'ສາຍສະຫັວນ ແກ້ວມະນີ';
  String _phone = '209747xxxx';
  String _email = 'xxx@gmail.com';

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.color1),
              title: Text(S.of(context).chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.color1),
              title: Text(S.of(context).takePhoto),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateUserInfo(String name, String phone, String email) {
    setState(() {
      _name = name;
      _phone = phone;
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Text(
            S.of(context).personalInformation,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              splashRadius: 24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: kToolbarHeight + 35, bottom: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Profile Picture Section
            ProfilePictureWidget(
              profileImage: _profileImage,
              onTap: () => _showImagePickerOptions(context),
            ),

            const SizedBox(height: 20),
            Text(
              _name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            // Personal Information Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  InfoTileWidget(
                    icon: Icons.person_outline,
                    title: S.of(context).name,
                    value: _name,
                  ),
                  const Divider(height: 1, indent: 20),
                  InfoTileWidget(
                    icon: Icons.phone_iphone_outlined,
                    title: S.of(context).phone,
                    value: _phone,
                  ),
                  const Divider(height: 1, indent: 20),
                  InfoTileWidget(
                    icon: Icons.email_outlined,
                    title: S.of(context).email,
                    value: _email,
                    lastItem: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Edit Profile Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientButtonWidget(
                onPressed: () => _showEditProfileForm(context),
                text: S.of(context).editData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileForm(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return EditProfileFormWidget(
          initialName: _name,
          initialPhone: _phone,
          initialEmail: _email,
          onSave: (name, phone, email) {
            _updateUserInfo(name, phone, email);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).dataSavedSuccessfully),
                backgroundColor: const Color(0xFF0D9488),
              ),
            );
          },
        );
      },
    );
  }
}
