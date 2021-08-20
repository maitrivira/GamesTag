//
//  DetailView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GamesDetail: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    var hero: Hero
    var game: Results
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 20)
                Text(game.name)
                    .font(.system(size: 25))
                    .bold()
                Spacer(minLength: 80)
                WebImage(url: URL(string: game.backgroundImage))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 240, alignment: .center)
                Spacer(minLength: 20)
                Text(String(game.rating))
                    .font(.system(size: 16))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .foregroundColor(Color.white)
        })
        .navigationBarTitle("Detail")
    }
}
