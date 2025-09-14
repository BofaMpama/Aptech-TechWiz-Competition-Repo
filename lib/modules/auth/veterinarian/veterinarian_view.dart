import 'package:flutter/material.dart';
import 'package:pawfect/modules/auth/veterinarian/veterinarian_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect/core/constants/app_color.dart';

import '../../../../shared/component/app_button.dart';
import '../../../../shared/component/page_input.dart';


class VeterinarianProfileScreen extends StatefulWidget {
  const VeterinarianProfileScreen({super.key});
  static const String route = '/veterinarian-profile';

  @override
  State<VeterinarianProfileScreen> createState() => _VeterinarianProfileScreenState();
}

class _VeterinarianProfileScreenState extends State<VeterinarianProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Veterinarian Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => VeterinarianProfileViewModel(),
          child: Consumer<VeterinarianProfileViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),

                      // Clinic or Hospital Name
                      PageInput(
                        hint: 'Teaching hospital',
                        label: 'Clinic or hospital name',
                        controller: viewModel.clinicNameController,
                        onChanged: (_) => viewModel.clearError(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Clinic or hospital name is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Location Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColors.lightGreen,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: const Color(0xFF153121),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: viewModel.selectedLocation,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                hintText: 'Calabar South',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFC4C4C4),
                                  fontSize: 16.sp,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select location';
                                }
                                return null;
                              },
                              items: viewModel.locations.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newLocation) {
                                if (newLocation != null) {
                                  viewModel.setSelectedLocation(newLocation);
                                }
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Availability Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Availability',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColors.lightGreen,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: const Color(0xFF153121),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: viewModel.selectedAvailability,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                hintText: 'Weekdays',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFC4C4C4),
                                  fontSize: 16.sp,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select availability';
                                }
                                return null;
                              },
                              items: viewModel.availabilities.map((availability) {
                                return DropdownMenuItem<String>(
                                  value: availability,
                                  child: Text(
                                    availability,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newAvailability) {
                                if (newAvailability != null) {
                                  viewModel.setSelectedAvailability(newAvailability);
                                }
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Pet Colour
                      PageInput(
                        hint: 'Pet\'s colour',
                        label: 'Colour',
                        controller: viewModel.petColourController,
                        onChanged: (_) => viewModel.clearError(),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pet colour preference is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 40.h),

                      // Error Message
                      if (viewModel.errorMessage != null) ...[
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            viewModel.errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],

                      // Continue Button
                      AppButton(
                        title: 'Continue',
                        loading: viewModel.isLoading,
                        enabled: viewModel.isFormValid,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await viewModel.saveProfile(context);
                          }
                        },
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}