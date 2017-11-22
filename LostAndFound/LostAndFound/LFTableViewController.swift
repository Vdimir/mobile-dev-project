//
//  LFTableViewController.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

class LFTableViewController: UITableViewController {

    var items = [LFItemProtocol]()
    
    var lostItems = [LFItemProtocol]()
    
    @IBOutlet weak var lostFoundToggle: UISegmentedControl!
    
    func updateToggle() {
        title = lostFoundToggle.titleForSegment(at: lostFoundToggle.selectedSegmentIndex)
        if lostFoundToggle.selectedSegmentIndex == 0 {
            items = lostItems.filter { $0.type == .Lost}
        } else {
            items = lostItems.filter { $0.type == .Found}
        }
        self.tableView.reloadData()
    }
    @IBAction func lostFoundToggleChanged(_ sender: Any) {
        updateToggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lostItems.append(LFItem(title: "LostItem1", desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", type: .Lost))
        
        lostItems.append(LFItem(title: "LostItem2", desc: "Значимость этих проблем настолько очевидна, что сложившаяся структура организации влечет за собой процесс внедрения и модернизации позиций, занимаемых участниками в отношении поставленных задач. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности требуют определения и уточнения направлений прогрессивного развития.", type: .Lost))
        
        
        lostItems.append(LFItem(title: "FloudItem0", desc: "Таким образом консультация с широким активом обеспечивает широкому кругу (специалистов) участие в формировании направлений прогрессивного развития. Не следует, однако забывать, что новая модель организационной деятельности способствует подготовки и реализации систем массового участия.", type: .Found))
        
        updateToggle()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_lostfound", for: indexPath)
        if indexPath.row >= items.count {
            return cell
        }
        
        if let c = cell as? LFItemTableViewCell {
            let item = items[indexPath.row]
            c.item = item
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /**/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "show_lostfound_datail" {
            let dest = (segue.destination as? LFDetailsViewController);
            dest?.item = items[self.tableView.indexPathForSelectedRow!.row]
        }
        
    }
    /**/

}
