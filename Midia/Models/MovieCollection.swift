//
//  MovieCollection.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 18/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

struct MovieCollection {
    let resultCount: Int
    let results: [Movie]?
}

extension MovieCollection: Codable {
    
}
