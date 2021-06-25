//
//  BookmarkView.swift
//  BookmarkCalendar (iOS)
//
//  Created by Jae Seung Lee on 6/24/21.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var bookmark: Bookmark
    
    var body: some View {
        Text("\(bookmark.created!)")
        
        Text("\(bookmark.url!)")
        
        Divider()
        
        bookmark.url.map {
            #if os(iOS)
            UIWebView(url: $0)
                .shadow(color: Color.gray, radius: 1.0)
                //.border(Color.gray, width: 1.0)
                .padding()
            #else
            MacWebView(url: $0)
                .shadow(color: Color.gray, radius: 1.0)
                //.border(Color.gray, width: 1.0)
                .padding()
            #endif
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    private static var bookmark: Bookmark {
        let aBookmark = Bookmark()
        aBookmark.url = URL(string: "https://gist.github.com/quoha/4587902")
        aBookmark.created = Date()
        return aBookmark
    }
    
    static var previews: some View {
        BookmarkView(bookmark: bookmark)
    }
}
