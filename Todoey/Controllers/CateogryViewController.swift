//
//  CateogryViewController.swift
//  Todoey
//
//  Created by Kaung Htet Lin on 24/06/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CateogryViewController: UITableViewController {
    
    var catArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier,for: indexPath)
        
        let cat = catArray[indexPath.row]
        cell.textLabel?.text = cat.name
        
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.itemIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = catArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Cateogry", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Add Category", style: .default) { (action) in
            if let catName = textField.text {
                if catName.count > 0 {
                    
                    let newCat = Category(context: self.context)
                    newCat.name = catName
                    self.catArray.append(newCat)
                    self.saveCategory()
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
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("error in saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Loading Cateogry
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            catArray = try context.fetch(request)
        } catch {
            print("Error in fetching category \(error)")
        }
        tableView.reloadData()
    }
}
