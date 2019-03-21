//
//  CoreDataStorageManagerMovie.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 21/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//


import Foundation
import CoreData

// TODO: capa de abstraction para usar siempre media items

class CoreDataStorageManagerMovie: FavoritesProvidable {
    
    
    let stack = CoreDataStack.sharedInstance
    
    
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        let context = stack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.map({ $0.mappedObject() })
        } catch {
            assertionFailure("Error fetching media items")
            return nil
        }
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        let context = stack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "trackId = %@", favoriteId)
        fetchRequest.predicate = predicate
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.last?.mappedObject()
        } catch {
            assertionFailure("Error fetching media item by id \(favoriteId)")
            return nil
        }
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        let context = stack.persistentContainer.viewContext
        if let movie = favorite as? Movie {
            let movieManaged = MovieManaged(context: context)
            movieManaged.trackId = movie.trackId
            movieManaged.movieTitle = movie.title
            movieManaged.releaseDate = movie.releaseDate
            movieManaged.coverURL = movie.coverURL?.absoluteString
            movieManaged.descriptionMovie = movie.description
//            if let rating = movie.rating {
//                movieManaged.rating = rating
//            }
//            if let numberOfReviews = movie.numberOfReviews {
//                movieManaged.numberOfReviews = Int32(numberOfReviews)
//            }
            if let price = movie.price {
                movieManaged.price = price
            }
            movie.authors?.forEach({ (authorName) in
                let author = Author(context: context)
                author.fullName = authorName
                movieManaged.addToAuthors(author)
            })
            do {
                try context.save()
            } catch {
                assertionFailure("error saving context")
            }
        } else {
            fatalError("not supported yet :(")
        }
        
    }
    
    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "trackId = %@", favoriteId)
        fetchRequest.predicate = predicate
        do {
            let favorites = try context.fetch(fetchRequest)
            favorites.forEach({ (movieManaged) in
                context.delete(movieManaged)
            })
            try context.save()
            
        } catch {
            assertionFailure("Error removing media item with id \(favoriteId)")
        }
    }
    
}

