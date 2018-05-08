//
//  ViewController.swift
//  PersistenceEngine
//
//  Created by Timothy Bowers on 08/19/2017.
//  Copyright (c) 2017 Timothy Bowers. All rights reserved.
//

import UIKit
import PersistenceEngine


// ** ----------[ Example implementation for a simple struct containing only 1 field ]-------------------------------------------------
struct Contact {
  public var name: String

  init(name: String) {
    self.name = name
  }

  // Import struct from Data
  init(data: Data) {
    let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary
    self.name = dictionary["name"] as! String
  }

  // Export struct as dictionary
  var dictionaryRepresentation: [String: Any] {
    return [
      "name" : self.name
    ]
  }

  // Insert the struct into a dictionary & encode that dictionary into Data
  public func encode() -> Data {
    let dictionary = NSMutableDictionary()
    dictionary["name"] = self.name
    return NSKeyedArchiver.archivedData(withRootObject: dictionary)
  }
}
// ** -----------------------------------------------------------


// ** ----------------[ Example implementation for a COMPLEX struct containing lots of fields including the above struct as a field ]-------------------------------------------
struct User {
  public var id: Int
  public var active: Bool
  public var name: String
  public var date: Date
  public var dateArray: [Date]
  public var friend: [Contact]

  init(id: Int, active: Bool, name: String, date: Date, dateArray: [Date], friend: [Contact]) {
    self.id = id
    self.active = active
    self.name = name
    self.date = date
    self.dateArray = dateArray
    self.friend = friend
  }

  init(data: Data) {
    let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary
    self.id = dictionary["id"] as! Int
    self.active = dictionary["active"] as! Bool
    self.name = dictionary["name"] as! String
    self.date = dictionary["date"] as! Date
    self.dateArray = dictionary["dateArray"] as! [Date]

    // decode [Data] to [Contact]
    let dataArray = dictionary["friend"] as! [Data]
    self.friend = dataArray.map { Contact(data: $0) }
  }

  // Export as dictionary
  var dictionaryRepresentation: [String: Any] {
    return [
      "id" : self.id,
      "active" : self.active,
      "name" : self.name,
      "date" : self.date,
      "dateArray" : self.dateArray,
      "friend" : self.friend
    ]
  }

  func encode() -> Data {
    let dictionary = NSMutableDictionary()
    dictionary["id"] = self.id
    dictionary["active"] = self.active
    dictionary["name"] = self.name
    dictionary["date"] = self.date
    dictionary["dateArray"] = self.dateArray

    // encode [Contact] to [Data]
    dictionary["friend"] = self.friend.map { $0.encode() }

    return NSKeyedArchiver.archivedData(withRootObject: dictionary)
  }
}
// ** -----------------------------------------------------------

// ** --------------[ Example implementation for a simple struct containing only 1 ARRAY field ]---------------------------------------------

struct Users {
  var userArray: [User]

  init(userArray: [User]) {
    self.userArray = userArray
  }

  init(data: Data) {
    let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary

    // decode [Data] to [User]
    let dataArray = dictionary["userArray"] as! [Data]
    self.userArray = dataArray.map { User(data: $0) }
  }

  // Export as dictionary
  var dictionaryRepresentation: [String: Any] {
    return [
      "usersArray" : self.userArray
    ]
  }

  public func encode() -> Data {
    let dictionary = NSMutableDictionary()

    // encode [Folder] to [Data]
    dictionary["userArray"] = self.userArray.map { $0.encode() }

    return NSKeyedArchiver.archivedData(withRootObject: dictionary)
  }

}
// ** -----------------------------------------------------------

// CoreData DB (PersistenceEngineDB.xcdatamodeld) has been created with 3 entities, each with only 1 field (coredictionary of type Transformable)

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // First initialise the DB engine which loads CoreData DB into memory.
    let persistenceStore = PersistenceEngine()

    // Wipe the 3 entities clean so we can start with a clean DB.
    persistenceStore.clear(entity: "TestEntity1")
    persistenceStore.clear(entity: "TestEntity2")
    persistenceStore.clear(entity: "TestEntity3")

    // Print them so we can see they are empty.
    persistenceStore.printCoreData(entity: "TestEntity1")
    persistenceStore.printCoreData(entity: "TestEntity2")
    persistenceStore.printCoreData(entity: "TestEntity3")




    // Setup structs with sample data ----------------------------------------------------------------------------------------------------------
    let today1 = Date()
    let today2 = Date()
    let myFriend1 = Contact(name: "friendName1")
    let myFriend2 = Contact(name: "friendName2")
    let myUser1 = User(id: 1, active: true, name: "name1", date: today1, dateArray: [today1, today2], friend: [myFriend1, myFriend2])
    let myUser2 = User(id: 2, active: true, name: "name2", date: today1, dateArray: [today1, today2], friend: [myFriend1, myFriend2])
    let myUserList = Users(userArray: [myUser1, myUser2])
    //------------------------------------------------------------------------------------------------------------------------------------------





    // SAVE our struct to CORE DATA ----------------------------------------------------------------
    // Put our root struct into a dictionary by converting the root struct to `Data` type
    var myDict1 = [String : Any]()
    myDict1["myUsersArray"] = myUserList.encode()  // Note the name we use here "myUsersArray" - We need this name when retrieving back from Core Data at the end.

    // Insert our dictionary into Core Data - Note: we can insert multiple dictionaries in this same entity and get them all back as an ARRAY
    persistenceStore.insert(dictionary: myDict1, intoEntity: "TestEntity1")

    // Print out what is inside Core Data, to see what we have inserted.  (Should be a Dictionary with 1 field "myUsersArray", that contain a single DATA stream)
    persistenceStore.printCoreData(entity: "TestEntity1")
    //----------------------------------------------------------------------------------------------





    // LOAD our struct from CORE DATA ----------------------------------------------------------------
    // Load stored dictionaries from Core Data in local variable and print it out - Note this is an ARRAY of dictionaries, and not a single dictionary.
    let myNewDictArray = persistenceStore.dictionaryFrom(entity: "TestEntity1")

    print("\n------[ Printing dictionaries start ]--------------->");
    print("amount of dictionaries in Core Data = ", myNewDictArray.count)
    print("=============================================")
    for (index, item) in myNewDictArray.enumerated() {

      print("dictionary index number = ", index)

      print("dictionary = ", item)

      if let myUserListFromCoreData = item["myUsersArray"] as? Data {

        // MAGIC -------> This is where the magic happens!
        // The following line will transform the raw DATA into our Swift Struct. (Any sub-structs will recursively transform it's DATA into swift structs, etc, etc)
        let swiftUserStruct = Users(data: myUserListFromCoreData)

        print("\nSwift Struct as a Struct:\n-------------------------\n \(swiftUserStruct)\n")
        print("Swift Struct as a Dictionary:\n-----------------------------\n \(swiftUserStruct.dictionaryRepresentation)\n")
      }

    }
    print("<-----------------[ Printing dictionaries stop ]-----\n");

  }

}
