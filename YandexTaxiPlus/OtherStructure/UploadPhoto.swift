//
//  UploadPhoto.swift
//  University_app
//
//  Created by Чингиз on 13.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}




//func generateBoundaryString() -> String
//{
//    return "Boundary-\(NSUUID().uuidString)"
//}



func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
    }
    
    let date = NSDate()
    let calendar = NSCalendar.current
    let year = calendar.component(.year, from: date as Date)
    let month = calendar.component(.month, from: date as Date)
    let hour = calendar.component(.hour, from: date as Date)
    let minutes = calendar.component(.minute, from: date as Date)
    let seconds = calendar.component(.second, from: date as Date)
    
    let name = "\(year)-\(month)-\(hour)-\(minutes)-\(seconds).jpeg"
    let filename = name
    let mimetype = "image/jpg"
    
    body.appendString(string: "--\(boundary)\r\n")
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string: "\r\n")
    body.appendString(string: "--\(boundary)--\r\n")
    
    return body
}
@available(iOS 10.0, *)

class MakePhoto {
    class func createPhoto(photo: UIImage,completion: @escaping(_ error:Error?, _ success:Bool)-> Void)
    {
        let param = [
            "token" : APItoken.getToken()!,
            "file" : "user_photo"
            ]
        let myUrl = URL(string: baseurl + "/upload-avatar/")
        let request = NSMutableURLRequest(url: myUrl!);
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = photo.pngData()
        if(imageData==nil)  { return; }
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "myfile", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }else{
                print(response)
            }
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                
                
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
