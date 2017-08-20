//
//  ViewController.swift
//  PersistenceEngine
//
//  Created by Timothy Bowers on 08/19/2017.
//  Copyright (c) 2017 Timothy Bowers. All rights reserved.
//

import UIKit
import PersistenceEngine

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistenceStore = PersistenceEngine()
        
        persistenceStore.clear(entity: "TestEntity1")
        persistenceStore.clear(entity: "TestEntity2")
        persistenceStore.clear(entity: "TestEntity3")
        
        persistenceStore.printCoreData(entity: "TestEntity1")
        persistenceStore.printCoreData(entity: "TestEntity2")
        persistenceStore.printCoreData(entity: "TestEntity3")
        
        var myDict1 = [String : Any]()
        myDict1["field1"] = "testing"
        myDict1["field2"] = "dictionaries"
        myDict1["field3"] = "834632649391647"
        myDict1["field4"] = 2147483647
        myDict1["field5"] = [5, 6, 7, 8, 9]
        myDict1["field6"] = CGRect(x: 0, y: 0, width: 50, height: 70)
        myDict1["field7"] = 463248370.000043857892420006
        
        var myDict2 = [String : Any]()
        myDict2["field1"] = "abcdef"
        myDict2["field2"] = "1234567890"
        myDict2["field3"] = "A B C D E"
        myDict2["field4"] = 5566
        myDict2["field5"] = ["0", 7, "7", 7.2, 4, "f"]
        myDict2["field6"] = CGRect(x: 1, y: 1, width: 10, height: 10)
        myDict2["field7"] = 3333333.000400040004004
        myDict2["field8"] = myDict1
        
        persistenceStore.insert(dictionary: myDict1, intoEntity: "TestEntity1")
        persistenceStore.insert(dictionary: myDict2, intoEntity: "TestEntity2")
        
        persistenceStore.printCoreData(entity: "TestEntity1")
        persistenceStore.printCoreData(entity: "TestEntity2")
        
        
        // Load stored dictionaries from Core Data in local variable and print it out
        let myNewDictArray = persistenceStore.dictionaryFrom(entity: "TestEntity2")
        
        print()
        print("------[ Printing dictionaries start ]-----");
        print("amount of dictionaries = ", myNewDictArray.count)
        
        for (index, item) in myNewDictArray.enumerated() {
            
            print("index = ", index)
            
            print("dictionary = ", item)
            
        }
        print("------[ Printing dictionaries stop ]-----");
        print()
        
    }
    
}
