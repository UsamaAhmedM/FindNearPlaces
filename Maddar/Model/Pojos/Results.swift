
import Foundation
struct Results : Codable {
    let geometry : Geometry?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case geometry
        case name = "name"
    }
    
 
    
}
