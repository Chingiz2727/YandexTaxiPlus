import Foundation
import Alamofire
import SwiftyJSON

class OrderDriverAction {
    class func action(url:String,order_id:String,completion:@escaping(_ state:String)->()){
        let params = ["token":APItoken.getToken()!,
                      "order_id":order_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    let state = json["state"].stringValue
                    completion(state)
                }
            }
        }
    }
}
