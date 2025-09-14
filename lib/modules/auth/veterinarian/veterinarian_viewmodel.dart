import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VeterinarianProfileViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController petColourController = TextEditingController();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedLocation;
  String? _selectedAvailability;

  // Dropdown options
  final List<String> locations = [
    'Calabar South',
    'Calabar North',
    'Port Harcourt',
    'Lagos Island',
    'Victoria Island',
    'Ikeja',
    'Abuja Central',
    'Garki',
    'Other'
  ];

  final List<String> availabilities = [
    'Weekdays',
    'Weekends',
    'Full Time',
    'Part Time',
    'On Call',
    'Emergency Only'
  ];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedLocation => _selectedLocation;
  String? get selectedAvailability => _selectedAvailability;

  // Form validation getter
  bool get isFormValid {
    return clinicNameController.text.trim().isNotEmpty &&
        _selectedLocation != null &&
        _selectedAvailability != null &&
        petColourController.text.trim().isNotEmpty;
  }

  // Methods
  void setSelectedLocation(String location) {
    _selectedLocation = location;
    clearError();
    notifyListeners();
  }

  void setSelectedAvailability(String availability) {
    _selectedAvailability = availability;
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

      // Here you would save the veterinarian profile data
      final profileData = {
        'clinicName': clinicNameController.text.trim(),
        'location': _selectedLocation,
        'availability': _selectedAvailability,
        'petColour': petColourController.text.trim(),
      };

      if (kDebugMode) {
        print('Veterinarian Profile saved: $profileData');
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
    clinicNameController.dispose();
    petColourController.dispose();
    super.dispose();
  }
}