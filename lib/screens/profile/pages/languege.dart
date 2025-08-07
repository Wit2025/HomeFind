import 'package:flutter/material.dart';

class LanguegePage extends StatefulWidget {
  const LanguegePage({super.key});

  @override
  State<LanguegePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguegePage> {
  String _selectedLanguage = 'lo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'ປ່ຽນພາສາ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A7A85), Color(0xFF0C697A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ເລືອກພາສາທີ່ທ່ານຕ້ອງການ',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildLanguageTile(
                      languageCode: 'lo',
                      languageName: 'ລາວ (Lao)',
                      flagAsset: 'assets/images/lao.png',
                    ),
                    _buildDivider(),
                    _buildLanguageTile(
                      languageCode: 'en',
                      languageName: 'English',
                      flagAsset: 'assets/images/en.png',
                    ),
                    _buildDivider(),
                    _buildLanguageTile(
                      languageCode: 'zh',
                      languageName: '中文 (Chinese)',
                      flagAsset: 'assets/images/ch.png',
                    ),
                    _buildDivider(),
                    _buildLanguageTile(
                      languageCode: 'ko',
                      languageName: '한국어 (Korean)',
                      flagAsset: 'assets/images/ko.png',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Save language preference
                Navigator.pop(context, _selectedLanguage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0C697A),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'ຢືນຢັນ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required String languageCode,
    required String languageName,
    required String flagAsset,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: ClipOval(child: Image.asset(flagAsset, fit: BoxFit.cover)),
      ),
      title: Text(
        languageName,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Radio<String>(
        value: languageCode,
        groupValue: _selectedLanguage,
        onChanged: (value) {
          setState(() {
            _selectedLanguage = value!;
          });
        },
        activeColor: Color(0xFF0C697A),
      ),
      onTap: () {
        setState(() {
          _selectedLanguage = languageCode;
        });
      },
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[200]),
    );
  }
}
