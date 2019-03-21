//
//  MovieManage+Mapping.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 21/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
        
        let authorsList = authors?.map({ (author) -> String in
            let author = author as! Author
            return author.fullName!
        })
        
        let url: URL? = coverURL != nil ? URL(string: coverURL!) : nil
        
        return Movie(trackId: trackId!, title: movieTitle!, authors: authorsList, releaseDate: releaseDate, description: descriptionMovie, coverURL: url, price: price)
    }
    
}
