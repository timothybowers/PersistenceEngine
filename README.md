# PersistenceEngine

[![CI Status](http://img.shields.io/travis/TimothyBowers/PersistenceEngine.svg?style=flat)](https://travis-ci.org/TimothyBowers/PersistenceEngine)
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
`persistenceStore.insert(dictionary: myDict1, intoEntity: "TestEntity1")`

And read your dictionaries from Core Data using:
`let myNewDictArray = persistenceStore.dictionaryFrom(entity: "TestEntity1")`


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

## Author

Timothy S Bowers, timbigdev@gmail.com

## License

PersistenceEngine is available under the MIT license. See the LICENSE file for more info.
