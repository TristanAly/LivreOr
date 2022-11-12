//
//  LivreOrApp.swift
//  LivreOr
//
//  Created by apprenant1 on 24/10/2022.
//

import SwiftUI

@main
struct LivreOrApp: App {
    
    @StateObject var vm = MessageViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
