import 'dart:io';

class Car {
  String name;
  double price;

  Car(this.name, this.price);

  void changePrice(double newPrice) {
    price = newPrice;
    print("The price of $name has been updated to \$${price.toStringAsFixed(2)}.");
  }
}

class Person {
  String name;
  List<Car> ownedCars = [];
  double moneyLeft;

  Person(this.name, this.moneyLeft);

  void buyCar(Car car) {
    if (moneyLeft >= car.price) {
      ownedCars.add(car);
      moneyLeft -= car.price;
      print("$name bought the car ${car.name} for \$${car.price.toStringAsFixed(2)}.");
      print("$name now has \$${moneyLeft.toStringAsFixed(2)} left.");
    } else {
      print("$name does not have enough money to buy ${car.name}.");
    }
  }

  void sellCar(Car car) {
    if (ownedCars.contains(car)) {
      ownedCars.remove(car);
      moneyLeft += car.price;
      print("$name sold the car ${car.name} for \$${car.price.toStringAsFixed(2)}.");
      print("$name now has \$${moneyLeft.toStringAsFixed(2)}.");
    } else {
      print("$name does not own the car ${car.name}.");
    }
  }
}

void main() {
  List<Car> availableCars = [];

  print("Welcome to the Car Shop!");

  stdout.write("Enter your name: ");
  String? personName = stdin.readLineSync();

  stdout.write("Enter your starting money: ");
  double money = double.parse(stdin.readLineSync()!);

  Person user = Person(personName ?? "Unknown", money);

  stdout.write("How many cars do you want to add to the shop? ");
  int carCount = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < carCount; i++) {
    stdout.write("Enter name of car ${i + 1}: ");
    String? carName = stdin.readLineSync();

    stdout.write("Enter price of $carName: ");
    double carPrice = double.parse(stdin.readLineSync()!);

    availableCars.add(Car(carName ?? "Unnamed", carPrice));
  }

  bool running = true;

  while (running) {
    print("\n==========================");
    print("1. View available cars");
    print("2. Buy a car");
    print("3. Sell a car");
    print("4. Change car price");
    print("5. View owned cars");
    print("6. View balance");
    print("0. Exit");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        if (availableCars.isEmpty) {
          print("No cars available.");
        } else {
          print("Available cars:");
          for (int i = 0; i < availableCars.length; i++) {
            print(
                "${i + 1}. ${availableCars[i].name} - \$${availableCars[i].price.toStringAsFixed(2)}");
          }
        }
        break;

      case "2":
        if (availableCars.isEmpty) {
          print("No cars available to buy.");
        } else {
          print("Select the number of the car to buy:");
          for (int i = 0; i < availableCars.length; i++) {
            print(
                "${i + 1}. ${availableCars[i].name} - \$${availableCars[i].price.toStringAsFixed(2)}");
          }
          stdout.write("Enter number: ");
          int buyIndex = int.parse(stdin.readLineSync()!) - 1;
          if (buyIndex >= 0 && buyIndex < availableCars.length) {
            user.buyCar(availableCars[buyIndex]);
          } else {
            print("Invalid selection.");
          }
        }
        break;

      case "3":
        if (user.ownedCars.isEmpty) {
          print("You don't own any cars.");
        } else {
          print("Select the number of the car to sell:");
          for (int i = 0; i < user.ownedCars.length; i++) {
            print(
                "${i + 1}. ${user.ownedCars[i].name} - \$${user.ownedCars[i].price.toStringAsFixed(2)}");
          }
          stdout.write("Enter number: ");
          int sellIndex = int.parse(stdin.readLineSync()!) - 1;
          if (sellIndex >= 0 && sellIndex < user.ownedCars.length) {
            Car soldCar = user.ownedCars[sellIndex];
            user.sellCar(soldCar);
          } else {
            print("Invalid selection.");
          }
        }
        break;

      case "4":
        if (availableCars.isEmpty) {
          print("No cars available to change price.");
        } else {
          print("Select the number of the car to change its price:");
          for (int i = 0; i < availableCars.length; i++) {
            print(
                "${i + 1}. ${availableCars[i].name} - \$${availableCars[i].price.toStringAsFixed(2)}");
          }
          stdout.write("Enter number: ");
          int priceIndex = int.parse(stdin.readLineSync()!) - 1;
          if (priceIndex >= 0 && priceIndex < availableCars.length) {
            stdout.write("Enter new price: ");
            double newPrice = double.parse(stdin.readLineSync()!);
            availableCars[priceIndex].changePrice(newPrice);
          } else {
            print("Invalid selection.");
          }
        }
        break;

      case "5":
        if (user.ownedCars.isEmpty) {
          print("You don't own any cars.");
        } else {
          print("Your cars:");
          for (int i = 0; i < user.ownedCars.length; i++) {
            print(
                "${i + 1}. ${user.ownedCars[i].name} - \$${user.ownedCars[i].price.toStringAsFixed(2)}");
          }
        }
        break;

      case "6":
        print("${user.name}, you have \$${user.moneyLeft.toStringAsFixed(2)}.");
        break;

      case "0":
        running = false;
        print("Goodbye!");
        break;

      default:
        print("Invalid option. Try again.");
    }
  }
}
