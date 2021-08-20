//
//  ContentView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var gameData = GameViewModel()
    var body: some View {
        TabView {
            GamesList()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .environmentObject(gameData)
            About()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let standardApperance = UINavigationBarAppearance()
        standardApperance.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.00)
        standardApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = standardApperance
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "doc.text.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("No Data")
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
