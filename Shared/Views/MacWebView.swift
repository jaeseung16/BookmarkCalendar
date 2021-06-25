//
//  MacWebView.swift
//  BookmarkCalendar
//
//  Created by Jae Seung Lee on 6/24/21.
//

import SwiftUI
import WebKit

struct MacWebView: NSViewRepresentable {
    let url: URL
    
    func makeNSView(context: NSViewRepresentableContext<MacWebView>) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        
    }
    
}
