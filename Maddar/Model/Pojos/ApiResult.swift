
import Foundation
struct ApiResult : Codable {
    let html_attributions : [String]?
    let next_page_token : String?
    let results : [Results]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case html_attributions = "html_attributions"
        case next_page_token = "next_page_token"
        case results = "results"
        case status = "status"
    }
    
    
}
