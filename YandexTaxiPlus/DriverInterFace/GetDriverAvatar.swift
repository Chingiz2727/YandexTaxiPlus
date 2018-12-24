//
//  GetDriverAvatar.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/22/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class GetDriverAvatar {
    class func get(rating:Int,star:Int,completion:@escaping(_ avatar:String)->()) {
        if rating == 0 {
            switch star {
            case 0:
                completion("lub0")
            case 1:
                completion("lub1")
              case 2:
            completion("lub2")
                
            case 3:
                completion("lub3")
            case 4:
                completion("lub4")
            case 5:
                completion("lub5")

            default:
                break
            }
        }
        if rating == 1 {
            switch star {
            case 0:
                completion("master0")
            case 1:
                completion("master1")
            case 2:
                completion("master2")
            case 3:
                completion("master3")
            case 4:
                completion("master4")
            case 5:
                completion("master5")
            default:
                break
            }
        }
        else {
            switch star {
            case 0:
                completion("pro0")
            case 1:
                completion("pro0")
            case 2:
                completion("pro0")
            case 3:
                completion("pro0")
            case 4:
                completion("pro0")
            case 5:
                completion("pro0")
            default:
                break
            }
        }
    }
    
}
