//
//  ContentViewModel.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/25.
//


import CoreBluetooth

final class ContentViewModel: ObservableObject {
    private let btManager = BluetoothManager.shared
    
    @Published var peripheralState: PeripheralState = .scanning
    
    init() {
        btManager.peripheralStateChanged = { [weak self] state in
            self?.peripheralState = state
        }
    }
    
    func toggleLED() {
        guard let char = btManager.esp32Characteristic,
        let data = "toggle".data(using: .utf8)
        else {
            Logger.standard.warning("Characteristic not found")
            return
        }
        btManager.esp32?.writeValue(data, for: char, type: .withResponse)
    }
}
