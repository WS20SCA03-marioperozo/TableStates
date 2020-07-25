//
//  StatesTableViewController.swift
//  TableStates
//
//  Created by Mario Perozo on 7/22/20.
//  Copyright © 2020 Mario Perozo. All rights reserved.
//

import UIKit;
import SafariServices;

class StatesTableViewController: UITableViewController {
    
    var zones: [[String]] = [   //The model is an array of 5 arrays.

        //EST: Eastern Standard Time
        [
            "Alabama",
            "Connecticut",
            "Delaware",
            "Florida",
            "Georgia",
            "Indiana",
            "Kentucky",
            "Maine",
            "Maryland",
            "Massachusetts",
            "Michigan",
            "New Hampshire",
            "New Jersey",
            "New York",
            "North Carolina",
            "Ohio",
            "Pennsylvania",
            "Rhode Island",
            "South Carolina",
            "Tennessee",
            "Vermont",
            "Virginia",
            "West Virginia"
        ],

        //CST: Central Standard Time
        [
            "Arkansas",
            "Illinois",
            "Iowa",
            "Kansas",
            "Louisiana",
            "Minnesota",
            "Mississippi",
            "Missouri",
            "Nebraska",
            "North Dakota",
            "Oklahoma",
            "South Dakota",
            "Texas",
            "Wisconsin"
        ],

        //MST: Mountain Standard Time
        [
            "Arizona",
            "Colorado",
            "Idaho",
            "Montana",
            "New Mexico",
            "Utah",
            "Wyoming"
        ],

        //PST: Pacific Standard Time
        [
            "California",
            "Nevada",
            "Oregon",
            "Washington"
        ],

        //Miscellaneous
        [
            "Alaska",
            "Hawaii"
        ]
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.rightBarButtonItem = editButtonItem;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return zones.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard (0 ..< zones.count).contains(section) else {
                   fatalError("table contains no section number \(section)");
               }

        return zones[section].count;
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard (0 ..< zones.count).contains(indexPath.section) else {
                      fatalError("table contains no section number \(indexPath.section)");
                  }

                  guard (0 ..< zones[indexPath.section].count).contains(indexPath.row) else {
                      fatalError("section \(indexPath.section) contains no cell number \(indexPath.row)");
                  }
        

           let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "StatesCell", for: indexPath)

           // Configure the cell ...
           let state: String = zones[indexPath.section][indexPath.row];
           cell.textLabel?.text = state;
           cell.imageView?.image = UIImage(named: state);
           cell.detailTextLabel?.text = "\(state) is state number \(indexPath.row + 1) of \(zones[indexPath.section].count) in time zone \(indexPath.section + 1).";

           cell.showsReorderControl = true;
           return cell;
       }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let state: String = zones[fromIndexPath.section].remove(at: fromIndexPath.row);
        zones[to.section].insert(state, at: to.row);
        tableView.reloadData();
    }
    
    // Override to support editing the table view.

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            zones[indexPath.section].remove(at: indexPath.row);                   //Delete the String from the model.
            tableView.deleteRows(at: [indexPath], with: .fade); //Delete the cell from the table view.
        }
    
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (0 ..< zones.count).contains(section) else {
            fatalError("no header for section number \(section)");
        }

        let names: [String] = [
            "EST: Eastern Standard Time (UTC-05:00)",
            "CST: Central Standard Time (UTC-06:00)",
            "MST: Mountain Standard Time (UTC-07:00)",
            "PST: Pacific Standard Time (UTC-08:00)",
            "Miscellaneous"
        ];

        return names[section];
    }

    
    // MARK: - Protocol UITableViewControllerDelegate

    //Called when a cell is tapped.

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state: String = zones[indexPath.section][indexPath.row];
        print("selected \(state) in cell number \(indexPath)");

        
        var urlComponents: URLComponents = URLComponents();
        urlComponents.scheme = "https";
        urlComponents.host = "en.wikipedia.org"; //English
        urlComponents.path = "/wiki/\(state)";    //will change " " to "%20"

        guard let url: URL = urlComponents.url else {
            fatalError("could not create url for state \(state)");
        }

        let safariViewController: SFSafariViewController = SFSafariViewController(url: url);
        present(safariViewController, animated: true);
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
           return .delete;
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
