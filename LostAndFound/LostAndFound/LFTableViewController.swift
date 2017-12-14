//
//  LFTableViewController.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

import FirebaseDatabase

class LFTableViewController: UITableViewController, FirebaseDataDelegate {
    
    var fireObservers = NSMutableDictionary()

    var storage : [LFItem]?
    
    var fireSourceRef: DatabaseReference!
    
    @IBOutlet weak var lostFoundToggle: UISegmentedControl!
    
    func updateToggle() {
        
        title = lostFoundToggle.titleForSegment(at: lostFoundToggle.selectedSegmentIndex)
        if lostFoundToggle.selectedSegmentIndex == 0 {
            storage = storage?.filter { $0.type == .Lost}
        } else {
            storage = storage?.filter { $0.type == .Found}
        }
        self.tableView.reloadData()
    }
    
    @IBAction func lostFoundToggleChanged(_ sender: Any) {
        updateToggle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        refreshControl?.beginRefreshing()
        fireSourceRef.load(with: self.loadData(withSnapshot:))
        fireSourceRef.connect(delegate: self)
        
        updateToggle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        fireSourceRef.disconnect(delegate: self)
    }
    
    
    func loadData(withSnapshot snapshot: DataSnapshot) {
        print("loaded")
        
        var r = [LFItem]()
        
        for child in snapshot.children {
            if let note = LFItem.decode(fromSnapshot: child as! DataSnapshot) {
                r.append(note)
            }
        }
        storage = r
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = [LFItem]()
        fireSourceRef = FireWrapper.data.userData.child(LFItem.path)
        
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
        return storage?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_lostfound", for: indexPath)
        if indexPath.row >= storage?.count ?? 0 {
            return cell
        }
        
        if let c = cell as? LFItemTableViewCell {
            let item = storage![indexPath.row]
            c.item = item
        }
        
        return cell
    }
    
    
    
    func fireChildRemoved(withSnapshot snapshot: DataSnapshot) {
        print("removed")
        var removedIds = [IndexPath]()
        
        if let index = storage?.index(where: { $0.fireId == snapshot.key}) {
            removedIds.append(IndexPath(row: index, section: 0))
            storage?.remove(at: index)
        }
        tableView.deleteRows(at: removedIds, with: .automatic)
    }
    
    func fireChildAdded(withSnapshot snapshot: DataSnapshot) {
        guard storage?.index(where: {$0.fireId == snapshot.key}) == nil
            else { return }
        print("added")
        
        if let note = LFItem.decode(fromSnapshot: snapshot) {
            storage?.append(note)
//            tableView.insertRows(at: [IndexPath(row: storage!.count-1 , section:0)], with: .automatic)
        }
        updateToggle()
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = storage?[indexPath.row].fireId {
                fireSourceRef.child(id).removeValue()
            }
        }
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
            dest?.item = storage?[self.tableView.indexPathForSelectedRow!.row]
        }
        
    }
    /**/

}
