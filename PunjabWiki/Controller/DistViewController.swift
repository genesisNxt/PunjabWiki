//
//  ViewController.swift
//  PunjabWiki
//
//  Created by PARMJIT SINGH KHATTRA on 19/7/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
import CoreData
class DistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let const = Constant()
    var dist = [District]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadDist()
    }
    
    // MARK:- addDist
    @IBAction func addDist(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Dist", message: "Punjab District", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newDistrict = District(context: self.context)
            newDistrict.distName = textField.text!
            newDistrict.done = false
            self.dist.append(newDistrict)
            self.saveDist()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "District Name"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    // MARK:- saveDist
    func saveDist(){
        do {
            try context.save()
        } catch {
            print("Error\(error)")
        }
        tableView.reloadData()
    }
    // MARK:- loadDist
    func loadDist(){
        let request: NSFetchRequest<District> = District.fetchRequest()
        do {
           dist = try context.fetch(request)
        } catch {
            print("Error Loading\(error)")
        }
    }
}
// MARK:- UITableViewDataSource
extension DistViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: const.distCell, for: indexPath)
        cell.textLabel?.text = dist[indexPath.row].distName
        return cell
    }
}
// MARK:- UITableViewDelegate
extension DistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        context.delete(dist[indexPath.row])
//        dist.remove(at: indexPath.row)
//        saveDist()
        performSegue(withIdentifier: const.citySegue, sender: self)
    }
}

