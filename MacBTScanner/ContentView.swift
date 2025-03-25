//
//  ContentView.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/23.
//

import SwiftUI
import CoreBluetooth

final class ContentViewModel: ObservableObject {
    let btManager = BluetoothManager.shared
    
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

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        VStack {
            Circle()
                .fill(vm.btManager.peripheralState.color)
                .frame(maxHeight: 100)
            
            Button {
                vm.toggleLED()
            } label: {
                VStack {
                    Image(systemName: "sun.max")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .padding()
                    
                    Text("Toggle LED")
                }
            }

        }
        .frame(minWidth: 400)
        .padding()
    }
}

#Preview {
    ContentView()
}
