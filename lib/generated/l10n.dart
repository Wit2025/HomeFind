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

  /// `Search results for "{query}"`
  String searchResultsFor(Object query) {
    return Intl.message(
      'Search results for "$query"',
      name: 'searchResultsFor',
      desc: '',
      args: [query],
    );
  }

  /// `Help Categories ({count})`
  String helpCategoriesCount(Object count) {
    return Intl.message(
      'Help Categories ($count)',
      name: 'helpCategoriesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Frequently Asked Questions ({count})`
  String frequentQuestionsCount(Object count) {
    return Intl.message(
      'Frequently Asked Questions ($count)',
      name: 'frequentQuestionsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No search results found`
  String get noSearchResults {
    return Intl.message(
      'No search results found',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Try searching with different keywords or contact support team`
  String get tryOtherKeywords {
    return Intl.message(
      'Try searching with different keywords or contact support team',
      name: 'tryOtherKeywords',
      desc: '',
      args: [],
    );
  }

  /// `Clear Search`
  String get clearSearch {
    return Intl.message(
      'Clear Search',
      name: 'clearSearch',
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

  /// `Account Name`
  String get accountName {
    return Intl.message(
      'Account Name',
      name: 'accountName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account name`
  String get accountNameHint {
    return Intl.message(
      'Please enter account name',
      name: 'accountNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account name`
  String get accountNameValidation {
    return Intl.message(
      'Please enter account name',
      name: 'accountNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account number`
  String get accountNumberHint {
    return Intl.message(
      'Please enter account number',
      name: 'accountNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account number`
  String get accountNumberValidation {
    return Intl.message(
      'Please enter account number',
      name: 'accountNumberValidation',
      desc: '',
      args: [],
    );
  }

  /// `Account number must have at least`
  String get accountNumberMinLength {
    return Intl.message(
      'Account number must have at least',
      name: 'accountNumberMinLength',
      desc: '',
      args: [],
    );
  }

  /// `digits`
  String get digits {
    return Intl.message('digits', name: 'digits', desc: '', args: []);
  }

  /// `Account added successfully`
  String get accountAddedSuccess {
    return Intl.message(
      'Account added successfully',
      name: 'accountAddedSuccess',
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

  /// `Air Conditioner`
  String get air {
    return Intl.message('Air Conditioner', name: 'air', desc: '', args: []);
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

  /// `Post for Me`
  String get post_for_me {
    return Intl.message('Post for Me', name: 'post_for_me', desc: '', args: []);
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

  /// `Room Sharing`
  String get accommodation_zone {
    return Intl.message(
      'Room Sharing',
      name: 'accommodation_zone',
      desc: '',
      args: [],
    );
  }

  /// `Install ac`
  String get install_air {
    return Intl.message('Install ac', name: 'install_air', desc: '', args: []);
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

  /// `Please add at least 1 accommodation photo`
  String get please_add_min_1_photo {
    return Intl.message(
      'Please add at least 1 accommodation photo',
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

  /// `-5%`
  String get discount_5_percent {
    return Intl.message('-5%', name: 'discount_5_percent', desc: '', args: []);
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

  /// `Booking Bill`
  String get bookingBill {
    return Intl.message(
      'Booking Bill',
      name: 'bookingBill',
      desc: '',
      args: [],
    );
  }

  /// `Booking Successful!`
  String get bookingSuccess {
    return Intl.message(
      'Booking Successful!',
      name: 'bookingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Thank you`
  String get thankYou {
    return Intl.message('Thank you', name: 'thankYou', desc: '', args: []);
  }

  /// `Booking ID`
  String get bookingId {
    return Intl.message('Booking ID', name: 'bookingId', desc: '', args: []);
  }

  /// `Customer`
  String get customer {
    return Intl.message('Customer', name: 'customer', desc: '', args: []);
  }

  /// `Items`
  String get items {
    return Intl.message('Items', name: 'items', desc: '', args: []);
  }

  /// `No items`
  String get noItems {
    return Intl.message('No items', name: 'noItems', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Tax`
  String get tax {
    return Intl.message('Tax', name: 'tax', desc: '', args: []);
  }

  /// `Total Amount`
  String get grandTotal {
    return Intl.message('Total Amount', name: 'grandTotal', desc: '', args: []);
  }

  /// `Back to Home`
  String get backHome {
    return Intl.message('Back to Home', name: 'backHome', desc: '', args: []);
  }

  /// `Receipt saved`
  String get receiptSaved {
    return Intl.message(
      'Receipt saved',
      name: 'receiptSaved',
      desc: '',
      args: [],
    );
  }

  /// `Save Receipt`
  String get saveReceipt {
    return Intl.message(
      'Save Receipt',
      name: 'saveReceipt',
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

  /// `App to help you find your accommodation..`
  String get app_description {
    return Intl.message(
      'App to help you find your accommodation..',
      name: 'app_description',
      desc: '',
      args: [],
    );
  }

  /// `You are not registered yet`
  String get not_registered_yet {
    return Intl.message(
      'You are not registered yet',
      name: 'not_registered_yet',
      desc: '',
      args: [],
    );
  }

  /// `Please login first to use this function`
  String get please_login_first {
    return Intl.message(
      'Please login first to use this function',
      name: 'please_login_first',
      desc: '',
      args: [],
    );
  }

  /// `To receive OTP code for password change`
  String get otp_for_password_change {
    return Intl.message(
      'To receive OTP code for password change',
      name: 'otp_for_password_change',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP Code`
  String get send_otp_code {
    return Intl.message(
      'Send OTP Code',
      name: 'send_otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get back_to_login {
    return Intl.message(
      'Back to Login',
      name: 'back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Please enter 6-digit OTP`
  String get enter_6_digit_otp {
    return Intl.message(
      'Please enter 6-digit OTP',
      name: 'enter_6_digit_otp',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verify_otp {
    return Intl.message('Verify OTP', name: 'verify_otp', desc: '', args: []);
  }

  /// `Enter OTP Code`
  String get enter_otp_code {
    return Intl.message(
      'Enter OTP Code',
      name: 'enter_otp_code',
      desc: '',
      args: [],
    );
  }

  /// `OTP code has been sent to number`
  String get otp_sent_to_number {
    return Intl.message(
      'OTP code has been sent to number',
      name: 'otp_sent_to_number',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Back to Previous`
  String get back_to_previous {
    return Intl.message(
      'Back to Previous',
      name: 'back_to_previous',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Change New Password`
  String get change_new_password {
    return Intl.message(
      'Change New Password',
      name: 'change_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Save New Password`
  String get save_new_password {
    return Intl.message(
      'Save New Password',
      name: 'save_new_password',
      desc: '',
      args: [],
    );
  }

  /// `SMS Message`
  String get sms_message {
    return Intl.message('SMS Message', name: 'sms_message', desc: '', args: []);
  }

  /// `Now`
  String get now {
    return Intl.message('Now', name: 'now', desc: '', args: []);
  }

  /// `Your verification code`
  String get your_verification_code {
    return Intl.message(
      'Your verification code',
      name: 'your_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Do not share this code with others`
  String get do_not_share_code {
    return Intl.message(
      'Do not share this code with others',
      name: 'do_not_share_code',
      desc: '',
      args: [],
    );
  }

  /// `Your new verification code`
  String get your_new_verification_code {
    return Intl.message(
      'Your new verification code',
      name: 'your_new_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `This code will expire in 5 minutes`
  String get code_expires_5_minutes {
    return Intl.message(
      'This code will expire in 5 minutes',
      name: 'code_expires_5_minutes',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully verified OTP`
  String get otp_verified_successfully {
    return Intl.message(
      'You have successfully verified OTP',
      name: 'otp_verified_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Go to Homepage`
  String get go_to_homepage {
    return Intl.message(
      'Go to Homepage',
      name: 'go_to_homepage',
      desc: '',
      args: [],
    );
  }

  /// `OTP is incorrect, please try again`
  String get otp_incorrect_try_again {
    return Intl.message(
      'OTP is incorrect, please try again',
      name: 'otp_incorrect_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code`
  String get please_enter_verification_code {
    return Intl.message(
      'Please enter verification code',
      name: 'please_enter_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP code to `
  String get send_otp_to {
    return Intl.message(
      'Send OTP code to ',
      name: 'send_otp_to',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resend_otp {
    return Intl.message('Resend OTP', name: 'resend_otp', desc: '', args: []);
  }

  /// `seconds`
  String get seconds {
    return Intl.message('seconds', name: 'seconds', desc: '', args: []);
  }

  /// `Join`
  String get join {
    return Intl.message('Join', name: 'join', desc: '', args: []);
  }

  /// `Post Yourself`
  String get post_own {
    return Intl.message('Post Yourself', name: 'post_own', desc: '', args: []);
  }

  /// `Terms and Conditions for Participation`
  String get terms_and_policies {
    return Intl.message(
      'Terms and Conditions for Participation',
      name: 'terms_and_policies',
      desc: '',
      args: [],
    );
  }

  /// `How you want to proceed`
  String get choose {
    return Intl.message(
      'How you want to proceed',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to our platform!`
  String get welcome_message {
    return Intl.message(
      'Welcome to our platform!',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Create your own property listing`
  String get create_own_listing {
    return Intl.message(
      'Create your own property listing',
      name: 'create_own_listing',
      desc: '',
      args: [],
    );
  }

  /// `Let us help you create a listing`
  String get help_create_listing {
    return Intl.message(
      'Let us help you create a listing',
      name: 'help_create_listing',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message('Get Started', name: 'get_started', desc: '', args: []);
  }

  /// `Please read the following terms and conditions carefully before proceeding. By joining our platform, you are deemed to have read, understood, and accepted all the terms specified.`
  String get read_terms_carefully {
    return Intl.message(
      'Please read the following terms and conditions carefully before proceeding. By joining our platform, you are deemed to have read, understood, and accepted all the terms specified.',
      name: 'read_terms_carefully',
      desc: '',
      args: [],
    );
  }

  /// `Definitions`
  String get definitions_title {
    return Intl.message(
      'Definitions',
      name: 'definitions_title',
      desc: '',
      args: [],
    );
  }

  /// `"Platform" refers to any website, application, or service we provide`
  String get platform_definition {
    return Intl.message(
      '"Platform" refers to any website, application, or service we provide',
      name: 'platform_definition',
      desc: '',
      args: [],
    );
  }

  /// `"User" refers to any person who accesses or uses our platform`
  String get user_definition {
    return Intl.message(
      '"User" refers to any person who accesses or uses our platform',
      name: 'user_definition',
      desc: '',
      args: [],
    );
  }

  /// `"Content" refers to text, images, videos, or any data posted on the platform`
  String get content_definition {
    return Intl.message(
      '"Content" refers to text, images, videos, or any data posted on the platform',
      name: 'content_definition',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance of Terms`
  String get acceptance_of_terms_title {
    return Intl.message(
      'Acceptance of Terms',
      name: 'acceptance_of_terms_title',
      desc: '',
      args: [],
    );
  }

  /// `By using our platform, you agree to be bound by these terms and policies, including our privacy policy`
  String get acceptance_clause {
    return Intl.message(
      'By using our platform, you agree to be bound by these terms and policies, including our privacy policy',
      name: 'acceptance_clause',
      desc: '',
      args: [],
    );
  }

  /// `If you do not agree with any terms, you should not use our platform`
  String get disagreement_clause {
    return Intl.message(
      'If you do not agree with any terms, you should not use our platform',
      name: 'disagreement_clause',
      desc: '',
      args: [],
    );
  }

  /// `Platform Usage`
  String get platform_usage_title {
    return Intl.message(
      'Platform Usage',
      name: 'platform_usage_title',
      desc: '',
      args: [],
    );
  }

  /// `You must be at least 18 years old to use this platform`
  String get age_requirement {
    return Intl.message(
      'You must be at least 18 years old to use this platform',
      name: 'age_requirement',
      desc: '',
      args: [],
    );
  }

  /// `You agree not to post content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable`
  String get prohibited_content {
    return Intl.message(
      'You agree not to post content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable',
      name: 'prohibited_content',
      desc: '',
      args: [],
    );
  }

  /// `You agree not to use the platform for any unauthorized or illegal purposes`
  String get unauthorized_use {
    return Intl.message(
      'You agree not to use the platform for any unauthorized or illegal purposes',
      name: 'unauthorized_use',
      desc: '',
      args: [],
    );
  }

  /// `We reserve the right to remove any content we deem inappropriate or suspend any user account that violates these terms`
  String get content_moderation {
    return Intl.message(
      'We reserve the right to remove any content we deem inappropriate or suspend any user account that violates these terms',
      name: 'content_moderation',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy_title {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy_title',
      desc: '',
      args: [],
    );
  }

  /// `We value your privacy. Please read our privacy policy to understand how we collect, use, and disclose your information`
  String get privacy_importance {
    return Intl.message(
      'We value your privacy. Please read our privacy policy to understand how we collect, use, and disclose your information',
      name: 'privacy_importance',
      desc: '',
      args: [],
    );
  }

  /// `By using our platform, you consent to our collection and use of your data as specified in our privacy policy`
  String get data_consent {
    return Intl.message(
      'By using our platform, you consent to our collection and use of your data as specified in our privacy policy',
      name: 'data_consent',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual Property`
  String get intellectual_property_title {
    return Intl.message(
      'Intellectual Property',
      name: 'intellectual_property_title',
      desc: '',
      args: [],
    );
  }

  /// `All content on the platform is owned by us or our licensors and is protected by copyright and trademark laws`
  String get content_ownership {
    return Intl.message(
      'All content on the platform is owned by us or our licensors and is protected by copyright and trademark laws',
      name: 'content_ownership',
      desc: '',
      args: [],
    );
  }

  /// `You may not copy, reproduce, distribute, or create derivative works from any content without written permission from us`
  String get copying_prohibition {
    return Intl.message(
      'You may not copy, reproduce, distribute, or create derivative works from any content without written permission from us',
      name: 'copying_prohibition',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of Liability`
  String get liability_limitation_title {
    return Intl.message(
      'Limitation of Liability',
      name: 'liability_limitation_title',
      desc: '',
      args: [],
    );
  }

  /// `Our platform is provided "as is" and "as available" without any warranties, express or implied`
  String get as_is_service {
    return Intl.message(
      'Our platform is provided "as is" and "as available" without any warranties, express or implied',
      name: 'as_is_service',
      desc: '',
      args: [],
    );
  }

  /// `We will not be liable for any damages arising from the use or inability to use our platform`
  String get no_liability {
    return Intl.message(
      'We will not be liable for any damages arising from the use or inability to use our platform',
      name: 'no_liability',
      desc: '',
      args: [],
    );
  }

  /// `Changes to Terms`
  String get terms_changes_title {
    return Intl.message(
      'Changes to Terms',
      name: 'terms_changes_title',
      desc: '',
      args: [],
    );
  }

  /// `We reserve the right to modify or update these terms and policies at any time. Changes will take effect immediately upon posting on the platform`
  String get modification_rights {
    return Intl.message(
      'We reserve the right to modify or update these terms and policies at any time. Changes will take effect immediately upon posting on the platform',
      name: 'modification_rights',
      desc: '',
      args: [],
    );
  }

  /// `Continued use of the platform after changes constitutes acceptance of the revised terms`
  String get continued_use {
    return Intl.message(
      'Continued use of the platform after changes constitutes acceptance of the revised terms',
      name: 'continued_use',
      desc: '',
      args: [],
    );
  }

  /// `Applicable Law`
  String get applicable_law_title {
    return Intl.message(
      'Applicable Law',
      name: 'applicable_law_title',
      desc: '',
      args: [],
    );
  }

  /// `These terms and policies shall be governed by and construed in accordance with the laws of the Lao PDR`
  String get governing_law {
    return Intl.message(
      'These terms and policies shall be governed by and construed in accordance with the laws of the Lao PDR',
      name: 'governing_law',
      desc: '',
      args: [],
    );
  }

  /// `Any disputes arising from or related to these terms shall be under the jurisdiction of the courts of the Lao PDR`
  String get jurisdiction {
    return Intl.message(
      'Any disputes arising from or related to these terms shall be under the jurisdiction of the courts of the Lao PDR',
      name: 'jurisdiction',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us_title {
    return Intl.message(
      'Contact Us',
      name: 'contact_us_title',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get contact_info {
    return Intl.message(
      'Contact Information',
      name: 'contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Additional Terms`
  String get additional_terms_title {
    return Intl.message(
      'Additional Terms',
      name: 'additional_terms_title',
      desc: '',
      args: [],
    );
  }

  /// `Please note that we may update or add additional terms and policies from time to time to comply with changes in law or our services. These changes will be announced on the platform and will take effect immediately when you continue to use our services after the announcement.`
  String get additional_terms_notice {
    return Intl.message(
      'Please note that we may update or add additional terms and policies from time to time to comply with changes in law or our services. These changes will be announced on the platform and will take effect immediately when you continue to use our services after the announcement.',
      name: 'additional_terms_notice',
      desc: '',
      args: [],
    );
  }

  /// `We thank you for taking the time to read and understand these terms and policies. Your acceptance will help us provide the best service to you.`
  String get thank_you_message {
    return Intl.message(
      'We thank you for taking the time to read and understand these terms and policies. Your acceptance will help us provide the best service to you.',
      name: 'thank_you_message',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy using our platform!`
  String get enjoy_platform {
    return Intl.message(
      'Enjoy using our platform!',
      name: 'enjoy_platform',
      desc: '',
      args: [],
    );
  }

  /// `I have read and accept all terms and conditions`
  String get acceptance_checkbox {
    return Intl.message(
      'I have read and accept all terms and conditions',
      name: 'acceptance_checkbox',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept_button {
    return Intl.message('Accept', name: 'accept_button', desc: '', args: []);
  }

  /// `Please enter your personal information completely for identity verification`
  String get please_enter_personal_info {
    return Intl.message(
      'Please enter your personal information completely for identity verification',
      name: 'please_enter_personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get upload_photo {
    return Intl.message(
      'Upload Photo',
      name: 'upload_photo',
      desc: '',
      args: [],
    );
  }

  /// `Upload your current photo`
  String get upload_current_photo {
    return Intl.message(
      'Upload your current photo',
      name: 'upload_current_photo',
      desc: '',
      args: [],
    );
  }

  /// `Document Photo`
  String get document_photo {
    return Intl.message(
      'Document Photo',
      name: 'document_photo',
      desc: '',
      args: [],
    );
  }

  /// `Upload identification document photo`
  String get upload_id_document {
    return Intl.message(
      'Upload identification document photo',
      name: 'upload_id_document',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document Photo`
  String get upload_document {
    return Intl.message(
      'Upload Document Photo',
      name: 'upload_document',
      desc: '',
      args: [],
    );
  }

  /// `Tap to upload document photo`
  String get tap_to_upload_document {
    return Intl.message(
      'Tap to upload document photo',
      name: 'tap_to_upload_document',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Please enter first name`
  String get please_enter_first_name {
    return Intl.message(
      'Please enter first name',
      name: 'please_enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter last name`
  String get please_enter_last_name {
    return Intl.message(
      'Please enter last name',
      name: 'please_enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birth_date {
    return Intl.message('Birth Date', name: 'birth_date', desc: '', args: []);
  }

  /// `Please enter birth date`
  String get please_enter_birth_date {
    return Intl.message(
      'Please enter birth date',
      name: 'please_enter_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Village`
  String get village {
    return Intl.message('Village', name: 'village', desc: '', args: []);
  }

  /// `Please enter village name`
  String get please_enter_village {
    return Intl.message(
      'Please enter village name',
      name: 'please_enter_village',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message('District', name: 'district', desc: '', args: []);
  }

  /// `Please enter district name`
  String get please_enter_district {
    return Intl.message(
      'Please enter district name',
      name: 'please_enter_district',
      desc: '',
      args: [],
    );
  }

  /// `Province`
  String get province {
    return Intl.message('Province', name: 'province', desc: '', args: []);
  }

  /// `Please enter province name`
  String get please_enter_province {
    return Intl.message(
      'Please enter province name',
      name: 'please_enter_province',
      desc: '',
      args: [],
    );
  }

  /// `Identification Document`
  String get id_document {
    return Intl.message(
      'Identification Document',
      name: 'id_document',
      desc: '',
      args: [],
    );
  }

  /// `Document Type`
  String get document_type {
    return Intl.message(
      'Document Type',
      name: 'document_type',
      desc: '',
      args: [],
    );
  }

  /// `Document Number`
  String get document_number {
    return Intl.message(
      'Document Number',
      name: 'document_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter document number`
  String get please_enter_document_number {
    return Intl.message(
      'Please enter document number',
      name: 'please_enter_document_number',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Image selection error`
  String get image_selection_error {
    return Intl.message(
      'Image selection error',
      name: 'image_selection_error',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the information`
  String get please_complete_info {
    return Intl.message(
      'Please complete the information',
      name: 'please_complete_info',
      desc: '',
      args: [],
    );
  }

  /// `Please upload document photo`
  String get please_upload_document {
    return Intl.message(
      'Please upload document photo',
      name: 'please_upload_document',
      desc: '',
      args: [],
    );
  }

  /// `Please upload personal photo`
  String get please_upload_personal_photo {
    return Intl.message(
      'Please upload personal photo',
      name: 'please_upload_personal_photo',
      desc: '',
      args: [],
    );
  }

  /// `Error loading saved data`
  String get errorLoadingSavedData {
    return Intl.message(
      'Error loading saved data',
      name: 'errorLoadingSavedData',
      desc: '',
      args: [],
    );
  }

  /// `Error converting base64 to file`
  String get errorConvertingBase64ToFile {
    return Intl.message(
      'Error converting base64 to file',
      name: 'errorConvertingBase64ToFile',
      desc: '',
      args: [],
    );
  }

  /// `Error converting file to base64`
  String get errorConvertingFileToBase64 {
    return Intl.message(
      'Error converting file to base64',
      name: 'errorConvertingFileToBase64',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get idCard {
    return Intl.message('ID Card', name: 'idCard', desc: '', args: []);
  }

  /// `Passport`
  String get passport {
    return Intl.message('Passport', name: 'passport', desc: '', args: []);
  }

  /// `Family Book`
  String get familyBook {
    return Intl.message('Family Book', name: 'familyBook', desc: '', args: []);
  }

  /// `{docType} Number`
  String document_number_label(Object docType) {
    return Intl.message(
      '$docType Number',
      name: 'document_number_label',
      desc: '',
      args: [docType],
    );
  }

  /// `Maximum 16 images reached`
  String get full_16_images {
    return Intl.message(
      'Maximum 16 images reached',
      name: 'full_16_images',
      desc: '',
      args: [],
    );
  }

  /// `Can add up to 16 images maximum`
  String get max_16_images {
    return Intl.message(
      'Can add up to 16 images maximum',
      name: 'max_16_images',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation Information`
  String get accommodation_info {
    return Intl.message(
      'Accommodation Information',
      name: 'accommodation_info',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your accommodation information for promotion`
  String get complete_info_for_promo {
    return Intl.message(
      'Please complete your accommodation information for promotion',
      name: 'complete_info_for_promo',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get service_type {
    return Intl.message(
      'Service Type',
      name: 'service_type',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Upload Accommodation Image`
  String get upload_main_image {
    return Intl.message(
      'Upload Accommodation Image',
      name: 'upload_main_image',
      desc: '',
      args: [],
    );
  }

  /// `Upload Current Accommodation Photo (1 image)`
  String get upload_current_photo_1 {
    return Intl.message(
      'Upload Current Accommodation Photo (1 image)',
      name: 'upload_current_photo_1',
      desc: '',
      args: [],
    );
  }

  /// `Tap to upload image`
  String get tap_to_upload {
    return Intl.message(
      'Tap to upload image',
      name: 'tap_to_upload',
      desc: '',
      args: [],
    );
  }

  /// `Accommodation Photos`
  String get accommodation_photos {
    return Intl.message(
      'Accommodation Photos',
      name: 'accommodation_photos',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 16 photos`
  String get max_16_photos {
    return Intl.message(
      'Maximum 16 photos',
      name: 'max_16_photos',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basic_info {
    return Intl.message(
      'Basic Information',
      name: 'basic_info',
      desc: '',
      args: [],
    );
  }

  /// `Per Month`
  String get per_month {
    return Intl.message('Per Month', name: 'per_month', desc: '', args: []);
  }

  /// `Rental Period`
  String get rental_period {
    return Intl.message(
      'Rental Period',
      name: 'rental_period',
      desc: '',
      args: [],
    );
  }

  /// `Room Sharing`
  String get room_sharing {
    return Intl.message(
      'Room Sharing',
      name: 'room_sharing',
      desc: '',
      args: [],
    );
  }

  /// `Price Per Year`
  String get price_per_year {
    return Intl.message(
      'Price Per Year',
      name: 'price_per_year',
      desc: '',
      args: [],
    );
  }

  /// `Price Per Month`
  String get price_per_month {
    return Intl.message(
      'Price Per Month',
      name: 'price_per_month',
      desc: '',
      args: [],
    );
  }

  /// `Price and Location`
  String get price_and_location {
    return Intl.message(
      'Price and Location',
      name: 'price_and_location',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct number`
  String get please_enter_correct_number {
    return Intl.message(
      'Please enter correct number',
      name: 'please_enter_correct_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must start with 20 and have 10 digits`
  String get phone_format_required {
    return Intl.message(
      'Phone number must start with 20 and have 10 digits',
      name: 'phone_format_required',
      desc: '',
      args: [],
    );
  }

  /// `Additional Details`
  String get additional_details {
    return Intl.message(
      'Additional Details',
      name: 'additional_details',
      desc: '',
      args: [],
    );
  }

  /// `Additional Details (if any)`
  String get additional_details_optional {
    return Intl.message(
      'Additional Details (if any)',
      name: 'additional_details_optional',
      desc: '',
      args: [],
    );
  }

  /// `Describe accommodation details, facilities, and other information...`
  String get description_placeholder {
    return Intl.message(
      'Describe accommodation details, facilities, and other information...',
      name: 'description_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get submit_data {
    return Intl.message('Post', name: 'submit_data', desc: '', args: []);
  }

  /// `Please upload main accommodation image`
  String get please_upload_main_image {
    return Intl.message(
      'Please upload main accommodation image',
      name: 'please_upload_main_image',
      desc: '',
      args: [],
    );
  }

  /// `Please select rental period`
  String get please_select_rental_period {
    return Intl.message(
      'Please select rental period',
      name: 'please_select_rental_period',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get submit_success {
    return Intl.message('Success!', name: 'submit_success', desc: '', args: []);
  }

  /// `You have posted the data`
  String get you_posted_data {
    return Intl.message(
      'You have posted the data',
      name: 'you_posted_data',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get understood {
    return Intl.message('OK', name: 'understood', desc: '', args: []);
  }

  /// `Select Currency`
  String get selectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'selectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Commission Fee (if any)`
  String get commissionFee {
    return Intl.message(
      'Commission Fee (if any)',
      name: 'commissionFee',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message('Total Price', name: 'totalPrice', desc: '', args: []);
  }

  /// `Address and Contact Information`
  String get addressAndContact {
    return Intl.message(
      'Address and Contact Information',
      name: 'addressAndContact',
      desc: '',
      args: [],
    );
  }

  /// `Per Year`
  String get perYear {
    return Intl.message('Per Year', name: 'perYear', desc: '', args: []);
  }

  /// `Swimming Pool`
  String get swimmingPool {
    return Intl.message(
      'Swimming Pool',
      name: 'swimmingPool',
      desc: '',
      args: [],
    );
  }

  /// `Find your next home with us`
  String get find_next_home {
    return Intl.message(
      'Find your next home with us',
      name: 'find_next_home',
      desc: '',
      args: [],
    );
  }

  /// `Search name, address...`
  String get search_name_address {
    return Intl.message(
      'Search name, address...',
      name: 'search_name_address',
      desc: '',
      args: [],
    );
  }

  /// `House, Apartment, Land, Room sharing...`
  String get property_types {
    return Intl.message(
      'House, Apartment, Land, Room sharing...',
      name: 'property_types',
      desc: '',
      args: [],
    );
  }

  /// `Found`
  String get found {
    return Intl.message('Found', name: 'found', desc: '', args: []);
  }

  /// `Listing`
  String get listing {
    return Intl.message('Listing', name: 'listing', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `No data`
  String get no_data {
    return Intl.message('No data', name: 'no_data', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `image not found`
  String get no_image {
    return Intl.message(
      'image not found',
      name: 'no_image',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Latest`
  String get latest {
    return Intl.message('Latest', name: 'latest', desc: '', args: []);
  }

  /// `Oldest`
  String get oldest {
    return Intl.message('Oldest', name: 'oldest', desc: '', args: []);
  }

  /// `Cheapest`
  String get cheapest {
    return Intl.message('Cheapest', name: 'cheapest', desc: '', args: []);
  }

  /// `Most expensive`
  String get most_expensive {
    return Intl.message(
      'Most expensive',
      name: 'most_expensive',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message('Bank', name: 'bank', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ja'),
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
