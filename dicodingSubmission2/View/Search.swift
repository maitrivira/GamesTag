//
//  Search.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 07/09/21.
//

import SwiftUI

struct Search: View {
    @ObservedObject var viewModel: SearchViewModel
    var body: some View {
        NavigationView {
            VStack {
              SearchBar(searchTerm: $viewModel.searchTerm)
              if viewModel.games.isEmpty {
                EmptyStateView()
              } else {
                List(viewModel.games) { game in
                    ZStack {
                        GameView(result: game)
                    }
                }
                .listStyle(PlainListStyle())
              }
            }
            .navigationBarTitle("Game Search", displayMode: .inline)
        }
    }
}

struct GameView: View {
  @ObservedObject var result: ResultsViewModel
  var body: some View {
    HStack {
        ArtworkView(image: result.backgroundImage)
        VStack(alignment: .leading) {
            Text(result.name)
            Text(result.released)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    .padding()
  }
}

struct ArtworkView: View {
  let image: Image?
  var body: some View {
    ZStack {
      if image != nil {
        image?.resizable()
      } else {
        Color(.systemIndigo)
        Image(systemName: "doc.fill")
          .font(.largeTitle)
          .foregroundColor(.white)
      }
    }
    .frame(width: 50, height: 50)
    .clipShape(Circle())
    .shadow(radius: 5)
    .padding(.trailing, 5)
  }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "doc.fill")
                .font(.system(size: 60))
                .padding(.bottom)
                .foregroundColor(Color("Green"))
            Text("Start search for game")
                .font(.title3)
                .foregroundColor(Color("Green"))
            Spacer()
        }
        .padding()
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    @Binding var searchTerm: String
    func makeUIView(context: Context) -> UISearchBar {
      let searchBar = UISearchBar(frame: .zero)
      searchBar.delegate = context.coordinator
      searchBar.searchBarStyle = .minimal
      searchBar.placeholder = "Type game name..."
      return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    func makeCoordinator() -> SearchBarCoordinator {
      return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
      @Binding var searchTerm: String
      init(searchTerm: Binding<String>) {
        self._searchTerm = searchTerm
      }
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked")
        searchTerm = searchBar.text ?? ""
        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
      }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(viewModel: SearchViewModel())
    }
}
