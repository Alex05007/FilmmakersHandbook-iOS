//
//  ContentView.swift
//  WebTest
//
//  Created by Alex on 14.10.2022.
//

import SwiftUI
import WebKit
import UIKit

let appName = "workplace"

struct view : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.allowsBackForwardNavigationGestures = true
        /*let curentUrl = request.url!.absoluteString
        print(curentUrl)
        if curentUrl.contains(appName) {
            uiView.load(request)
        } else {
            UIApplication.shared.open(URL(string: curentUrl)!)
        }*/
        uiView.load(request)
    }
}

struct ContentView: View {
    @ObservedObject var isConnected = NetworkManager()
    var body: some View {
        if (isConnected.connectionDescription == "true") {
            view(request: URLRequest(url: URL(string: "https://gnets.myds.me/filmmaker/iOSredirect.php?deviceId=" + UIDevice.current.identifierForVendor!.uuidString + "&app=" + appName)!)).previewLayout(.fixed(width: .infinity, height: .infinity))
                    .ignoresSafeArea()
        } else {
            VStack {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 56.0))
                    .foregroundColor(.blue)
                Text("We couldn't reach our servers.")
                Text("Please check your connection to the internet.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
