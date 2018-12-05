// To parse the JSON, add this file to your project and do:
//
//   let geoCodable = try? newJSONDecoder().decode(GeoCodable.self, from: jsonData)

import Foundation

struct GeoCodable: Codable {
    let plusCode: PlusCode?
    let results: [Result]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case plusCode = "plus_code"
        case results, status
    }
}

struct PlusCode: Codable {
    let compoundCode, globalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

struct Result: Codable {
    let addressComponents: [AddressComponent]?
    let formattedAddress: String?
    let geometry: Geometry?
    let placeID: String?
    let plusCode: PlusCode?
    let types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
        case placeID = "place_id"
        case plusCode = "plus_code"
        case types
    }
}

struct AddressComponent: Codable {
    let longName, shortName: String?
    let types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

struct Geometry: Codable {
    let location: Location?
    let locationType: String?
    let viewport, bounds: Bounds?
    
    enum CodingKeys: String, CodingKey {
        case location
        case locationType = "location_type"
        case viewport, bounds
    }
}

struct Bounds: Codable {
    let northeast, southwest: Location?
}

struct Location: Codable {
    let lat, lng: Double?
}
