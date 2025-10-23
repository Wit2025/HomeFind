import 'package:flutter/material.dart';

class CustomDialog {
  /// Shows a success dialog with checkmark icon
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onPressed,
    Widget? navigateToScreen,
    bool removeAllRoutes = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Background container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF008B8B),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF008B8B),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            if (onPressed != null) {
                              onPressed();
                            } else if (navigateToScreen != null) {
                              if (removeAllRoutes) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                );
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Animated checkmark icon
                Positioned(
                  top: -40,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00CEB0),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CEB0).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows an error dialog with X icon
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onPressed,
    Widget? navigateToScreen,
    bool removeAllRoutes = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Background container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE74C3C),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE74C3C),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            if (onPressed != null) {
                              onPressed();
                            } else if (navigateToScreen != null) {
                              if (removeAllRoutes) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                );
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Animated X icon
                Positioned(
                  top: -40,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE74C3C),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE74C3C).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows a warning dialog with warning icon
  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onPressed,
    Widget? navigateToScreen,
    bool removeAllRoutes = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Background container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF39C12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF39C12),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            if (onPressed != null) {
                              onPressed();
                            } else if (navigateToScreen != null) {
                              if (removeAllRoutes) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => navigateToScreen,
                                  ),
                                );
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Animated warning icon
                Positioned(
                  top: -40,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF39C12),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF39C12).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.warning,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Usage Examples:
/*

// Success Dialog
CustomDialog.showSuccess(
  context: context,
  title: 'ສຳເລັດ!',
  message: 'ທ່ານໄດ້ຢືນຢັນ OTP ສຳເລັດ',
  buttonText: 'ໄປທີ່ໜ້າຫຼັກ',
  navigateToScreen: MainScreen(),
  removeAllRoutes: true,
);

// Error Dialog
CustomDialog.showError(
  context: context,
  title: 'ຜິດພາດ!',
  message: 'OTP ທີ່ທ່ານໃສ່ບໍ່ຖືກຕ້ອງ',
  buttonText: 'ລອງໃໝ່',
  onPressed: () {
    Navigator.pop(context);
    // Add your retry logic here
  },
);

// Warning Dialog
CustomDialog.showWarning(
  context: context,
  title: 'ເຕືອນ!',
  message: 'ທ່ານແນ່ໃຈບໍ່ວ່າຕ້ອງການດຳເນີນການນີ້?',
  buttonText: 'ຮູ້ແລ້ວ',
  onPressed: () {
    Navigator.pop(context);
  },
);

*/
