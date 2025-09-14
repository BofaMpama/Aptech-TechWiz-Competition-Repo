import 'package:flutter/material.dart';
import 'package:pawfect/modules/auth/pet_owner_profile/pet_owner_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pawfect/core/constants/app_color.dart';

import '../../../../shared/component/app_button.dart';
import '../../../../shared/component/page_input.dart';


class PetOwnerProfileScreen extends StatefulWidget {
  const PetOwnerProfileScreen({super.key});
  static const String route = '/pet-owner-profile';

  @override
  State<PetOwnerProfileScreen> createState() => _PetOwnerProfileScreenState();
}

class _PetOwnerProfileScreenState extends State<PetOwnerProfileScreen> {
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
          'Pet Owner',
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
          create: (_) => PetOwnerProfileViewModel(),
          child: Consumer<PetOwnerProfileViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),

                      // Pet Name
                      PageInput(
                        hint: 'Becca Ade',
                        label: 'Pet name',
                        controller: viewModel.petNameController,
                        onChanged: (_) => viewModel.clearError(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pet name is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Pet Species Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Pet species',
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
                              value: viewModel.selectedPetSpecies,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                hintText: 'Dog',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFC4C4C4),
                                  fontSize: 16.sp,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select pet species';
                                }
                                return null;
                              },
                              items: viewModel.petSpecies.map((species) {
                                return DropdownMenuItem<String>(
                                  value: species,
                                  child: Text(
                                    species,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newSpecies) {
                                if (newSpecies != null) {
                                  viewModel.setSelectedPetSpecies(newSpecies);
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

                      // Gender Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              'Gender',
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
                              value: viewModel.selectedGender,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                hintText: 'Male',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFC4C4C4),
                                  fontSize: 16.sp,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender';
                                }
                                return null;
                              },
                              items: viewModel.genders.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newGender) {
                                if (newGender != null) {
                                  viewModel.setSelectedGender(newGender);
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

                      // Date of Birth
                      PageInput(
                        hint: '12/12/11',
                        label: 'Date of Birth',
                        controller: viewModel.dateOfBirthController,
                        onChanged: (_) => viewModel.clearError(),
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () => viewModel.selectDateOfBirth(context),
                        suffix: Icon(
                          Icons.calendar_today,
                          color: AppColors.primaryGreen,
                          size: 20.sp,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of birth is required';
                          }
                          return null;
                        },
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
                            return 'Pet colour is required';
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