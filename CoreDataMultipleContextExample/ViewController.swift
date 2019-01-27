//
//  ViewController.swift
//  CoreDataMultipleContextExample
//
//  Created by Siddhant Mishra on 27/01/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let parentContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    
    @IBAction func saveDataBtn(_ sender: Any) {
        //Parse a JSON and store response 
        var EmpArray = [String:String]()
        EmpArray["Name"] = "Siddhant"
        EmpArray["Dept"] = "Admin"
        EmpArray["Id"] = "12"
        saveData(array: EmpArray)

        
    }
    override func viewDidLoad() {
        childContext.parent = parentContext
        super.viewDidLoad()
    }
    
    func saveData(array:[String:String])  {
        childContext.perform{
            let entityDesc = NSEntityDescription.entity(forEntityName: "EmpDetail", in:self.childContext)
            let employee = NSManagedObject(entity: entityDesc!, insertInto: self.childContext)
            employee .setValue(array["Name"], forKey: "name")
            employee .setValue(array["Dept"], forKey: "dept")
            employee .setValue(array["Id"], forKey: "id")
            
            do{
                try self.childContext.save()
                self.parentContext.performAndWait {
                    do {
                        try self.parentContext.save()
                    } catch {
                        fatalError("Unable to save:\(error)")
                    }
                }
            } catch {
                fatalError("Unable to save,\(error)")
            }
            
        }
    }
    
    /*func fetchDta(entity:String) -> [String:String] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do{
            let result = try self.parentContext.fetch(request) as! [EmpDetail]
            var finalRes = [String:String]()
            finalRes["Name"] = result[0].name
            finalRes["Dept"] = result[0].dept
            finalRes["UID"] = result[0].id
            return finalRes
        } catch {
            fatalError("Error fetching record,\(error)")
        }
    }*/
}

