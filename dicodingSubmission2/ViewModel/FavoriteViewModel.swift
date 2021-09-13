//
//  CoreDataViewModel.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 08/09/21.
//

import CoreData

class FavoriteViewModel: ObservableObject {
    let manager = CoreDataManager.shared
    @Published var gameData: [GameData] = []
    @Published var gameGenres: [GameGenres] = []
    @Published var gameTags: [GameTags] = []
    init() {
        getData()
    }
    func containsId(_ id: Int32) -> Bool {
        let data = gameData.contains { $0.id == id }
        return data
    }
    func getData() {
        let request = NSFetchRequest<GameData>(entityName: "GameData")
        do {
            gameData = try manager.context.fetch(request)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    func getGenres(of name: String) {
        let request = NSFetchRequest<GameGenres>(entityName: "GameGenres")
        let filter = NSPredicate(format: "gameData.name == %@", name)
        request.predicate = filter
        do {
            gameGenres = try manager.context.fetch(request)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    func getTags(of name: String) {
        let request = NSFetchRequest<GameTags>(entityName: "GameTags")
        let filter = NSPredicate(format: "gameData.name == %@", name)
        request.predicate = filter
        do {
            gameTags = try manager.context.fetch(request)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    func addData(data: Results) {
        let newData = GameData(context: manager.context)
        newData.id = Int32(data.id)
        newData.name = data.name
        newData.rating = data.rating
        newData.released = data.released
        newData.backgroundImage = data.backgroundImage
        let genres: [GameGenres] = data.genres.map({
            let genre = GameGenres(context: manager.context)
            genre.id = Int32($0.id)
            genre.name = $0.name
            return genre
        })
        newData.genres = NSSet(array: genres)
        let tags: [GameTags] = data.tags.map({
            let tag = GameTags(context: manager.context)
            tag.id = Int32($0.id)
            tag.name = $0.name
            return tag
        })
        newData.tags = NSSet(array: tags)
        save()
    }
    func deleteData(of id: Int32) {
        let data = gameData.first { $0.id == id }
        guard let getData = data else {
            return
        }
        manager.context.delete(getData)
        save()
    }
    func save() {
        self.manager.save()
        self.getData()
    }
}
