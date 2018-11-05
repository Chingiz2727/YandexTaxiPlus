//
//  HistoryTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 24.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Koyomi
class HistoryTableViewController: UITableViewController,KoyomiDelegate {
   var cellid = "cellid"
    let blackview = UIView()
    var img : String!
    
    var history = [HistoryModule(img: "placeholder", price: "500тг", date: "27.08.1997",place:"Яссауи - Жандосова"),
                   HistoryModule(img: "placeholder", price: "400тг", date: "17.08.1997",place:"Яссауи - Жандосова"),
                   HistoryModule(img: "placeholder", price: "400тг", date: "25.07.2018",place:"Яссауи - Жандосова")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.tableFooterView = UIView()
        img = "calendar"
        let nav = UIImage(named: img)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nav, style: .plain, target: self, action: #selector(create))
        navigationItem.rightBarButtonItem?.width = 20
//         create()
    }

    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        img = "check"
        let nav = UIImage(named: img)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nav, style: .plain, target: self, action: #selector(remove))
    }
  @objc func remove() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
            blackview.alpha = 0
            
        }else{
            print("No!")
           
        }
    viewWillAppear(true)
    viewDidLoad()
    }

    @objc func create() {
        let frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        
        let koyo = Koyomi(frame: frame, sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
        koyo.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        blackview.backgroundColor = UIColor.black
        img = "check"
        let nav = UIImage(named: img)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nav, style: .plain, target: self, action: #selector(remove))
        blackview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        blackview.alpha = 0.7
        view.addSubview(blackview)
        view.addSubview(koyo)
        koyo.tag = 100
        koyo.display(in: .current)
        koyo.calendarDelegate = self
        koyo.isHiddenOtherMonth = true
        koyo.currentDateString()
        koyo.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
        koyo.selectionMode = .single(style: .circle)
        koyo.selectedStyleColor = UIColor.init(red: 104/255, green: 205/255, blue: 179/255, alpha: 1.0)
        var MainColor =  UIColor.init(red: 104/255, green: 205/255, blue: 179/255, alpha: 1.0)
        koyo.setDayFont(size: 14).setWeekFont(size: 10)
        koyo.style = .custom(customColor: (dayBackgrond: .white, weekBackgrond: .white, week: .black, weekday: .gray, holiday: (saturday: .red, sunday: .red), otherMonth: .black, separator: .white))
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
        return history.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HistoryTableViewCell
        cell.img.image = UIImage(named: history[indexPath.row].img)
        cell.label.text = history[indexPath.row].price
        cell.date.text = history[indexPath.row].date
        cell.place.text = history[indexPath.row].place
        // Configure the cell...

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
