import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ShelterAdminProfileViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController organizationNameController = TextEditingController();
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
    '24/7 Operations',
    'Business Hours Only'
  ];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedLocation => _selectedLocation;
  String? get selectedAvailability => _selectedAvailability;

  // Form validation getter
  bool get isFormValid {
    return organizationNameController.text.trim().isNotEmpty &&
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

      // Here you would save the shelter admin profile data
      final profileData = {
        'organizationName': organizationNameController.text.trim(),
        'location': _selectedLocation,
        'availability': _selectedAvailability,
        'petColour': petColourController.text.trim(),
      };

      if (kDebugMode) {
        print('Shelter Admin Profile saved: $profileData');
      }

      _setLoading(false);

      // Navigate to home or next screen
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
        return;
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
    organizationNameController.dispose();
    petColourController.dispose();
    super.dispose();
  }
}