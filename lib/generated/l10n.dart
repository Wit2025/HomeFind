// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirm {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Logged out successfully`
  String get logoutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'logoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message('Income', name: 'income', desc: '', args: []);
  }

  /// `Fee`
  String get fee {
    return Intl.message('Fee', name: 'fee', desc: '', args: []);
  }

  /// `Kip`
  String get kip {
    return Intl.message('Kip', name: 'kip', desc: '', args: []);
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message('Withdraw', name: 'withdraw', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `History`
  String get withdrawHistory {
    return Intl.message('History', name: 'withdrawHistory', desc: '', args: []);
  }

  /// `Invite`
  String get inviteFriends {
    return Intl.message('Invite', name: 'inviteFriends', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Booking History`
  String get bookingHistory {
    return Intl.message(
      'Booking History',
      name: 'bookingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Policies`
  String get termsPolicies {
    return Intl.message(
      'Terms & Policies',
      name: 'termsPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Home`
  String get homepage {
    return Intl.message('Home', name: 'homepage', desc: '', args: []);
  }

  /// `Join`
  String get joinpage {
    return Intl.message('Join', name: 'joinpage', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message('Take Photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Edit Data`
  String get editData {
    return Intl.message('Edit Data', name: 'editData', desc: '', args: []);
  }

  /// `Edit Personal Information`
  String get editPersonalInformation {
    return Intl.message(
      'Edit Personal Information',
      name: 'editPersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Data saved successfully`
  String get dataSavedSuccessfully {
    return Intl.message(
      'Data saved successfully',
      name: 'dataSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Please enter your new password',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your old password`
  String get pleaseEnterOldPassword {
    return Intl.message(
      'Please enter your old password',
      name: 'pleaseEnterOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the new password again`
  String get pleaseEnterNewPasswordAgain {
    return Intl.message(
      'Please enter the new password again',
      name: 'pleaseEnterNewPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMin6Chars {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMin6Chars',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm the new password`
  String get pleaseConfirmNewPassword {
    return Intl.message(
      'Please confirm the new password',
      name: 'pleaseConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Changing password...`
  String get changingPassword {
    return Intl.message(
      'Changing password...',
      name: 'changingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select the language you want`
  String get selectLanguage {
    return Intl.message(
      'Select the language you want',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Rent`
  String get rent {
    return Intl.message('Rent', name: 'rent', desc: '', args: []);
  }

  /// `Sale`
  String get sale {
    return Intl.message('Sale', name: 'sale', desc: '', args: []);
  }

  /// `Terms and Policy`
  String get termsAndPolicy {
    return Intl.message(
      'Terms and Policy',
      name: 'termsAndPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Data Collection`
  String get dataCollection {
    return Intl.message(
      'Data Collection',
      name: 'dataCollection',
      desc: '',
      args: [],
    );
  }

  /// `The application collects only necessary personal data for usage and service purposes.`
  String get dataCollectionDescription {
    return Intl.message(
      'The application collects only necessary personal data for usage and service purposes.',
      name: 'dataCollectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Data Usage`
  String get dataUsage {
    return Intl.message('Data Usage', name: 'dataUsage', desc: '', args: []);
  }

  /// `Collected data will be used for service development and improvement.`
  String get dataUsageDescription {
    return Intl.message(
      'Collected data will be used for service development and improvement.',
      name: 'dataUsageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Data Sharing`
  String get dataSharing {
    return Intl.message(
      'Data Sharing',
      name: 'dataSharing',
      desc: '',
      args: [],
    );
  }

  /// `Your data will not be shared with others except as required by law.`
  String get dataSharingDescription {
    return Intl.message(
      'Your data will not be shared with others except as required by law.',
      name: 'dataSharingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Data Protection`
  String get dataProtection {
    return Intl.message(
      'Data Protection',
      name: 'dataProtection',
      desc: '',
      args: [],
    );
  }

  /// `The application implements security measures to protect your personal data.`
  String get dataProtectionDescription {
    return Intl.message(
      'The application implements security measures to protect your personal data.',
      name: 'dataProtectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Policy Update`
  String get policyUpdate {
    return Intl.message(
      'Policy Update',
      name: 'policyUpdate',
      desc: '',
      args: [],
    );
  }

  /// `We may update this policy in the future, please check regularly.`
  String get policyUpdateDescription {
    return Intl.message(
      'We may update this policy in the future, please check regularly.',
      name: 'policyUpdateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Please read our privacy policy carefully before using the application.`
  String get privacyPolicyDescription {
    return Intl.message(
      'Please read our privacy policy carefully before using the application.',
      name: 'privacyPolicyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Popular Question Types`
  String get popularQuestionTypes {
    return Intl.message(
      'Popular Question Types',
      name: 'popularQuestionTypes',
      desc: '',
      args: [],
    );
  }

  /// `Login Issues`
  String get loginIssues {
    return Intl.message(
      'Login Issues',
      name: 'loginIssues',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password or Account Locked`
  String get forgotPasswordOrLocked {
    return Intl.message(
      'Forgot Password or Account Locked',
      name: 'forgotPasswordOrLocked',
      desc: '',
      args: [],
    );
  }

  /// `Account Management`
  String get accountManagement {
    return Intl.message(
      'Account Management',
      name: 'accountManagement',
      desc: '',
      args: [],
    );
  }

  /// `Update Personal Info or Delete Account`
  String get updatePersonalInfoOrDeleteAccount {
    return Intl.message(
      'Update Personal Info or Delete Account',
      name: 'updatePersonalInfoOrDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Orders and Payments`
  String get ordersAndPayments {
    return Intl.message(
      'Orders and Payments',
      name: 'ordersAndPayments',
      desc: '',
      args: [],
    );
  }

  /// `Purchase or Refund Check`
  String get purchaseOrRefundCheck {
    return Intl.message(
      'Purchase or Refund Check',
      name: 'purchaseOrRefundCheck',
      desc: '',
      args: [],
    );
  }

  /// `Security and Privacy`
  String get securityAndPrivacy {
    return Intl.message(
      'Security and Privacy',
      name: 'securityAndPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `About Policy`
  String get aboutPolicy {
    return Intl.message(
      'About Policy',
      name: 'aboutPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Search questions...`
  String get searchQuestions {
    return Intl.message(
      'Search questions...',
      name: 'searchQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Need more help?`
  String get needMoreHelp {
    return Intl.message(
      'Need more help?',
      name: 'needMoreHelp',
      desc: '',
      args: [],
    );
  }

  /// `Our support team is ready to assist you 24 hours`
  String get supportTeam24h {
    return Intl.message(
      'Our support team is ready to assist you 24 hours',
      name: 'supportTeam24h',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `Frequently Asked Questions`
  String get frequentQuestions {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'frequentQuestions',
      desc: '',
      args: [],
    );
  }

  /// `How do I change my password?`
  String get howToChangePassword {
    return Intl.message(
      'How do I change my password?',
      name: 'howToChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `How do I cancel my order?`
  String get howToCancelOrder {
    return Intl.message(
      'How do I cancel my order?',
      name: 'howToCancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `What payment methods are available?`
  String get paymentMethods {
    return Intl.message(
      'What payment methods are available?',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Where can I contact support from?`
  String get contactSupportFrom {
    return Intl.message(
      'Where can I contact support from?',
      name: 'contactSupportFrom',
      desc: '',
      args: [],
    );
  }

  /// `Example answer for this question. You can find more information in the help section of our app.`
  String get exampleAnswer {
    return Intl.message(
      'Example answer for this question. You can find more information in the help section of our app.',
      name: 'exampleAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Please enter complete data`
  String get pleaseEnterCompleteData {
    return Intl.message(
      'Please enter complete data',
      name: 'pleaseEnterCompleteData',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Money`
  String get withdrawMoney {
    return Intl.message(
      'Withdraw Money',
      name: 'withdrawMoney',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message('to', name: 'to', desc: '', args: []);
  }

  /// `Amount to withdraw`
  String get amountToWithdraw {
    return Intl.message(
      'Amount to withdraw',
      name: 'amountToWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Available balance`
  String get availableBalance {
    return Intl.message(
      'Available balance',
      name: 'availableBalance',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw to account`
  String get withdrawToAccount {
    return Intl.message(
      'Withdraw to account',
      name: 'withdrawToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Add account`
  String get addAccount {
    return Intl.message('Add account', name: 'addAccount', desc: '', args: []);
  }

  /// `Confirm withdrawal`
  String get confirmWithdrawal {
    return Intl.message(
      'Confirm withdrawal',
      name: 'confirmWithdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message('Score', name: 'score', desc: '', args: []);
  }

  /// `Total Points`
  String get totalScore {
    return Intl.message('Total Points', name: 'totalScore', desc: '', args: []);
  }

  /// `Redeem Points`
  String get redeemPoints {
    return Intl.message(
      'Redeem Points',
      name: 'redeemPoints',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Score History`
  String get scoreHistory {
    return Intl.message(
      'Score History',
      name: 'scoreHistory',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal History`
  String get withdrawalHistory {
    return Intl.message(
      'Withdrawal History',
      name: 'withdrawalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Details`
  String get withdrawalDetails {
    return Intl.message(
      'Withdrawal Details',
      name: 'withdrawalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Withdrawal Method`
  String get withdrawMethod {
    return Intl.message(
      'Withdrawal Method',
      name: 'withdrawMethod',
      desc: '',
      args: [],
    );
  }

  /// `Destination Account`
  String get destinationAccount {
    return Intl.message(
      'Destination Account',
      name: 'destinationAccount',
      desc: '',
      args: [],
    );
  }

  /// `Transaction ID`
  String get transactionId {
    return Intl.message(
      'Transaction ID',
      name: 'transactionId',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Price:`
  String get price {
    return Intl.message('Price:', name: 'price', desc: '', args: []);
  }

  /// `Type`
  String get bookingType {
    return Intl.message('Type', name: 'bookingType', desc: '', args: []);
  }

  /// `Receipt`
  String get receipt {
    return Intl.message('Receipt', name: 'receipt', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Unread`
  String get unread {
    return Intl.message('Unread', name: 'unread', desc: '', args: []);
  }

  /// `Read all`
  String get markAllAsRead {
    return Intl.message('Read all', name: 'markAllAsRead', desc: '', args: []);
  }

  /// `{count} days ago`
  String daysAgo(Object count) {
    return Intl.message(
      '$count days ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} hours ago`
  String hoursAgo(Object count) {
    return Intl.message(
      '$count hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} minutes ago`
  String minutesAgo(Object count) {
    return Intl.message(
      '$count minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Read`
  String get read {
    return Intl.message('Read', name: 'read', desc: '', args: []);
  }

  /// `No unread notifications`
  String get noUnreadNotifications {
    return Intl.message(
      'No unread notifications',
      name: 'noUnreadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No read notifications`
  String get noReadNotifications {
    return Intl.message(
      'No read notifications',
      name: 'noReadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Parking`
  String get parking {
    return Intl.message('Parking', name: 'parking', desc: '', args: []);
  }

  /// `Internet`
  String get internet {
    return Intl.message('Internet', name: 'internet', desc: '', args: []);
  }

  /// `Home Appliance`
  String get home_appliance {
    return Intl.message(
      'Home Appliance',
      name: 'home_appliance',
      desc: '',
      args: [],
    );
  }

  /// `Swimming`
  String get swimming {
    return Intl.message('Swimming', name: 'swimming', desc: '', args: []);
  }

  /// `Refrigerator`
  String get refrigerator {
    return Intl.message(
      'Refrigerator',
      name: 'refrigerator',
      desc: '',
      args: [],
    );
  }

  /// `Security Check`
  String get security_check {
    return Intl.message(
      'Security Check',
      name: 'security_check',
      desc: '',
      args: [],
    );
  }

  /// `Air conditioner`
  String get air {
    return Intl.message('Air conditioner', name: 'air', desc: '', args: []);
  }

  /// `Washing Machine`
  String get washing_machine {
    return Intl.message(
      'Washing Machine',
      name: 'washing_machine',
      desc: '',
      args: [],
    );
  }

  /// `Post Delivery`
  String get post_delivery {
    return Intl.message(
      'Post Delivery',
      name: 'post_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Your Accommodation Info`
  String get your_accommodation_info {
    return Intl.message(
      'Your Accommodation Info',
      name: 'your_accommodation_info',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation Name`
  String get accommodation_name {
    return Intl.message(
      'Accommodation Name',
      name: 'accommodation_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter accommodation name`
  String get please_enter_accommodation_name {
    return Intl.message(
      'Please enter accommodation name',
      name: 'please_enter_accommodation_name',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation Type`
  String get accommodation_type {
    return Intl.message(
      'Accommodation Type',
      name: 'accommodation_type',
      desc: '',
      args: [],
    );
  }

  /// `House`
  String get house {
    return Intl.message('House', name: 'house', desc: '', args: []);
  }

  /// `Townhouse`
  String get townhouse {
    return Intl.message('Townhouse', name: 'townhouse', desc: '', args: []);
  }

  /// `Apartment`
  String get apartment {
    return Intl.message('Apartment', name: 'apartment', desc: '', args: []);
  }

  /// `Land`
  String get land {
    return Intl.message('Land', name: 'land', desc: '', args: []);
  }

  /// `Accommodation Zone`
  String get accommodation_zone {
    return Intl.message(
      'Accommodation Zone',
      name: 'accommodation_zone',
      desc: '',
      args: [],
    );
  }

  /// `Install App`
  String get install_air {
    return Intl.message('Install App', name: 'install_air', desc: '', args: []);
  }

  /// `Moving goods`
  String get moving_goods {
    return Intl.message(
      'Moving goods',
      name: 'moving_goods',
      desc: '',
      args: [],
    );
  }

  /// `Install glass`
  String get install_glass {
    return Intl.message(
      'Install glass',
      name: 'install_glass',
      desc: '',
      args: [],
    );
  }

  /// `Furniture`
  String get furniture {
    return Intl.message('Furniture', name: 'furniture', desc: '', args: []);
  }

  /// `Share Room`
  String get share_room {
    return Intl.message('Share Room', name: 'share_room', desc: '', args: []);
  }

  /// `No Share Room`
  String get no_share_room {
    return Intl.message(
      'No Share Room',
      name: 'no_share_room',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation Details`
  String get accommodation_details {
    return Intl.message(
      'Accommodation Details',
      name: 'accommodation_details',
      desc: '',
      args: [],
    );
  }

  /// `Please enter price`
  String get please_enter_price {
    return Intl.message(
      'Please enter price',
      name: 'please_enter_price',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid number`
  String get please_enter_valid_number {
    return Intl.message(
      'Please enter valid number',
      name: 'please_enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Size (sq.m.)`
  String get size {
    return Intl.message('Size (sq.m.)', name: 'size', desc: '', args: []);
  }

  /// `Please enter size`
  String get please_enter_size {
    return Intl.message(
      'Please enter size',
      name: 'please_enter_size',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Please enter address`
  String get please_enter_address {
    return Intl.message(
      'Please enter address',
      name: 'please_enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get please_enter_phone {
    return Intl.message(
      'Please enter phone number',
      name: 'please_enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Facilities`
  String get facilities {
    return Intl.message('Facilities', name: 'facilities', desc: '', args: []);
  }

  /// `Please enter details`
  String get please_enter_details {
    return Intl.message(
      'Please enter details',
      name: 'please_enter_details',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation photo (at least 1)`
  String get accommodation_photo_min_1 {
    return Intl.message(
      'Accommodation photo (at least 1)',
      name: 'accommodation_photo_min_1',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get add_photo {
    return Intl.message('Add photo', name: 'add_photo', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Can add up to 10 photos`
  String get max_10_photos {
    return Intl.message(
      'Can add up to 10 photos',
      name: 'max_10_photos',
      desc: '',
      args: [],
    );
  }

  /// `Error selecting photo:`
  String get photo_selection_error {
    return Intl.message(
      'Error selecting photo:',
      name: 'photo_selection_error',
      desc: '',
      args: [],
    );
  }

  /// `Please add at least 1 photo`
  String get please_add_min_1_photo {
    return Intl.message(
      'Please add at least 1 photo',
      name: 'please_add_min_1_photo',
      desc: '',
      args: [],
    );
  }

  /// `Added accommodation successfully`
  String get added_accommodation_success {
    return Intl.message(
      'Added accommodation successfully',
      name: 'added_accommodation_success',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `5% Discount`
  String get discount_5_percent {
    return Intl.message(
      '5% Discount',
      name: 'discount_5_percent',
      desc: '',
      args: [],
    );
  }

  /// `The breakfast buffet was amazing and very worth it! The location is perfect and the staff was incredibly helpful throughout our stay.`
  String get breakfast_review {
    return Intl.message(
      'The breakfast buffet was amazing and very worth it! The location is perfect and the staff was incredibly helpful throughout our stay.',
      name: 'breakfast_review',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get book {
    return Intl.message('Booking', name: 'book', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Select Image`
  String get select_image {
    return Intl.message(
      'Select Image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Scan QR Code to Pay`
  String get scan_qr_code_payment {
    return Intl.message(
      'Scan QR Code to Pay',
      name: 'scan_qr_code_payment',
      desc: '',
      args: [],
    );
  }

  /// `Upload Transfer Receipt`
  String get upload_transfer_receipt {
    return Intl.message(
      'Upload Transfer Receipt',
      name: 'upload_transfer_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Upload Completed`
  String get upload_completed {
    return Intl.message(
      'Upload Completed',
      name: 'upload_completed',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Select Image`
  String get tap_to_select_image {
    return Intl.message(
      'Tap to Select Image',
      name: 'tap_to_select_image',
      desc: '',
      args: [],
    );
  }

  /// `JPG, PNG or PDF`
  String get file_formats {
    return Intl.message(
      'JPG, PNG or PDF',
      name: 'file_formats',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get please_wait {
    return Intl.message('Please Wait', name: 'please_wait', desc: '', args: []);
  }

  /// `Confirm Booking`
  String get confirm_booking {
    return Intl.message(
      'Confirm Booking',
      name: 'confirm_booking',
      desc: '',
      args: [],
    );
  }

  /// `Booking Receipt`
  String get booking_receipt {
    return Intl.message(
      'Booking Receipt',
      name: 'booking_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Share Receipt`
  String get share_receipt {
    return Intl.message(
      'Share Receipt',
      name: 'share_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Booking Successful`
  String get booking_successful {
    return Intl.message(
      'Booking Successful',
      name: 'booking_successful',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been saved`
  String get booking_data_saved {
    return Intl.message(
      'Your booking has been saved',
      name: 'booking_data_saved',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get booking_details {
    return Intl.message(
      'Booking Details',
      name: 'booking_details',
      desc: '',
      args: [],
    );
  }

  /// `Booking Code`
  String get booking_code {
    return Intl.message(
      'Booking Code',
      name: 'booking_code',
      desc: '',
      args: [],
    );
  }

  /// `Booking Date`
  String get booking_date {
    return Intl.message(
      'Booking Date',
      name: 'booking_date',
      desc: '',
      args: [],
    );
  }

  /// `Booking Time`
  String get booking_time {
    return Intl.message(
      'Booking Time',
      name: 'booking_time',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `Total Price`
  String get total_booking_price {
    return Intl.message(
      'Total Price',
      name: 'total_booking_price',
      desc: '',
      args: [],
    );
  }

  /// `Downloading...`
  String get downloading {
    return Intl.message(
      'Downloading...',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Download Receipt`
  String get download_receipt {
    return Intl.message(
      'Download Receipt',
      name: 'download_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Print Receipt`
  String get print_receipt {
    return Intl.message(
      'Print Receipt',
      name: 'print_receipt',
      desc: '',
      args: [],
    );
  }

  /// `keep this receipt as proof of booking`
  String get keep_receipt_notice {
    return Intl.message(
      'keep this receipt as proof of booking',
      name: 'keep_receipt_notice',
      desc: '',
      args: [],
    );
  }

  /// `Booking code copied`
  String get booking_code_copied {
    return Intl.message(
      'Booking code copied',
      name: 'booking_code_copied',
      desc: '',
      args: [],
    );
  }

  /// `Receipt downloaded successfully`
  String get download_receipt_success {
    return Intl.message(
      'Receipt downloaded successfully',
      name: 'download_receipt_success',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please check your phone number and password.`
  String get login_failed {
    return Intl.message(
      'Login failed. Please check your phone number and password.',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Home Find`
  String get welcome_home_find {
    return Intl.message(
      'Welcome to Home Find',
      name: 'welcome_home_find',
      desc: '',
      args: [],
    );
  }

  /// `Please login`
  String get please_login {
    return Intl.message(
      'Please login',
      name: 'please_login',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Invalid phone number`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid phone number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Remember me`
  String get remember_user {
    return Intl.message(
      'Remember me',
      name: 'remember_user',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Login with Google`
  String get login_with_google {
    return Intl.message(
      'Login with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet?`
  String get no_account_yet {
    return Intl.message(
      'Don\'t have an account yet?',
      name: 'no_account_yet',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Please accept terms and conditions first`
  String get accept_terms_first {
    return Intl.message(
      'Please accept terms and conditions first',
      name: 'accept_terms_first',
      desc: '',
      args: [],
    );
  }

  /// `Registration error occurred`
  String get registration_error {
    return Intl.message(
      'Registration error occurred',
      name: 'registration_error',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get create_new_account {
    return Intl.message(
      'Create New Account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your information`
  String get please_enter_your_info {
    return Intl.message(
      'Please enter your information',
      name: 'please_enter_your_info',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `Please enter full name`
  String get please_enter_full_name {
    return Intl.message(
      'Please enter full name',
      name: 'please_enter_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get please_enter_email {
    return Intl.message(
      'Please enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get please_enter_password {
    return Intl.message(
      'Please enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get password_min_length {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'password_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Accept terms and conditions`
  String get accept_terms_conditions {
    return Intl.message(
      'Accept terms and conditions',
      name: 'accept_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Register with Google`
  String get register_with_google {
    return Intl.message(
      'Register with Google',
      name: 'register_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'lo'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
