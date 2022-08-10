//
//  FaceIDView.swift
//  AprendeSwiftUI
//
//  Created by alp1 on 20/7/22.
//

import Foundation
import LocalAuthentication
import SwiftUI

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

class Data{
    @AppStorage("historial") var historial: [String] = []
    func showHistorial(){
        historial.forEach { item in
            print(item)
        }
    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isUnlocked = false
        func authenticationWithBiometrics(){
            var context = LAContext()
            if self.isUnlocked {
                self.isUnlocked = false
            } else {
                context = LAContext()
                context.localizedCancelTitle = "Cancelar"
                var error: NSError?
                if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                    let reason = "Log in to your account"
                    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                        if success {
                            DispatchQueue.main.async { [unowned self] in
                                self.isUnlocked = true
                            }
                        } else {
                            print(error?.localizedDescription ?? "Failed to authenticate")
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "Can't evaluate policy")
                }
            }
        }
    }
}
