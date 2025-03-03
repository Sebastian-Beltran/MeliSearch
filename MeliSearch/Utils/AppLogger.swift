//
//  AppLogger.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 3/03/25.
//

import Foundation
import os


struct AppLogger {
    static let subsystem = Bundle.main.bundleIdentifier ?? "MeliSearch"

    private static let apiLogger = OSLog(subsystem: subsystem, category: "API")

    static func logAPIRequest(url: String) {
        os_log("📡 Request: %{PUBLIC}@", log: apiLogger, type: .info, url)
    }

    static func logAPIResponse(statusCode: Int, data: String?) {
        os_log("✅ Response: Status Code %d", log: apiLogger, type: .info, statusCode)
        if let data = data {
            os_log("📦 Response Data: %{PUBLIC}@", log: apiLogger, type: .debug, data)
        }
    }

    static func logAPIError(_ error: APIError) {
        os_log("❌ API Error: %{PUBLIC}@", log: apiLogger, type: .error, error.localizedDescription)
    }
}

