//
//  AddBookmarkView.swift
//  BookmarkCalendar (macOS)
//
//  Created by Jae Seung Lee on 6/25/21.
//

import SwiftUI

struct AddBookmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddBookmarkView: Bool
    
    @State private var urlString = ""
    
    var body: some View {
        VStack {
            Text("Add a new bookmark")
            
            Form {
                Section(header: Text("URL")) {
                    TextField("Insert url", text: $urlString, onCommit: {
                    })
                }
            }
            
            Button(
                action: {
                    Bookmark.create(url: urlString, context: viewContext)
                    showAddBookmarkView = false
                },
                label: {
                    HStack {
                        Text("Save Link")
                    }
                }
            )
            .disabled(urlString.isEmpty)
        }
        .padding()
        
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView(showAddBookmarkView: .constant(true))
    }
}
