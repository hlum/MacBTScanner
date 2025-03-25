//
//  ContentView.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        VStack {
            Circle()
                .fill(vm.peripheralState.color)
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
