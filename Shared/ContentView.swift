//
//  ContentView.swift
//  Shared
//
//  Created by Jae Seung Lee on 6/23/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Bookmark.created, ascending: true)],
        animation: .default)
    private var bookmarks: FetchedResults<Bookmark>
    
    @State private var showAddBookmarkView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookmarks) { bookmark in
                    NavigationLink(
                        destination: BookmarkView(bookmark: bookmark).environment(\.managedObjectContext, viewContext),
                        label: {
                            getLabel(bookmark: bookmark)
                        })
                }
                .onDelete(perform: deleteItems)
            }
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: {
                showAddBookmarkView.toggle()
            }) {
                Label("Add Item", systemImage: "plus")
            }
            .sheet(isPresented: $showAddBookmarkView, content: {
                AddBookmarkView(showAddBookmarkView: $showAddBookmarkView)
                    .environment(\.managedObjectContext, viewContext)
            })
        }
        
    }
    
    private func getLabel(bookmark: Bookmark) -> some View {
        let urlString = bookmark.url == nil ? "" : "\(bookmark.url!)"
        
        return Text("\(urlString) added at \(bookmark.created!, formatter: itemFormatter)")
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { bookmarks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
