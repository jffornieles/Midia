//
//  BookCollection.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 25/02/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

struct BookCollection {

    let kind: String
    let totalItems: Int
    let items: [Book]?

}

extension BookCollection: Decodable {

    
}
