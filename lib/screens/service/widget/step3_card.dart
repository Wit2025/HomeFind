import 'package:flutter/material.dart';

class Step3Waiting extends StatelessWidget {
  const Step3Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7 - 100,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.hourglass_empty, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'ກຳລັງລໍຖ້າຊ່າງຕອບກັບ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ໄດ້ສົ່ງການແຈ້ງເຕືອນໃຫ້ຊ່າງແລ້ວ\nກະລຸນາລໍຖ້າ...',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}