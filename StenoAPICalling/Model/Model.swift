//
//  Model.swift
//  StenoAPICalling
//
//  Created by Arpit iOS Dev. on 07/06/24.
//

import Foundation
import UIKit

// MARK: - Welcome
struct Welcome: Codable {
    let status: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, name, path, path1: String
    let extPath: EXTPath
    let extPath1: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, path, path1
        case extPath = "ext_path"
        case extPath1 = "ext_path1"
    }
}

enum EXTPath: String, Codable {
    case pdf = "pdf"
    case mp4 = "mp4"
}

