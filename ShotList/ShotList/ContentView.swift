//
//  ContentView.swift
//  WebTest
//
//  Created by Alex on 14.10.2022.
//

import SwiftUI
import WebKit
import UIKit

let appName = "shots"

struct view : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        /*uiView.allowsBackForwardNavigationGestures = true
        let curentUrl = request.url!.absoluteString
        print(curentUrl)
        if curentUrl.contains(appName) {
            uiView.load(request)
        } else {
            UIApplication.shared.open(URL(string: curentUrl)!)
        }*/
        uiView.load(request)
    }
}

struct BackdropView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect(style: .light)
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(true)
        animator.finishAnimation(at: .start)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    
}

/// A transparent View that blurs its background
struct BackdropBlurView: View {
    
    let radius: CGFloat
    let opaque: Bool
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: radius, opaque: opaque)
    }
    
}

func getSafeAreaTop()->CGFloat{

        let keyWindow = UIApplication.shared.connectedScenes

            .filter({$0.activationState == .foregroundActive})

            .map({$0 as? UIWindowScene})

            .compactMap({$0})

            .first?.windows

            .filter({$0.isKeyWindow}).first

        

        return (keyWindow?.safeAreaInsets.top)!

    }

let window = UIApplication.shared.windows[0]
let topPadding = window.safeAreaInsets.top + 26

struct ContentView: View {
    @ObservedObject var isConnected = NetworkManager()
    var body: some View {
        if (isConnected.connectionDescription == "true") {
            ZStack {
                view(request: URLRequest(url: URL(string: "https://gnets.myds.me/filmmaker/iOSredirect.php?deviceId=" + UIDevice.current.identifierForVendor!.uuidString + "&app=" + appName)!)).previewLayout(.fixed(width: .infinity, height: .infinity))
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    BackdropBlurView(radius: 5, opaque: true)
                        .frame(width: 1000, height: topPadding)
                        .position(x: 0, y: 0)
                        .ignoresSafeArea()
                }
            }
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
