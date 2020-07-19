//
//  CityViewController.swift
//  PunjabWiki
//
//  Created by PARMJIT SINGH KHATTRA on 19/7/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
import CoreData
class CityViewController: UIViewController {

    
    var city = [City]()
    let const = Constant()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCity()
    }
    
    // MARK:- addCity Methods
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "City Name", message: "Punjab City", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCity = City(context: self.context)
            newCity.cityName = textField.text!
            newCity.done = false
            self.city.append(newCity)
            self.saveCity()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "City Name"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    // MARK:- saveCity Methods
    func saveCity(){
        do {
            try context.save()
        } catch  {
            print("Error Saving\(error)")
        }
        tableView.reloadData()
    }
    // MARK:- loadCity Methods
    func loadCity(){
        let request: NSFetchRequest<City> = City.fetchRequest()
        do {
           city = try context.fetch(request)
        } catch {
            print("Error Loading\(error)")
        }
        
    }
}
// MARK:- UItableView DataSource
extension CityViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: const.cityCell, for: indexPath)
        cell.textLabel?.text = city[indexPath.row].cityName
        return cell
    }
}
// MARK:- UItableView Delegate
extension CityViewController: UITableViewDelegate{
    
}
