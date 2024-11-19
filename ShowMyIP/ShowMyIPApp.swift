//
//  ShowMyIPApp.swift
//  ShowMyIP
//
//  Created by Amit Aharoni on 11/18/24.import Foundation
import SwiftUI

@main
struct ShowMyIPApp: App {
    @StateObject private var ipFetcher = IPFetcher()

    var body: some Scene {
        MenuBarExtra("ShowMyIP", systemImage: "wifi.router.fill") {
            Group {
                if let ipAddress = ipFetcher.ipAddress {
                    Text("IP Address: \(ipAddress)")
                        .padding()
                } else {
                    Text("Fetching IP...")
                        .padding()
                }
            }
            .onAppear {
                print("Menu appeared, fetching IP...")
                ipFetcher.fetchIPAddress() // Fetch IP on menu appearance
            }

            Divider()

            Button("Refresh") {
                ipFetcher.fetchIPAddress()
                DispatchQueue.main.async {
                    NSApp.activate(ignoringOtherApps: true) // Keeps the menu open
                }
            }
            .keyboardShortcut("r")

            Button("Copy IP Address") {
                ipFetcher.copyToClipboard()
            }
            .keyboardShortcut("c")

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}
