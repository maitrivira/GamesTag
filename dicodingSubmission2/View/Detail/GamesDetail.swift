//
//  DetailView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct GamesDetail: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @EnvironmentObject var detailViewModel: GameDetailViewModel
    @EnvironmentObject var favorite: FavoriteViewModel
    @State var selected: Bool = false
    var game: Results
    var gameData: GameData
    var type: String
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        ScrollView {
            if detailViewModel.desc.isEmpty {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                VStack(alignment: .center, spacing: 10) {
                    Text((type != "favorite" ? game.name : gameData.name) ?? "")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                    WebImage(url: URL(string: (type != "favorite" ? game.backgroundImage : gameData.backgroundImage) ?? ""))
                        .placeholder(Image(systemName: "photo"))
                        .resizable()
                        .frame(height: 200, alignment: .center)
                }
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        HStack {
                            if type != "favorite" {
                                ForEach(game.genres, id: \.self.id) { game in
                                    Text(game.name)
                                        .font(.footnote)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 4)
                                        .background(Color("Green"))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            } else {
                                ForEach(favorite.gameGenres, id: \.self.id) { game in
                                    Text(game.name ?? "")
                                        .font(.footnote)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 4)
                                        .background(Color("Green"))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    Spacer()
                    Text(detailViewModel.desc)
                        .font(.body)
                    Spacer()
                    Group {
                        Text("Information")
                            .font(.title3)
                            .bold()
                        HStack {
                            Text("Rating :")
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Color.orange)
                            Text("\(type != "favorite" ? String(game.rating) : String(gameData.rating)) out of 5")
                        }
                        HStack {
                            Text("Released :")
                            Text((type != "favorite" ? game.released : gameData.released) ?? "")
                        }
                    }
                    Spacer()
                    Group {
                        Text("Tags")
                            .font(.title3)
                            .bold()
                        LazyVGrid(columns: columns) {
                            if type != "favorite" {
                                ForEach(game.tags, id: \.self.id) { tag in
                                    CardView(content: tag.name)
                                }
                            } else {
                                ForEach(favorite.gameTags, id: \.self.id) { tag in
                                    CardView(content: tag.name ?? "")
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            if type == "favorite" {
                favorite.getGenres(of: gameData.name ?? "")
                favorite.getTags(of: gameData.name ?? "")
            }
            detailViewModel.id = type != "favorite" ? game.id : Int(gameData.id)
            checkIcon()
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
                if selected {
                    favorite.deleteData(of: type != "favorite" ? Int32(game.id) : gameData.id)
                    selected = false
                    type == "favorite" ? self.mode.wrappedValue.dismiss() : nil
                } else {
                    favorite.addData(data: game)
                    selected = true
                }
            }, label: {
                if selected {
                    Image(systemName: "heart.fill").foregroundColor(Color("Gray"))
                } else {
                    Image(systemName: "heart").foregroundColor(Color("Gray"))
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
    func checkIcon() {
        if favorite.containsId(type != "favorite" ? Int32(game.id) : gameData.id) {
            selected = true
        } else {
            selected = false
        }
    }
}

struct CardView: View {
    var content: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 8)
            shape.fill().foregroundColor(Color("Green"))
            Text(content)
                .padding(4)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .lineLimit(3)
        }
    }
}
