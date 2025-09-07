import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'login_page.dart';
import 'user_page.dart';

class DashboardPage extends StatefulWidget {
  final UserModel user;

  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  final List<String> _menuTitles = [
    "Dashboard",
    "Profile",
    "Users",
    "Logout",
  ];
  final List<IconData> _menuIcons = [
    Icons.dashboard,
    Icons.person,
    Icons.people,
    Icons.logout,
  ];

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  String getGreeting(String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "☀️ Good Morning, $name!\nWishing you a bright and productive day ahead.\nLet's make today count!";
    } else if (hour < 17) {
      return "🌤️ Good Afternoon, $name!\nHope your day is going well so far.\nKeep up the great work!";
    } else {
      return "🌙 Good Evening, $name!\nYou’ve done amazing today, now it’s time to wind down and recharge.";
    }
  }

  // Choose which page to shoe in dasbord
 Widget _getPageContent() {
  switch (_selectedIndex) {
    case 0: // dashboard
      return _buildDashboardContent();
    case 1: // profle
      return _buildDashboardContent();
        
    case 2: // userss
      return UserPage(user: widget.user); 

    default:
      return const SizedBox.shrink();
  }
}


  // Extract gret
  Widget _buildDashboardContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double containerWidth =
            screenWidth < 400 ? screenWidth * 0.9 : screenWidth < 800 ? 400 : 600;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: containerWidth,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDEFB),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF90CAF9).withOpacity(0.6),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle, size: 90, color: Color(0xFF1565C0)),
              const SizedBox(height: 20),

              //gret

              Text(
                "${getGreeting(widget.user.fullName)}\n",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1565C0),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
      ),

      body: Row(
        children: [
          // Sidechickssaa
          Container(
            width: 250,
            color: const Color(0xFF1565C0),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    widget.user.fullName,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  accountEmail: Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  decoration: const BoxDecoration(color: Color(0xFF1565C0)),
                ),

                // Sidebar listss
                Expanded(
                  child: ListView.builder(
                    itemCount: _menuTitles.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedIndex == index;
                      bool isHovered = _hoveredIndex == index;

                      return MouseRegion(
                        onEnter: (_) => setState(() => _hoveredIndex = index),
                        onExit: (_) => setState(() => _hoveredIndex = -1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          color: isSelected
                              ? const Color(0xFFBBDEFB)
                              : isHovered
                                  ? Colors.white24
                                  : Colors.transparent,
                          child: ListTile(
                            leading: Icon(
                              _menuIcons[index],
                              color: isSelected ? Colors.black : Colors.white,
                            ),
                            title: Text(
                              _menuTitles[index],
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              setState(() => _selectedIndex = index);
                              if (_menuTitles[index] == "Logout") {
                                _logout(context);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main Continent
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFE3F2FD),
              child: Center(child: _getPageContent()),
            ),
          ),
        ],
      ),
    );
  }
}
