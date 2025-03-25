//
//  PeripheralState.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/25.
//

import SwiftUI

enum PeripheralState {
    case scanning, disconnected, connecting, connected, error
    
    var color: Color {
        switch self {
        case .scanning:
                .gray
        case .disconnected:
                .orange
        case .connecting:
                .blue
        case .connected:
                .green
        case .error:
                .red
        }
    }
}
