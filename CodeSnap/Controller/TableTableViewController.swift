//
//  TableTableViewController.swift
//  CodeSnap
//
//  Created by Samuel Kyu-Seo Lee on 12/13/19.
//  Copyright © 2019 Samuel Kyu-Seo Lee. All rights reserved.
//



import UIKit

class TableTableViewController: UITableViewController{
    let singleton = SavedCodeDataModel.singleton
    var editIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.title = "History"
        print("coming into table view");
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleton.numSavedCodes()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        if let label = cell.textLabel {
            if let savedCode = singleton.savedCode(at: indexPath.row) {
                label.text = savedCode.title
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
        performSegue(withIdentifier: "goToEditViewController", sender: self)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            singleton.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        singleton.rearrageSavedCodes(from: fromIndexPath.row, to: to.row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    //Before moving forward, we must pass inthe edit index and the tableview so we know what to edit and to update after an edit is made
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "goToEditViewController", let vc = segue.destination as? EditViewController {
                if let index = editIndex {
                    vc.editIndex = index
                    vc.tableView = tableView
                }
           }
      }

}

//import UIKit
//
//class TableTableViewController: UITableViewController{
//    let singleton = SavedCodeDataModel.singleton
//    var editIndex:Int?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
//        self.navigationItem.title = "History"
//    }
//
//    override func viewWillAppear(_ animated:Bool) {
//        super.viewWillAppear(animated)
//        tableView?.reloadData()
//    }
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return singleton.numSavedCodes()
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
//
//        if let label = cell.textLabel {
//            if let savedCode = singleton.savedCode(at: indexPath.row) {
//                label.text = savedCode.title
//            }
//        }
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        editIndex = indexPath.row
//        performSegue(withIdentifier: "goToEditViewController", sender: self)
//    }
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            singleton.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
//
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        singleton.rearrageSavedCodes(from: fromIndexPath.row, to: to.row)
//    }
//
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//    //Before moving forward, we must pass inthe edit index and the tableview so we know what to edit and to update after an edit is made
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//              if segue.identifier == "goToEditViewController", let vc = segue.destination as? EditViewController {
//                if let index = editIndex {
//                    vc.editIndex = index
//                    vc.tableView = tableView
//                }
//           }
//      }
//
//}
