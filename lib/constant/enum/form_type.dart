enum LoginFormFieldsEnum { email, password }

enum SignUpFormFieldsEnum {
  firstName,
  lastName,
  email,
  gender,
  password,
  confirmPassword,
}

enum EditProfileFormFieldsEnum { firstName, lastName, gender }

enum ForgotPasswordFormFieldsEnum { email }

enum ChangePasswordFormFieldsEnum {
  currentPassword,
  newPassword,
  confirmNewPassword,
}

enum CreateEditChoreFormFieldsEnum {
  chorePhoto,
  title,
  description,
  dueDate,
  space,
  assignedTo,
}

enum CreateEditSpaceFormFieldsEnum { spacePhoto, name, description }

enum JoinSpaceFormFieldsEnum { spaceCode }
