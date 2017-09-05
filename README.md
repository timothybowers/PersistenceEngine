# PersistenceEngine

[![CI Status](http://img.shields.io/travis/timothybowers/PersistenceEngine.svg?style=flat)](https://travis-ci.org/timothybowers/PersistenceEngine)
[![Version](https://img.shields.io/cocoapods/v/PersistenceEngine.svg?style=flat)](http://cocoapods.org/pods/PersistenceEngine)
[![License](https://img.shields.io/cocoapods/l/PersistenceEngine.svg?style=flat)](http://cocoapods.org/pods/PersistenceEngine)
[![Platform](https://img.shields.io/cocoapods/p/PersistenceEngine.svg?style=flat)](http://cocoapods.org/pods/PersistenceEngine)

## PersistenceEngine

`PersistenceEngine` is built and maintained with &#10084;&#65039; by [Timothy S Bowers](https://github.com/timothybowers).

## About

Dictionaries <> Core Data

Making life easier to save and manage Dictionaries into Core Data for persistence.

Written 100% purely in Swift 3.0

Easily store your dictionaries in Core data using simple commands like:

`coreDataStore.insert(dictionary: myDict1, intoEntity: "TestEntity1")`

And read your dictionaries from Core Data using:

`let myNewDictArray = coreDataStore.dictionaryFrom(entity: "TestEntity1")`


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

- Xcode 8.0+
- iOS 10.0+
- Interoperability with Swift 3.0+

## Installation

PersistenceEngine is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PersistenceEngine"
```

## Quick-start Instructions

`Step 1:` Create a new file, of type: Data Model (Core Data) in your application folder (Main Bundle) and save it with the name `PersistenceEngineDB.xcdatamodeld`

`Step 2:` Open this new file and create a new entity with any name you like (Starting with a capital), e.g. `AirportsEntity`

`Step 3:` Create an attribute with the name `coredictionary` (all small letters) for each entity you add. Type must be `Transformable`

`Step 4:` Add import statement:
```swift
import PersistenceEngine
```

## Quick example usage:

`Step 5:` Initialise a new instance of PersistenceEngine: 
```swift
let store = PersistenceEngine()
```

`Step 6:` Create a dictionary: 
```swift
let airportsDictionary: [String: Any] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

`Step 7:` Save the dictionary to core data: (Note: you can insert multiple dictionaries here into the same Entity) 
```swift
store.insert(dictionary: airportsDictionary, intoEntity: "AirportsEntity")
```

`Step 8:` Load the dictionary from core data: (Note: you will receive an ARRAY of dictionaries here)
```swift
let restoredDictionaryArray = store.dictionaryFrom(entity: "AirportsEntity")
```



## Author

Timothy S Bowers, timbigdev@gmail.com

## License

PersistenceEngine is available under the MIT license. See the LICENSE file for more info.
