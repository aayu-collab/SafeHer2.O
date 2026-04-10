
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
void main() {
  runApp(SafeHerApp());
}

class SafeHerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

/// ---------------- START PAGE ----------------
class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // 🔵 Background blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔰 Shield + Location icon
           Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shield, size: 80, color: Colors.purple),
                Icon(Icons.location_on, size: 35, color: Colors.white),
              ],
            ),

            SizedBox(height: 20),
            Text(
              "SafeHer",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 40),

            // 🔘 Buttons side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text("Login"),
                ),

                SizedBox(width: 20), // space between buttons

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                  },
                  child: Text("Signup"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/// ---------------- HOME PAGE ----------------
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool voiceEnabled = false;
  late stt.SpeechToText _speech;
bool isListening = false;
String spokenText = "";

  @override


  void initState() {
  super.initState();
  _speech = stt.SpeechToText();
}
  Widget build(BuildContext context) {
    return Scaffold(
      /// 🔴 HEADER
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SafeHer", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Welcome !", style: TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shield, size: 50, color: Colors.purple),
                Icon(Icons.location_on, size: 15, color: Colors.white),
              ],
            ),
          )
        ],
      ),

      /// 🔴 BODY
      body: Stack(
        children: [
          /// SOS BUTTON
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SOSPage()),
                );
              },
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.red,
                child: Text(
                  "SOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          /// 💬 CHAT BUTTON
          Positioned(
            right: 20,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatBotPage()),
                );
              },
              child: Icon(Icons.chat),
            ),
          ),
        ],
      ),

      // 🎤 MIC BUTTON (FIXED)
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     setState(() {
      //       voiceEnabled = !voiceEnabled;
      //     });

      //     if (voiceEnabled) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Voice SOS enabled"),
      //           behavior: SnackBarBehavior.floating,
      //           duration: Duration(seconds: 1),
      //         ),
      //       );
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Voice SOS disabled"),
      //           behavior: SnackBarBehavior.floating,
      //           duration: Duration(seconds: 1),
      //         ),
      //       );
      //     }
      //   },
      //   child: CircleAvatar(
      //     radius: 30,
      //     backgroundColor: voiceEnabled ? Colors.red : Colors.grey,
      //     child: Icon(Icons.mic, color: Colors.white),
      //   ),
      // ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: GestureDetector(
  onTap: () async {
    if (!isListening) {
      bool available = await _speech.initialize();

      if (available) {
        setState(() {
          isListening = true;
          voiceEnabled = true;
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              spokenText = result.recognizedWords;
            });

            /// 🔥 SECRET WORD
            if (spokenText.toLowerCase().contains("help")) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("SOS Triggered 🚨")),
              );

              print("🚨 SOS TRIGGERED");
            }
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
        voiceEnabled = false;
      });

      _speech.stop();
    }
  },

  child: CircleAvatar(
    radius: 30,
    backgroundColor: voiceEnabled ? Colors.red : Colors.grey,
    child: Icon(Icons.mic, color: Colors.white),
  ),
),

//       /// 🔻 BOTTOM NAVIGATION
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// 🏠 HOME
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
              ),

              /// 🗺️ MAP
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  print("Map clicked");
                },
              ),

              SizedBox(width: 40),

              /// 📞 EMERGENCY
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EmergencyPage()),
                  );
                },
              ),

              /// 👤 PROFILE
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ---------------- SignupPage ----------------
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // 
  void signup() async {
    String name = nameController.text;
    String contact = contactController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // 🔴 Validation
    if (name.isEmpty ||
        contact.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // 💾 Save Data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("contact", contact);
    await prefs.setString("email", email);
    await prefs.setString("password", password);

    // ✅ Navigate to Login Page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }



  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue,

    appBar: AppBar(
      title: Text("Signup Page"),
      backgroundColor: Colors.blue,
      elevation: 0,
    ),

    body: Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 🛡️ LOGO
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.shield, size: 70, color: Colors.purple),
                  Icon(Icons.location_on, size: 30, color: Colors.white),
                ],
              ),

              SizedBox(height: 10),

              /// APP NAME
              Text(
                "SafeHer",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 30),

              /// NAME
              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              /// CONTACT
              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Contact",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              /// EMAIL
              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              /// PASSWORD
              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              /// CONFIRM PASSWORD
              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: confirmPasswordController, // 👈 new controller
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              /// SIGNUP BUTTON
              ElevatedButton(
                onPressed: () {
                  String pass = passwordController.text.trim();
                  String confirmPass = confirmPasswordController.text.trim();

                  if (pass != confirmPass) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match ❌"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  // 👇 call your original signup function
                  signup();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Signup",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
// ---------------- LoginPage ----------------
 class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 void login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String savedEmail = prefs.getString("email") ?? "";
  String savedPassword = prefs.getString("password") ?? "";

  String emailInput = emailController.text;
  String passwordInput = passwordController.text;

  if (emailInput != savedEmail || passwordInput != savedPassword) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Invalid login!")));
  } else {
    // ✅ Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }
}
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blue, // 🔵 Blue Background

    appBar: AppBar(
      title: Text("Login Page"),
      backgroundColor: Colors.blue,
      elevation: 0,
    ),

    body: Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center everything
          children: [

            /// 🛡️ LOGO
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shield, size: 70, color: Colors.purple),
                Icon(Icons.location_on, size: 30, color: Colors.white),
              ],
            ),

            SizedBox(height: 10),

            /// APP NAME
            Text(
              "SafeHer",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 30),

            /// 📩 EMAIL BOX
            Container(
              width: 280, // smaller box
              margin: EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),


            /// 🔑 PASSWORD BOX
            Container(
              width: 280,
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            /// 🔘 LOGIN BUTTON
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // 🔵 Dark Blue
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

/// ---------------- EMERGENCY PAGE ----------------


class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  List<String> contacts = [];

  void addContact(String number) {
    setState(() {
      contacts.add(number);
    });
  }

  void showAddDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Emergency Contact"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Enter phone number",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  addContact(controller.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
        backgroundColor: Colors.blue,
      ),

      body: contacts.isEmpty
          ? Center(child: Text("No Contacts Added"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.call, color: Colors.white),
                  title: Text(contacts[index]),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: showAddDialog,
      ),
    );
  }
}

/// ---------------- PROFILE PAGE ----------------
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Column(
        children: [

          SizedBox(height: 20),

          /// PROFILE ICON
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40),
          ),

          SizedBox(height: 10),

          /// USER NAME
          Text(
            "User Name",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),

          /// EMAIL
          Text(
            "user@email.com",
            style: TextStyle(color: Colors.grey),
          ),

          SizedBox(height: 20),

          /// 🔲 ALL OPTIONS IN ONE BOX
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit Profile"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      print("Edit Profile Clicked");
                    },
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Emergency Contacts"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      print("Emergency Contacts Clicked");
                    },
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text("Secret Code"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      print("Secret code updated");
                    },
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout", style: TextStyle(color: Colors.red),),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      print("Logout Clicked");
                    },
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
/// ---------------chatboot----------------

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  TextEditingController controller = TextEditingController();
  List<String> messages = [];

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add(controller.text);
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [
          //  Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       Icon(Icons.shield, size: 80, color: Colors.purple),
          //       Icon(Icons.location_on, size: 35, color: Colors.white),
          //     ],
          //   ),
          /// 🔵 HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [

                  SizedBox(width: 10),
                  Text(
                    "SafeHer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          /// 👋 GREETING
          Text(
            "Hi User!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Text("How can I assist you today?"),

          SizedBox(height: 20),

          /// 💬 MESSAGES
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          /// ✍️ INPUT BOX
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// sospage----------
class SOSPage extends StatefulWidget {
  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  int seconds = 3;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
        triggerSOS();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  void triggerSOS() {
    // 🔥 Yaha actual logic lagega
    print("🚨 SOS TRIGGERED");
    print("📍 Sending Location...");
    print("📞 Calling...");
    print("📩 Sending SMS...");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("🚨 Alert Sent Successfully")),
    );

    Navigator.pop(context); // back to home
  }

  void cancelSOS() {
    timer?.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "SOS ACTIVATING...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "$seconds",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: cancelSOS,
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}