import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var notificationsEnabled = true.obs;
  var autoSaveEnabled = true.obs;

  void toggleDarkMode(bool val) => isDarkMode.value = val;
  void toggleNotifications(bool val) => notificationsEnabled.value = val;
  void toggleAutoSave(bool val) => autoSaveEnabled.value = val;
}

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dark = controller.isDarkMode.value;
      return Scaffold(
        backgroundColor: dark ? const Color(0xFF1A1A1A) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(dark),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileCard(dark),
                      const SizedBox(height: 32),

                      _buildSectionTitle('التفضيلات', dark),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        icon: Icons.dark_mode_rounded,
                        title: 'الوضع الداكن',
                        subtitle: 'تفعيل المظهر الليلي',
                        value: controller.isDarkMode.value,
                        onChanged: controller.toggleDarkMode,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        darkMode: dark,
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchTile(
                        icon: Icons.notifications_rounded,
                        title: 'الإشعارات',
                        subtitle: 'استقبال التنبيهات والإشعارات',
                        value: controller.notificationsEnabled.value,
                        onChanged: controller.toggleNotifications,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                        ),
                        darkMode: dark,
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchTile(
                        icon: Icons.save_rounded,
                        title: 'الحفظ التلقائي',
                        subtitle: 'حفظ الملاحظات تلقائياً',
                        value: controller.autoSaveEnabled.value,
                        onChanged: controller.toggleAutoSave,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                        ),
                        darkMode: dark,
                      ),
                      const SizedBox(height: 32),

                      _buildSectionTitle('الحساب', dark),
                      const SizedBox(height: 16),
                      _buildActionTile(
                        icon: Icons.person_rounded,
                        title: 'تعديل الملف الشخصي',
                        subtitle: 'تحديث بياناتك الشخصية',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFA709A), Color(0xFFFEE140)],
                        ),
                        darkMode: dark,
                        onTap: () => _showSnack(
                          'تعديل الملف الشخصي',
                          'سيتم فتح صفحة التعديل قريباً',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActionTile(
                        icon: Icons.lock_rounded,
                        title: 'تغيير كلمة المرور',
                        subtitle: 'تحديث كلمة المرور الخاصة بك',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF30CFD0), Color(0xFF330867)],
                        ),
                        darkMode: dark,
                        onTap: () => _showSnack(
                          'تغيير كلمة المرور',
                          'سيتم فتح نموذج تغيير كلمة المرور',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActionTile(
                        icon: Icons.language_rounded,
                        title: 'اللغة',
                        subtitle: 'العربية',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
                        ),
                        darkMode: dark,
                        onTap: () => _showLanguageDialog(dark),
                      ),
                      const SizedBox(height: 32),

                      _buildSectionTitle('المزيد', dark),
                      const SizedBox(height: 16),
                      _buildActionTile(
                        icon: Icons.info_rounded,
                        title: 'حول التطبيق',
                        subtitle: 'الإصدار 1.0.0',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD89B), Color(0xFF19547B)],
                        ),
                        darkMode: dark,
                        onTap: () => _showSnack(
                          'حول التطبيق',
                          'تطبيق الملاحظات الإصدار 1.0.0',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActionTile(
                        icon: Icons.help_rounded,
                        title: 'المساعدة والدعم',
                        subtitle: 'تواصل معنا للمساعدة',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF89F7FE), Color(0xFF66A6FF)],
                        ),
                        darkMode: dark,
                        onTap: () => _showSnack(
                          'المساعدة والدعم',
                          'للتواصل: support@notesapp.com',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActionTile(
                        icon: Icons.share_rounded,
                        title: 'مشاركة التطبيق',
                        subtitle: 'شارك مع أصدقائك',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFDCBF1), Color(0xFFE6DEE9)],
                        ),
                        darkMode: dark,
                        onTap: () => _showSnack(
                          'مشاركة التطبيق',
                          'تم نسخ رابط التطبيق للمشاركة',
                        ),
                      ),
                      const SizedBox(height: 32),

                      // زر تسجيل الخروج
                      _buildLogoutButton(dark),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(bool dark) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: dark
            ? [const Color(0xFF2C2C2C), const Color(0xFF1A1A1A)]
            : [const Color(0xFFF5F7FA), Colors.white],
      ),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: dark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'الإعدادات',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );

  Widget _buildProfileCard(bool dark) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 36,
            color: Color(0xFF667EEA),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'الشمري تاج راسك',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'HHHHHHHHH@example.com',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
        ),
      ],
    ),
  );

  Widget _buildSectionTitle(String title, bool dark) => Text(
    title,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: dark ? Colors.white : Colors.black87,
    ),
  );

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Gradient gradient,
    required bool darkMode,
  }) => Container(
    decoration: BoxDecoration(
      color: darkMode ? const Color(0xFF2C2C2C) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: darkMode
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.05),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkMode ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: darkMode ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF667EEA),
      ),
    ),
  );

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
    required bool darkMode,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: darkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkMode ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: darkMode ? Colors.white60 : Colors.black54,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: darkMode ? Colors.white38 : Colors.black38,
        ),
      ),
    ),
  );

  Widget _buildLogoutButton(bool dark) => GestureDetector(
    onTap: () => _showLogoutDialog(dark),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF416C).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout_rounded, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Text(
            'تسجيل الخروج',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  void _showSnack(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  void _showLanguageDialog(bool darkMode) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: darkMode ? const Color(0xFF2C2C2C) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'اختر اللغة',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _buildLanguageOption('العربية', true, darkMode),
            _buildLanguageOption('English', false, darkMode),
            _buildLanguageOption('BNGILY', false, darkMode),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    String language,
    bool isSelected,
    bool darkMode,
  ) => GestureDetector(
    onTap: () {
      Get.back();
      _showSnack('تم تغيير اللغة', 'تم تغيير اللغة إلى $language');
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF667EEA).withOpacity(0.1)
            : (darkMode ? Colors.white.withOpacity(0.05) : Colors.grey[100]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF667EEA) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Text(
            language,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFF667EEA)
                  : (darkMode ? Colors.white : Colors.black87),
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(Icons.check_circle, color: Color(0xFF667EEA), size: 24),
        ],
      ),
    ),
  );

  void _showLogoutDialog(bool darkMode) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: darkMode ? const Color(0xFF2C2C2C) : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'هل أنت متأكد من تسجيل الخروج؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: darkMode
                            ? Colors.white.withOpacity(0.1)
                            : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: darkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        _showSnack('تم تسجيل الخروج', 'تم تسجيل خروجك بنجاح');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFFFF416C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'تأكيد',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
