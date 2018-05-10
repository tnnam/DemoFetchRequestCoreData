//
//  PeopleTableViewController.swift
//  DemoFetchRequestCoreData
//
//  Created by Tran Ngoc Nam on 5/9/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit
import CoreData

class PeopleTableViewController: UITableViewController {
    
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var footerView: UIView!
    var hasNodata: Bool = true {
        didSet {
            tableView.tableFooterView = hasNodata ? noDataView : footerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = DataService.shared.people.count == 0 ? noDataView : footerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataService.shared.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = DataService.shared.people[indexPath.row].name
        cell.detailTextLabel?.text = "Age :\(DataService.shared.people[indexPath.row].age)"
        cell.imageView?.image = DataService.shared.people[indexPath.row].photo as? UIImage
        return cell
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            guard let index = tableView.indexPathForSelectedRow else { return }
            detailViewController.index = index.row
    }
    
    // MARK: Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.shared.removeData(from: indexPath)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
        hasNodata = DataService.shared.people.count == 0
    }
    
    
}
