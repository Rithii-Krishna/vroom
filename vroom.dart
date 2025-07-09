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
  Car car1 = Car("Toyota Camry", 15000);
  Car car2 = Car("Honda Civic", 12000);
  Car car3 = Car("Tesla Model 3", 35000);
  Person alice = Person("Alice", 40000);
  alice.buyCar(car1);
  alice.buyCar(car3);
  alice.buyCar(car2);
  alice.sellCar(car3);
  car2.changePrice(11000);
  alice.buyCar(car2);
}
