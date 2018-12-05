//
//  MyPlacesTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class MyPlacesTableViewController: UITableViewController {
    var cellid = "cellid"
    var first_delegate : firstplacedelegate?
    var second_delegate : secondplacedelegate?
    var tag : Int!
    var myplace = [MyPlace]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyPlacesTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "check"), style: .plain, target: self, action: #selector(create))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getmyplace()
        UIColourScheme.instance.set(for:self)

    }
    override func viewWillAppear(_ animated: Bool) {
                getmyplace()
    }
    
    func getmyplace() {
            GetMyPlace.get { (myplace:[MyPlace]!) in
            if let myplace = myplace {
                self.myplace = myplace
                self.tableView.reloadData()
            }
        }
    }
    @objc func create() {
        navigationController?.pushViewController(SavePlaceViewController(), animated: true)
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
        return myplace.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MyPlacesTableViewCell
        cell.place.text = myplace[indexPath.row].place
        let item = myplace[indexPath.row]
        print(item.lat)
        print(item.lang)
        cell.img.image = UIImage(named: "placeholder")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = myplace[indexPath.row]
        switch tag {
        case 0:
            first_delegate?.first_lat = Double(item.lat)!
            first_delegate?.first_long = Double(item.lang)!
            first_delegate?.first_name = item.place
            first_delegate?.firstadded()
        case 1:
            second_delegate?.second_lat = Double(item.lat)!
            second_delegate?.second_long = Double(item.lang)!
            second_delegate?.second_name = item.place
            second_delegate?.secondadded()
        default:
            break
        }
        
        self.navigationController?.popViewController(animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
