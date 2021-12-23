//
//  ViewController.swift
//  MVC_in_iOS
//
//  Created by Atheer Alahmari on 19/05/1443 AH.
//

import UIKit

class GETPeople_TableViewController: UITableViewController {

    // Hardcoded data for now
    var people :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeopleApi()
    }
 
  
    func getPeopleApi(){
        ApiManager.getAllPeople(completionHandler:{ data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        
                        let resultsArray = results as! NSArray
                        
                        for object in resultsArray {
                            if let jsonObject = object as? NSDictionary{
                                self.people.append(jsonObject["name"] as! String)
                            }
                        }
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch {
                print(error)
            }
        })
    }

        
       
    
   

// MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return people.count
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "GETPeople_TableViewController"), for: indexPath)

    cell.textLabel?.text = people[indexPath.row]

    return cell
}




}
