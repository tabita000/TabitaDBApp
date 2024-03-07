//
//  ViewController.swift
//  TabitaDBApp
//
//  Created by Tabita Sadiq on 3/7/24.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBAction func saveRecordButton(_ sender: UIButton) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterGuitarDescription.text, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print("Error saving data")
        }
        displayDataHere.text?.removeAll()
        enterGuitarDescription.text?.removeAll()
        fetchData()
    }
    
    @IBAction func deleteRecordButton(_ sender: UIButton) {
        let daleteItem = enterGuitarDescription.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == daleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch{
                print("Error deleting data")
            }
            displayDataHere.text?.removeAll()
            enterGuitarDescription.text?.removeAll()
            fetchData()
        }
    }
    
    
    @IBOutlet weak var enterGuitarDescription: UITextField!
    
    
    @IBOutlet weak var displayDataHere: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayDataHere.text?.removeAll()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                displayDataHere.text! += product
            }
        } catch {
            print("Error Retrieving Data")
        }
    }


}

