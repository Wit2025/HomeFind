import 'package:flutter/material.dart';
import 'package:homefind/screens/service/chat/widget/chat_model.dart';
import 'package:homefind/screens/service/chat/widget/message_buble.dart';
import 'package:homefind/widgets/colors.dart';

class ChatScreen extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  final String serviceType;
  final IconData serviceIcon;

  const ChatScreen({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.serviceIcon,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadInitialMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialMessage() {
    setState(() {
      _messages.add(
        ChatMessage(
          id: '0',
          text: 'ສະບາຍດີ! ${widget.serviceName} ຍິນດີໃຫ້ບໍລິການ?',
          isFromMe: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.trim();
    final now = DateTime.now();

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: messageText,
          isFromMe: true,
          timestamp: now,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: _getAutoReply(messageText),
            isFromMe: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _getAutoReply(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('ລາຄາ') || lowerMessage.contains('ເທົ່າໃດ')) {
      return 'ລາຄາຂຶ້ນຢູ່ກັບປະເພດຂອງວຽກ ສາມາດໃຫ້ລາຍລະອຽດເພີ່ມເຕີມໄດ້ບໍ?';
    } else if (lowerMessage.contains('ເວລາ') || lowerMessage.contains('ວ່າງ')) {
      return 'ພວກເຮົາມີເວລາວ່າງໃນອາທິດນີ້ ລູກຄ້າຕ້ອງການນັດເວລາໃດ?';
    } else if (lowerMessage.contains('ສະບາຍດີ') ||
        lowerMessage.contains('hello')) {
      return 'ສະບາຍດີ! ມີຫຍັງໃຫ້ຊ່ວຍບໍ?';
    } else if (lowerMessage.contains('ຂອບໃຈ')) {
      return 'ຍິນດີໃຫ້ບໍລິການ! ມີຫຍັງໃຫ້ຊ່ວຍອີກບໍ?';
    } else {
      return 'ໄດ້ຮັບຂໍ້ຄວາມແລ້ວ ຈະຕິດຕໍ່ກັບໄປໃນໄວໆນີ້ເຈົ້າ';
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.color1, AppColors.color2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.color1.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(widget.serviceIcon, color: Colors.white, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Color(0xFF4ADE80),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'ອອນລາຍ',
                        style: TextStyle(
                          color: Color(0xFFE0F2FE),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: Colors.white, size: 25),
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // ข้อความแชท
          Expanded(
            child: Container(
              decoration: BoxDecoration(),
              child: _messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.color1.withValues(alpha: 0.1),
                            ),
                            child: Icon(
                              widget.serviceIcon,
                              size: 40,
                              color: AppColors.color1.withValues(alpha: 0.5),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'ເລີ່ມການສົນທະນາ',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return MessageBubble(
                          message: message,
                          serviceIcon: widget.serviceIcon,
                        );
                      },
                    ),
            ),
          ),

          // พื้นที่พิมพ์ข้อความ
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SafeArea(
              child: Row(
                children: [
                  // ปุ่มแนบไฟล์
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[100],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add_rounded, color: AppColors.color1),
                      onPressed: () {
                        // เพิ่มฟีเจอร์แนบไฟล์
                      },
                    ),
                  ),
                  SizedBox(width: 8),

                  // ช่องพิมพ์ข้อความ
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'ພິມຂໍ້ຄວາມ...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                              ),
                              maxLines: null,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  // ปุ่มส่ง
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.color1, AppColors.color2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.color1.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
