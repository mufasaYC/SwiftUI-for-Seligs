//
//  ContentView.swift
//  SwiftUI for Seligs
//
//  Created by Mustafa Yusuf on 18/11/22.
//

import SwiftUI

class AlertManager: ObservableObject {
    
    struct SeligAlert: Identifiable, Hashable {
        var id: UUID = .init()
        let title: String
        let primaryActionTitle: String
        
        func body(_ primaryActionHandler: @escaping () -> Void) -> Alert {
            Alert(title: Text(title),
                  primaryButton: .default(Text(primaryActionTitle)) { primaryActionHandler() },
                  secondaryButton: .cancel())
        }
    }
    
    @Published var alert: SeligAlert? = nil
    @Published var showAlert: Bool = false {
        didSet {
            if showAlert {
                assert(alert != nil)
            } else {
                alert = nil
            }
        }
    }
    
    enum Style {
        case deprecated, notDeprecated
    }
    
    func presentAlert(with style: Style) {
        switch style {
            case .deprecated:
                alert = .init(title: "Deprecated Alert Title", primaryActionTitle: "Okay")
                showAlert = true
            case .notDeprecated:
                alert = .init(title: "Not Deprecated Alert Title", primaryActionTitle: "Okay")
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var alertManager: AlertManager
    
    var body: some View {
        VStack {
            Button("Deprecated") { alertManager.presentAlert(with: .deprecated) }
            Button("Not Deprecated") { alertManager.presentAlert(with: .notDeprecated) }
            
            if alertManager.showAlert {
                Text("")
                    .alert(isPresented: $alertManager.showAlert) { // using non-deprecated method
                        return alertManager.alert!.body {
                            alertManager.showAlert = false
                        }
                    }
            } else {
                Text("")
                    .alert(item: $alertManager.alert) { alert in // using deprecated method
                        alert.body {
                            alertManager.alert = nil
                        }
                    }
            }
        }
    }
}
