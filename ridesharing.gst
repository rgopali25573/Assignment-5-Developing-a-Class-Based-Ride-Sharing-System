"Define the base class Ride"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> newRideWithID: anID pickup: pickup dropoff: dropoff distance: dist [
        ^self new initializeWithID: anID pickup: pickup dropoff: dropoff distance: dist.
    ]

    Ride >> initializeWithID: anID pickup: pickup dropoff: dropoff distance: dist [
        rideID := anID.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
    ]

    Ride >> fare [
        ^ 0. "To be overridden by subclasses"
    ]

    Ride >> rideDetails [
        ^ 'Ride ID: ', rideID asString, ' | Pickup: ', pickupLocation, ' | Dropoff: ', dropoffLocation, ' | Distance: ', distance asString.
    ]
]

"Define StandardRide subclass"
Ride subclass: StandardRide [
    StandardRide >> fare [
        ^ distance * 2.0.
    ]

    StandardRide >> rideDetails [
        ^ (super rideDetails), ' | Type: Standard | Fare: $', (self fare) asString.
    ]
]

"Define PremiumRide subclass"
Ride subclass: PremiumRide [
    PremiumRide >> fare [
        ^ distance * 3.5.
    ]

    PremiumRide >> rideDetails [
        ^ (super rideDetails), ' | Type: Premium | Fare: $', (self fare) asString.
    ]
]

"Define the Driver class"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> newDriverWithID: anID name: driverName rating: driverRating [
        ^ self new initializeWithID: anID name: driverName rating: driverRating.
    ]

    Driver >> initializeWithID: anID name: driverName rating: driverRating [
        driverID := anID.
        name := driverName.
        rating := driverRating.
        assignedRides := OrderedCollection new.
    ]

    Driver >> addRide: aRide [
        assignedRides add: aRide.
    ]

    Driver >> getDriverInfo [
        | rideInfo |
        rideInfo := ''.
        assignedRides do: [:ride | rideInfo := rideInfo, ride rideDetails, ' || '].
        ^ 'Driver ID: ', driverID asString, ' | Name: ', name, ' | Rating: ', rating asString, ' | Assigned Rides: ', rideInfo.
    ]
]

"Define the Rider class"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> newRiderWithID: anID name: riderName [
        ^ self new initializeWithID: anID name: riderName.
    ]

    Rider >> initializeWithID: anID name: riderName [
        riderID := anID.
        name := riderName.
        requestedRides := OrderedCollection new.
    ]

    Rider >> requestRide: aRide [
        requestedRides add: aRide.
    ]

    Rider >> viewRides [
        | rideInfo |
        rideInfo := ''.
        requestedRides do: [:ride | rideInfo := rideInfo, ride rideDetails, ' || '].
        ^ 'Rider ID: ', riderID asString, ' | Name: ', name, ' | Requested Rides: ', rideInfo.
    ]
]

"Testing the Ride Sharing System"
| ride1 ride2 driver rider |

ride1 := StandardRide newRideWithID: 1 pickup: 'Downtown' dropoff: 'Airport' distance: 10.
ride2 := PremiumRide newRideWithID: 2 pickup: 'Mall' dropoff: 'Hotel' distance: 5.

driver := Driver newDriverWithID: 101 name: 'Alice' rating: 4.9.
driver addRide: ride1.
driver addRide: ride2.

rider := Rider newRiderWithID: 201 name: 'Bob'.
rider requestRide: ride1.
rider requestRide: ride2.

Transcript show: (driver getDriverInfo); cr.
Transcript show: (rider viewRides); cr.
