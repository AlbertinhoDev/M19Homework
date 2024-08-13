import Foundation
import Alamofire

class NetWorkWithAlamofire {
    static let shared = NetWorkWithAlamofire()
    private init () {}
    
    func fetchData(text: String, apiKeys : [String:String], chooseButton: listButton,  completion: @escaping (Result < (QuereForTable?, QuereForDescription?), Error>) -> ()) {
        
        let url = URL(string: text)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiKeys
        
        AF.request(request)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                        print("При запросе возникла ошибка")
                    }
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                switch chooseButton {
                    
                case .searchAndPopularButton :
                    guard let filmResults = try? decoder.decode(QuereForTable.self, from: data) else {
                        return
                    }
                    
                    var films: QuereForDescription?
                    films = .none
                    completion(.success((filmResults, films)))
                    
                case .tableChoose:
                    guard let filmResults = try? decoder.decode(QuereForDescription.self, from: data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        print(filmResults.nameRu)
                    }
                    
                    
                    var films: QuereForTable?
                    films = .none
                    completion(.success((films, filmResults)))
                    
                case .none:
                    return
                }
            }
    }
}

