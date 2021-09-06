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
    @GestureState private var dragOffset = CGSize.zero
    @EnvironmentObject var favorites: Favorites
    var game: Results
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text(game.name)
                    .font(.title2)
                    .bold()
                WebImage(url: URL(string: game.backgroundImage))
                    .resizable()
                    .frame(height: 200, alignment: .center)
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                Text("Genres")
                    .font(.title3)
                    .bold()
                HStack {
                    ForEach(game.genres) { game in
                        Text(game.name)
                            .font(.footnote)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color("Navy"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                Spacer()
                Text("Information")
                    .font(.title3)
                    .bold()
                HStack {
                    Text("Rating :")
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                    Text("\(String(game.rating)) out of 5")
                }
                HStack {
                    Text("Released :")
                    Text(game.released)
                }
                Spacer()
                Text("Tags")
                    .font(.title3)
                    .bold()
                LazyVGrid(columns: columns) {
                    ForEach(game.tags) { tag in
                        CardView(content: tag.name)
                    }
                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
            }),
            trailing: Button(action: {
                if favorites.contains(game) {
                    favorites.remove(game)
                } else {
                    favorites.add(game)
                }
            }, label: {
                if favorites.contains(game) {
                    Image(systemName: "heart.fill").foregroundColor(Color.red)
                } else {
                    Image(systemName: "heart").foregroundColor(Color.white)
                }
            })
        )
        .navigationBarTitle("Detail")
        .environment(\.locale, Locale(identifier: "id"))
        .gesture(DragGesture().updating($dragOffset, body: { (value, _, _) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct CardView: View {
    var content: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 8)
            shape.fill().foregroundColor(Color("Navy"))
            Text(content)
                .padding(4)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .lineLimit(3)
        }
    }
}
