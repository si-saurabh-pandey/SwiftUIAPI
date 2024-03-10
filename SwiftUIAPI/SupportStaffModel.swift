//
//  SupportStaffModel.swift
//  SwiftUIAPI
//
//  Created by Saurabh Pandey on 08/03/24.
//

import Foundation
struct SupportStaffData: Identifiable, Codable {
    let id: String
    let name: String
    let roleName: String
    let nationalityID: String
    let nationalityName: String
    let imageURL: String
    let countryURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, roleName, nationalityID, nationalityName, imageURL, countryURL
    }
}

