//
//  webView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/07/2024.
//

import SwiftUI
import WebKit
import EMLECore

enum PaymentCallBackType {
    case success
    case failure
    case unknown
}

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading : LoadingState
    let paymentResult: (PaymentCallBackType) -> Void
    
    
    init(url: URL,isLoading: Binding<LoadingState>,paymentResult: @escaping (PaymentCallBackType) -> Void) {
        self.url = url
        self._isLoading = isLoading
        self.paymentResult = paymentResult
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.isScrollEnabled = true
             
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.isLoading = .loading
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.isLoading = .loaded
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.isLoading = .loaded
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                if url.absoluteString.contains("success") {
                    parent.paymentResult(.success)
                } else if url.absoluteString.contains("failure") {
                    parent.paymentResult(.failure)
                }else {
                    parent.paymentResult(.unknown)
                }
            }
            decisionHandler(.allow)
        }
    }
}
