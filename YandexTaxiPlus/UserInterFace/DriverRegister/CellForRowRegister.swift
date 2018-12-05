//
//  CellForRowRegister.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/28/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit

extension DriverRegisterTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 && expanded {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cellid2) as! ButtonsTableViewCell
            cell2.TaxiLabel.textAlignment = .left
            cell2.TaxiLabel.text = taxies[indexPath.row].name
            cell2.TaxiButton.image = UIImage(named: img[indexPath.row])
            return cell2
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid3) as! DriverRegisterTableViewCell2
            let text = cell.TextField.text
            cell.TextField.tag  = indexPath.row + 3
            let tag = cell.TextField.tag
            switch tag {
            case 3 :
                self.sits = text
            case 4:
                self.number_car = text
            case 5:
                self.create_year = text
            default:
                print("")
            }
            cell.TextField.delegate = self
            cell.TextField.placeholder = option2[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid4) as! CheckBoxTableViewCell
            cell.label.text = facilities[indexPath.row].name
            cell.check.tag = facilities[indexPath.row].id
            cell.check.addTarget(self, action: #selector(chec(check:)), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid5) as! CarInfoCell
            cell.ButtonClick.setTitle(option3[indexPath.row], for: .normal)
            cell.ButtonClick.setTitleColor(maincolor, for: .normal)
            cell.ButtonClick.isEnabled = true
            switch cell.ButtonClick.tag {
            case 0:
                cell.ButtonClick.setTitle(car_model_name, for: .normal)
            case 1:
                cell.ButtonClick.setTitle(car_mark_name, for: .normal)
            default:
                break
            }
            
            
            cell.ButtonClick.tag = indexPath.row
            cell.ButtonClick.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! DriverRegisterTableViewCell
            cell.TextField.tag = indexPath.row
            UserInformation.shared.getinfo { (info) in
                switch cell.TextField.tag {
                case 0:
                    cell.TextField.isEnabled = false
                    cell.TextField.placeholder = info.user!.name
                case 1:
                    cell.TextField.isEnabled = false
                    cell.TextField.placeholder = info.user!.phone
                case 2 :
                    cell.TextField.placeholder = "Email"
                    cell.TextField.isEnabled = true
                    self.email = cell.TextField.text
                default:
                    print("")
                }
            }
            return cell
        }
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
}
