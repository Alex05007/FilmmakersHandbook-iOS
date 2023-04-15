//
//  NetworkManager.swift
//  WebTest
//
//  Created by Alex on 15.10.2022.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue (label: "NetworkManager")
    @Published var isConnected = true
    
    var connectionDescription: String {
        if (isConnected == true) {
            return "true"
        } else {
            return "false"
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start (queue: queue)
    }
}
