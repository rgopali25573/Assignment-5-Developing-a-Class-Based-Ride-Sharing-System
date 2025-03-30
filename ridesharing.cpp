#include <iostream>
#include <vector>
#include <memory>
using namespace std;

// Base Ride Class
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;
public:
    Ride(int id, string pickup, string dropoff, double dist) : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}
    virtual double fare() const = 0; // Pure virtual function for polymorphism
    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID << ", Pickup: " << pickupLocation << ", Dropoff: " << dropoffLocation << ", Distance: " << distance << " miles" << endl;
    }
    virtual ~Ride() {}
};

// StandardRide subclass
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double fare() const override {
        return distance * 2.0; // Standard fare rate per mile
    }
    void rideDetails() const override {
        Ride::rideDetails();
        cout << "Ride Type: Standard, Fare: $" << fare() << endl;
    }
};

// PremiumRide subclass
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double fare() const override {
        return distance * 3.5; // Premium fare rate per mile
    }
    void rideDetails() const override {
        Ride::rideDetails();
        cout << "Ride Type: Premium, Fare: $" << fare() << endl;
    }
};

// Driver Class
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<shared_ptr<Ride>> assignedRides;
public:
    Driver(int id, string driverName, double driverRating) : driverID(id), name(driverName), rating(driverRating) {}
    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }
    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << ", Name: " << name << ", Rating: " << rating << endl;
        cout << "Assigned Rides: " << endl;
        for (const auto& ride : assignedRides) {
            ride->rideDetails();
        }
    }
};

// Rider Class
class Rider {
private:
    int riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides;
public:
    Rider(int id, string riderName) : riderID(id), name(riderName) {}
    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }
    void viewRides() const {
        cout << "Rider ID: " << riderID << ", Name: " << name << endl;
        cout << "Requested Rides: " << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
        }
    }
};

int main() {
    shared_ptr<Ride> ride1 = make_shared<StandardRide>(1, "Downtown", "Airport", 10.0);
    shared_ptr<Ride> ride2 = make_shared<PremiumRide>(2, "Mall", "Hotel", 5.0);
    
    Driver driver(101, "Alice", 4.9);
    driver.addRide(ride1);
    driver.addRide(ride2);
    
    Rider rider(201, "Bob");
    rider.requestRide(ride1);
    rider.requestRide(ride2);
    
    cout << "--- Driver Info ---" << endl;
    driver.getDriverInfo();
    
    cout << "\n--- Rider Info ---" << endl;
    rider.viewRides();
    
    return 0;
}