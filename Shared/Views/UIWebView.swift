//
//  WebView.swift
//  BookmarkCalendar (iOS)
//
//  Created by Jae Seung Lee on 6/24/21.
//

import SwiftUI
import WebKit

struct UIWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<UIWebView>) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
}
