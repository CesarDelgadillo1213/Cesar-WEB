import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_web/api_service.dart';
import 'principal/pantallainicio.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Color.fromARGB(223, 83, 6, 6)),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(223, 83, 6, 6),
        title: Text(
          "MED EASE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Bienvenido",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "INICIA SESION",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20), // Add some space before the text fields
                  Center(
                    child: Column(
                      children: [
                        _buildTextField(
                          Icons.email,
                          "Correo Electrónico",
                          _emailController,
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<bool>(
                          valueListenable: _passwordVisible,
                          builder: (context, value, child) {
                            return _buildTextField(
                              Icons.lock,
                              "Contraseña",
                              _passwordController,
                              isPassword: true,
                              isVisible: value,
                              toggleVisibility: () {
                                _passwordVisible.value = !_passwordVisible.value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildButton(Icons.app_registration, "INICIAR SESION", () {
                    if (_formKey.currentState!.validate()) {
                      _iniciarSesion(_emailController.text,
                          _passwordController.text, context);
                    }
                  }),
                  const SizedBox(height: 10), // Add some space between buttons
                  _buildButton(
                      Icons.admin_panel_settings, "Ingresar como Administrador",
                      () {
                    // Check if the username and password match admin credentials
                    if (_emailController.text == 'admin' &&
                        _passwordController.text == '123456') {
                      // Save admin flag in SharedPreferences
                      _guardarAdminEnSharedPreferences().then((value) {
                        // Navigate to admin screen or perform admin-specific actions
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaInicio()));
                      });
                    } else {
                      // Show snackbar for invalid credentials
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Credenciales inválidas')),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    IconData icon,
    String label,
    TextEditingController controller, {
    bool isRequired = true,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: SizedBox(
          width: 600, // Set a specific width for the text fields
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            obscureText: isPassword && !isVisible,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: toggleVisibility,
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildButton(IconData icon, String text, VoidCallback onPressed) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 300, // Ancho deseado
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(223, 83, 6, 6), // Color de fondo
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white, // Color del texto
          ),
        ),
      ),
    ),
  );
}


  Future<void> _iniciarSesion(
    String correo, String password, BuildContext context) async {
  ApiService apiService = ApiService();
  try {
    int? responseStatus = await apiService.login(correo, password);
    if (responseStatus == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaInicio()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Credenciales inválidas')),
      );
    }
  } catch (e) {
    // Manejar errores de inicio de sesión
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al iniciar sesión')),
    );
  }
}

  Future<void> _guardarAdminEnSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdmin', true);
  }
}
