import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PetOwnerProfileViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController petColourController = TextEditingController();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedPetSpecies;
  String? _selectedGender;
  DateTime? _selectedDate;

  // Dropdown options
  final List<String> petSpecies = ['Dog', 'Cat', 'Bird', 'Fish', 'Rabbit', 'Hamster', 'Other'];
  final List<String> genders = ['Male', 'Female'];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedPetSpecies => _selectedPetSpecies;
  String? get selectedGender => _selectedGender;
  DateTime? get selectedDate => _selectedDate;

  // Form validation getter
  bool get isFormValid {
    return petNameController.text.trim().isNotEmpty &&
        _selectedPetSpecies != null &&
        _selectedGender != null &&
        dateOfBirthController.text.isNotEmpty &&
        petColourController.text.trim().isNotEmpty;
  }

  // Methods
  void setSelectedPetSpecies(String species) {
    _selectedPetSpecies = species;
    clearError();
    notifyListeners();
  }

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    clearError();
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF153121),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dateOfBirthController.text = '${picked.day.toString().padLeft(2, '0')}/'
          '${picked.month.toString().padLeft(2, '0')}/'
          '${picked.year.toString().substring(2)}';
      clearError();
      notifyListeners();
    }
  }

  Future<void> saveProfile(BuildContext context) async {
    if (!isFormValid) {
      setErrorMessage('Please fill in all required fields');
      return;
    }

    _setLoading(true);
    clearError();

    try {
      // Simulate API call or database save
      await Future.delayed(const Duration(seconds: 2));

      // Here you would save the pet profile data
      final profileData = {
        'petName': petNameController.text.trim(),
        'petSpecies': _selectedPetSpecies,
        'gender': _selectedGender,
        'dateOfBirth': _selectedDate?.toIso8601String(),
        'petColour': petColourController.text.trim(),
      };

      if (kDebugMode) {
        print('Pet Owner Profile saved: $profileData');
      }

      _setLoading(false);

      // Navigate to home or next screen
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }

    } catch (e) {
      _setLoading(false);
      setErrorMessage('Failed to save profile. Please try again.');

      if (kDebugMode) {
        print('Save profile error: $e');
      }
    }
  }

  @override
  void dispose() {
    petNameController.dispose();
    dateOfBirthController.dispose();
    petColourController.dispose();
    super.dispose();
  }
}