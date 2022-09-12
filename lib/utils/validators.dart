String? validateNotEmpty(String? val) {
  if (val == null || val.isEmpty) {
    return "This can't be empty";
  }

  if (double.tryParse(val) == null) {
    return "Please enter a valid number";
  }

  return null;
}
