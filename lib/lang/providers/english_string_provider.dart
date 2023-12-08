import 'package:flutter/material.dart';

class EnglishStringProvider with ChangeNotifier {
  Map<String, String> englishStringMap = {
    "app-title": "Finance Manager",
    "register-nav-title": "Register",
    "name": "Name",
    "name-hint": "Type your name",
    "email": "Email",
    "email-hint": "Type your Email",
    "email-validate": "Please Enter Email",
    "password": "Password",
    "password-hint": "Type your password",
    "password-validate": "Please Enter Password",
    "confirm-password": "Confirm Password",
    "confirm-password-hint": "Retype your password",
    "reset-password-nav-title": "Reset Password",
    "forgot-password-nav-title": "Forgot Password",
    "otp-nav-title": "Enter OTP",
    "choose-language": "Choose Language",
    "profile": "Profile",
    "log-out": "Log Out",
    "version": "Version",
    "customer-service": "Customer Service",
    "contact-us": "Contact Us",
    "welcome": "Welcome,",
    "home": "Home",
    "back": "Back",
    "next": "Next",
    "type-your-email": "Type your email",
    "type-password": "Type Password",
    "forget-password": "Forget password?",
    "login": "Login",
    "dont-have-account": "Don’t have an account?",
    "sign-up": "Sign up",
    "or": "Or",
    "register": "Register",
    "name-cannot-be-empty": "Name cannot be empty",
    "email-cannot-be-empty": "Email cannot be empty",
    "invalid-email-format": "Invalid email format",
    "password-cannot-be-empty": "Password cannot be empty",
    "password-min-6-char": "Password minimum 6 characters",
    "password-conf-not-match": "Password confirmation is not match",
    "done": "Done",
    "okay": "Okay",
    "about": "About",
    "contact": "Contact",
    "camera": "Camera",
    "gallery": "Gallery",
    "success": "Success",
    "error": "Error",
    "share-app": "Share App",
    "image-source": "Select Image Source",
    "change-picture": "Change Picture",
    "excellent": "Excellent",
    "you": "You",
    "expenses": "Expenses",
    "income": "Income",
    "transactions": "Transactions",
    "goals": "Goals",
    "accounts": "Accounts",
    "target": "Target",
    "loans": "Loans",
    "goals-tracker": "Goals Tracker",
    "create-goal": "Create Goal",
    "save": "Save",
    "submit": "Submit",
    "goal-name": "Goal Name",
    "goal-name-validate": "Please Enter Goal Name",
    "goal-amount": "Goal Amount",
    "goal": "Goal",
    "amount-summary": "Amount Sumary",
    "achieved": "Achieved",
    "achieved-amount": "Achieved Amount",
    "goal-amount-validate": "Please Enter Goal Amount",
    "goal-start-date": "Goal Start Date",
    "goal-target-date": "Goal Target Date",
    "currency": "Currency",
    "currency-validate": "Please Enter Currency",
    "select-currency": "Select Currency",
    "goal-details": "Goal Details",
    "goal-deposits": "Goal Deposits",
    "deposits": "Deposits",
    "start-date": "Start Date",
    "end-date": "End Date",
    "days-left": "Days Left",
    "deposit-amount": "Deposit Amount",
    "deposit-amount-validate": "Please Enter Deposit Amount",
    "deposit-date": "Deposit Date",
    "close": "Close",
    "summary": "Summary",
    "budgets": "Budgets",
    "settings": "Settings",
    "currencies": "Currencies",
    "choose-currency": "Choose Currency",
    "expense-types": "Expense Types",
    "payments": "Payments",
    "fees": "Fees",
    "bills": "Bills",
    "shopping": "Shopping",
    "grocery": "Grocery",
    "household": "Household",
    "travel": "Travel",
    "fuel": "Fuel",
    "hotel": "Hotel",
    "food": "Food",
    "online-orders": "Online Orders",
    "electronics": "Electronics",
    "entertainment": "Entertaimnent",
    "subscription": "Subscription",
    "personal-care": "Personal Care",
    "medicines": "Medicines",
    "hospital": "Hospital",
    "insurances": "Insurances",
    "vehicle-insurance": "Vehicle Insurance",
    "medical-insurance": "Medical Insurance",
    "assets": "Assets",
    "savings": "Savings",
    "bank-account": "Bank Account",
    "cash": "Cash",
    "credit-card": "Credit Card",
    "debit-card": "Debit Card",
    "wallet": "Wallet",
    "transfer": "Transfer",
    "debit": "Debit",
    "credit": "Credit",
    "add": "Add",
    "remove": "Remove",
    "deposit": "Deposit",
    "withdraw": "Withdraw",
    "settle": "Settle",
    "borrow": "Borrow",
    "loan": "Loan",
    "payment-date": "Payment Date",
    "withdrawal-date": "Withdrwal Date",
    "settled-date": "Settled Date",
    "settled": "Settled",
    "paid": "Paid",
    "pending": "Pending",
    "add-currencies": "Add Currencies",
    "currency-name": "Currency Name",
    "currency-short-name": "Currency Short Name",
    "currency-icon": "Currency Icon",
    "add-expense-type": "Add Expense Type",
    "expenses-type": "Expenses Type",
    "expense-type-name": "Expense Type Name",
    "expense-type-desc": "Expense Type Desc",
    "expense-type-icon": "Expense Type Icon",
    "expense-type-name-validate": "Please Enter Expense Type Name",
    "expense-type-desc-validate": "Please Enter Expense Type Desc",
    "expense-type-icon-validate": "Please Enter Expense Type Icon",
    "create-expenses": "Create Expenses",
    "expense-name": "Expense Name",
    "expense-name-validate": "Please Enter Expense Name",
    "expense-amount": "Expense Amount",
    "expense-amount-validate": "Please Enter Expense Amount",
    "expense-date": "Expense Date",
    "expense-note": "Expense Note",
    "create-account": "Create Account",
    "account-name": "Account Name",
    "account-name-validate": "Please Enter Account Name",
    "account-types": "Account Types",
    "select-account-type": "Select Account Type",
    "add-account-type": "Add Account Type",
    "account-type-desc": "Account Type Desc",
    "account-type-icon": "Account Type Icon",
    "account-balance": "Account Balance",
    "create-income": "Add Income",
    "income-name": "Income Name",
    "income-amount": "Income Amount",
    "income-amount-validate": "Please Enter Income Amount",
    "income-date": "Income Date",
    "income-note": "Income Note",
    "create-trans": "Add Transaction",
    "trans-name": "Transaction Name",
    "trans-amount": "Transaction Amount",
    "trans-amount-validate": "Please Enter Transaction Amount",
    "trans-date": "Transaction Date",
    "trans-note": "Transaction Note",
    "trans-type": "Transaction Type",
  };

  Map<String, String> get fetchEnglishStringMap {
    return englishStringMap;
  }
}
