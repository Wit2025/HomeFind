import 'package:flutter/material.dart';
import 'package:homefind/screens/service/chat/widget/chat_model.dart';
import 'package:homefind/widgets/colors.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final IconData serviceIcon;

  const MessageBubble({
    super.key,
    required this.message,
    required this.serviceIcon,
  });

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isFromMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isFromMe) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.color1, AppColors.color2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.color1.withValues(alpha: 0.2),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(serviceIcon, size: 16, color: Colors.white),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isFromMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: message.isFromMe
                        ? LinearGradient(
                            colors: [AppColors.color1, AppColors.color2],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [Colors.white, Color(0xFFF5F9FF)],
                          ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(message.isFromMe ? 18 : 6),
                      bottomRight: Radius.circular(message.isFromMe ? 6 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: message.isFromMe
                        ? null
                        : Border.all(color: Colors.grey[100]!, width: 1),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isFromMe ? Colors.white : Colors.black87,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (message.isFromMe) SizedBox(width: 8),
        ],
      ),
    );
  }
}
