//
//  Logger.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/23.
//

import Foundation
import OSLog

public enum Logger {
    public static let standard: os.Logger = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "Logger"
    )
}
