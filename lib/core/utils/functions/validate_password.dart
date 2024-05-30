String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is empty';
  }

  // Check for at least 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  // Check for at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter (A - Z)';
  }

  // Check for at least one lowercase letter
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter (a - z)';
  }

  // Check for at least one number
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number (0 - 9)';
  }

  // Check for at least one special character
  if (!value.contains(RegExp(r'[~@#$%^&*_\-+=,.?/]'))) {
    return 'Password must contain at least one special character (~@#\$%^&*_\\-+=,.?/)';
  }

  return null; // Return null if password meets all criteria
}