//
//  IPFetcher.swift
//  ShowMyIP
//
//  Created by Amit Aharoni on 11/18/24.
//

import Foundation
import AppKit

class IPFetcher: ObservableObject {
    @Published var ipAddress: String?

    func fetchIPAddress() {
        print("Starting to fetch IP address...") // Debug log
        guard let url = URL(string: "http://ifconfig.me") else {
            DispatchQueue.main.async {
                self.ipAddress = "Invalid URL"
            }
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.ipAddress = "Error: \(error.localizedDescription)"
                    print("Error fetching IP: \(error.localizedDescription)")
                }
                return
            }

            if let data = data, let ipAddress = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
                DispatchQueue.main.async {
                    self.ipAddress = ipAddress
                    print("Fetched IP Address: \(ipAddress)") // Debug log
                }
            } else {
                DispatchQueue.main.async {
                    self.ipAddress = "Failed to fetch"
                    print("Failed to fetch IP")
                }
            }
        }

        task.resume()
    }

    func copyToClipboard() {
        if let ipAddress = ipAddress {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(ipAddress, forType: .string)
        }
    }
}
