//
//  Bookmark+Extension.swift
//  BookmarkCalendar (macOS)
//
//  Created by Jae Seung Lee on 6/25/21.
//

import Foundation
import CoreData

extension Bookmark {
    static func create(url: String, context: NSManagedObjectContext) {
        let newBookmark = Bookmark(context: context)
        newBookmark.id = UUID()
        newBookmark.url = URL(string: url)
        context.saveContext()
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        created = Date()
    }
}

extension NSManagedObjectContext {
    func saveContext() {
        do {
            try save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func delete(_ bookmarks: [Bookmark]) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        request.predicate = NSPredicate(format: "id IN %@", bookmarks.map { $0.id?.uuidString })
        do {
            let results = (try fetch(request) as? [Bookmark]) ?? []
            results.forEach { delete($0) }
        } catch {
            print("Failed removing provided objects")
            return
        }
        saveContext()
    }
}
