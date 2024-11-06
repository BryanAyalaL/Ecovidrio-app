// input_validator.dart
class InputValidator {
  static String? validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) {
      return 'El correo electrónico es requerido.';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Introduce un correo electrónico válido.';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña es requerida.';
    } else if (value.length < 3) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    return null;
  }
}
