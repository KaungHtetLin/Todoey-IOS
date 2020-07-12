//
//  CateogryViewController.swift
//  Todoey
//
//  Created by Kaung Htet Lin on 24/06/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CateogryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var catArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier,for: indexPath)
        
        cell.textLabel?.text = catArray?[indexPath.row].name ?? "No Cateogry Added Yet"
        
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.itemIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = catArray?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Cateogry", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Category", style: .default) { (action) in
            if let catName = textField.text {
                if catName.count > 0 {
                    
                    let newCat = Category()
                    newCat.name = catName
                    self.save(category: newCat)
                }
            }
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Saving Cateogry
    func save(category : Category) {
        
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("error in saving data \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Loading Cateogry
    func loadCategory() {

        catArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
