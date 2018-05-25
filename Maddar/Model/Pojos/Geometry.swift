

import Foundation
struct Geometry : Codable {
    let location : Location?
    
    enum CodingKeys: String, CodingKey {
        
        case location
    }
    
}
