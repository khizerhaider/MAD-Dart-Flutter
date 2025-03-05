// syed Muhammad Kizer Haider 474476
// Null Safety
import 'dart:io';

void main() {
  print("Enter your age:");

  try {
    String? input = stdin.readLineSync();
    
    if (input == null || input.trim().isEmpty) {
      print("Error: Age cannot be empty. Please enter a valid Age.");
      return;
    }

    int age = int.parse(input);

    if (age < 0 || age > 140) {
      print("Error: Please enter a valid age between 0 and 140.");
      return;
    }

    int yearsLeft = 100 - age;
    if (yearsLeft > 0) {
      print("You have $yearsLeft years left until you turn 100.");
    } else {
      print("You are already 100 years old or older!");
    }
  } catch (e) {
    print("Error: Invalid input. Please enter a valid number.");
  }
}