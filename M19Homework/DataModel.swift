import Foundation

//MARK: Модель для Таблицы
struct QuereForTable: Decodable {
    var films: [Films] = []
}

struct Films: Decodable {
    var nameRu: String? //название
    var filmId: Int? //id фильма
    var posterUrlPreview: String? //постер
}

//MARK: Модель для конкретного фильма
struct QuereForDescription: Decodable {
    var ratingKinopoisk: Int? //рейтинг кинопоиск
    var ratingImdb: Int? //рейтинг imdb
    var nameRu: String? //название
    var nameOriginal: String? //название
    var description: String? //описание
    var year: Int? //год производства
    var filmLength: Int? //продолжительность в минутах
    var posterUrlPreview: String? //постер
}
