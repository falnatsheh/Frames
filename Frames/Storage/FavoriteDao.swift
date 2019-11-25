import Foundation
import CoreData
import UIKit

class FavoriteDao {
    private let entityName = "Favorite"
    private let idKey = "id"
    private let favoriteKey = "isFavorite"
    private var managedContext: NSManagedObjectContext? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    func isFavorite(id: String) -> Bool {
        let favorites = readFavorites(id: id)
        if favorites.count > 0, let isFavorite = favorites[0].value(forKeyPath: favoriteKey) as? Bool {
            return isFavorite
        }
        return false
    }
    
    func saveFavorite(id: String, isFavorite: Bool) -> Bool{
        guard let managedContext = managedContext,
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
            else { return false }
       
        let favorites = readFavorites(id: id)
        let favorite: NSManagedObject
        if favorites.count > 0 {
            favorite = favorites[0]
        } else {
            favorite = NSManagedObject(entity: entity, insertInto: managedContext)
            favorite.setValue(id, forKeyPath: idKey)
        }
        
        favorite.setValue(isFavorite, forKeyPath: favoriteKey)
        
        do {
            try managedContext.save()
            return true
        }
        catch { return false }
    }
    
    private func readFavorites(id: String) -> [NSManagedObject] {
        guard let managedContext = managedContext else { return [] }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(idKey) == %@", id)
        
        do { return try managedContext.fetch(fetchRequest) }
        catch { return [] }
    }
}
