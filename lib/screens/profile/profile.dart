import 'package:flutter/material.dart';
import 'package:login_signup/screens/signin_screen.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaController.text = prefs.getString('userName') ?? 'Nama Lengkap';
      userController.text = prefs.getString('userNickName') ?? 'Username';
      emailController.text = prefs.getString('userEmail') ?? 'Email';
      handphoneController.text = prefs.getString('userHandphone') ?? 'Nomor Handphone';
      alamatController.text = prefs.getString('userAlamat') ?? 'Alamat';
    });
  }

  Future<void> _logout(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Batal', style: TextStyle(color: Colors.white),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignInScreen(), 
        ),
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Halaman Profile",
          style: TextStyle(
            color: whiteBackgroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/no_user.jpg"),
                  radius: 60,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: namaController,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Nama Lengkap'),
                   labelStyle: TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: userController,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Username'),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Email'),
                   labelStyle: TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: handphoneController,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Nomor Handphone',style: TextStyle(color: Colors.white),),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: alamatController,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Alamat'),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenLightColor, 
                ),
                onPressed: () => _logout(context),
                child: Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
