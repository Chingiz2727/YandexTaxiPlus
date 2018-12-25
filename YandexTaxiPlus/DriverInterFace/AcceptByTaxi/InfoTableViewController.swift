//
//  InfoTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/29/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
import Toast_Swift
class InfoTableViewController: UITableViewController {
    let cellid = "cellid"
    var menu = [AccepTaxiModule]()
    var order_id : String!
    var Map : GMSMapView = GMSMapView()
    var footer : UIView = UIView()
    var AcceptButton : UIButton = UIButton()
    let marker1 = GMSMarker()
    let window = UIApplication.shared.keyWindow!
    let marker2 = GMSMarker()
    var CancelButton : UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
tableView.register(AcceptByTaxiCell.self, forCellReuseIdentifier: cellid)
        reload()
        tableView.bounces = false
        UIColourScheme.instance.set(for:self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    
    func reload(){
        GetInfoForDriver.GetInfo(order_id: order_id!) { (info) in
            var price = info.order?.price
            let module = [AccepTaxiModule(detail: "Имя:", menu: (info.client?.name ?? "")!, img: "user"),
                          AccepTaxiModule(detail: "Цена:", menu: String(price ?? 0), img: "icon_by_bonuses")]
            let fromlong = info.order?.fromLongitude?.toDouble()
            let fromlat = info.order?.fromLatitude?.toDouble()
            let tolong = info.order?.toLongitude?.toDouble()
            let tolat = info.order?.toLatitude?.toDouble()
            if let tolat = tolat {
                Route.Draw(startlat: fromlat!, startlong: fromlong!, endlat: tolat, englong: tolong!, map: self.Map)
                self.marker2.position = CLLocationCoordinate2D(latitude: tolat, longitude: tolong!)
                self.marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 20, height: 20))
                self.marker2.map = self.Map
                self.marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 20, height: 20))
                self.marker1.position = CLLocationCoordinate2D(latitude: fromlat!, longitude: fromlong!)
                self.marker1.map = self.Map
                self.Map.isMyLocationEnabled = true
                let camera = GMSCameraPosition.camera(withLatitude: fromlat!, longitude: fromlong!, zoom: 13.0)
                self.Map.camera = camera

            }

            self.menu = module
            self.tableView.reloadData()
        }
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AcceptByTaxiCell
        
        cell.menu.text = menu[indexPath.row].detail
        cell.detail.text = menu[indexPath.row].menu
        cell.icon.image = UIImage(named: menu[indexPath.row].img)
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        return Map
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        view.addSubview(footer)
        footer.addSubview(AcceptButton)
        footer.addSubview(CancelButton)
        CancelButton.backgroundColor = UIColor.red
        AcceptButton.setTitle("Принять", for: .normal)
        CancelButton.setTitle("Отказать", for: .normal)
        CancelButton.setTitleColor(UIColor.white, for: .normal)
        AcceptButton.setTitleColor(UIColor.white, for: .normal)
        AcceptButton.backgroundColor = maincolor
        AcceptButton.layer.cornerRadius = 10
        CancelButton.layer.cornerRadius = 10
        AcceptButton.setAnchor(top: footer.topAnchor, left: footer.leftAnchor, bottom: footer.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0,width: 120,height: 0)
        CancelButton.setAnchor(top: footer.topAnchor, left: nil , bottom: footer.bottomAnchor, right: footer.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10,width: 120,height: 0)
        AcceptButton.addTarget(self, action: #selector(Accept), for: .touchUpInside)
        CancelButton.addTarget(self, action: #selector(cancel   ), for: .touchUpInside)
        return footer
    }
    @objc func Accept() {
        AcceptFunc.accept(order_id: order_id!) { (order_make, exist) in
            if order_make == true {
                self.dismiss(animated: true, completion: nil)
                self.window.rootViewController = UINavigationController.init(rootViewController: DriverMapViewController())
            }
            if exist == true {
                self.window.makeToast("У вас уже есть заказ")
            }
        }
      
    }
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
