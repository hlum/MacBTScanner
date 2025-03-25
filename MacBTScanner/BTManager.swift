//
//  BTManager.swift
//  MacBTScanner
//
//  Created by Hlwan Aung Phyo on 2025/03/23.
//

import Foundation
import CoreBluetooth
import SwiftUI

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let shared = BluetoothManager()
    
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
    
    var centralManager: CBCentralManager!
    
    var esp32: CBPeripheral?
    var esp32Characteristic: CBCharacteristic?
    
    
    @Published var peripheralState: PeripheralState = .disconnected
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    // デバイスがオンになり,スキャンやり始める
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
        } else {
            Logger.standard.error("Bluetooth デバイスがオフ")
        }
    }
    
    
    // デバイスを見つかり接続する
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        Logger.standard.info("デバイスを発見.接続。。。。。。")
        
        if esp32 == nil {
            esp32 = peripheral
        }
        peripheralState = .connecting
        connectTo(peripheral)
    }
    
    
    // 接続成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        Logger.standard.info("接続成功")
        peripheralState = .connected
        peripheral.discoverServices([CBUUID(string: UUIDStrings.serviceUUIDString)])
    }
    
    
    //　接続失敗
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        Logger.standard.error("接続失敗\(error)")
    }
    
    
    // 切断された
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        Logger.standard.info("切断")
    }
}


// Helper funcs
extension BluetoothManager {

    private func startScan() {
        centralManager.scanForPeripherals(withServices: [CBUUID(string: UUIDStrings.serviceUUIDString)])
        peripheralState = .scanning
    }
    
    
    private func connectTo(_ peripheral: CBPeripheral) {
        peripheral.delegate = PeripheralManager.shared
        centralManager.stopScan()
        centralManager.connect(peripheral)
    }
    
}
