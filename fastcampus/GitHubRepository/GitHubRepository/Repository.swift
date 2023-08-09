//
//  Repository.swift
//  GitHubRepository
//
//  Created by hogang on 2023/08/09.
//

import Foundation
/*
 {
    "id": 44137852,
    "name": "cups",
    "description": "Apple CUPS Sources",
    "stargazers_count": 1716,
    "language": "C",
 }
 */

struct Repository: Decodable {
     
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
    
}
