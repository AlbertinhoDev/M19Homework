import UIKit
import SnapKit

enum listButton {
    case none
    case searchAndPopularButton
    case tableChoose
}

class ViewController: UIViewController {
    
    private var dataForTable = [CellLabelAndImageModel]()
    
    var chooseButton: listButton = .none
    
    private lazy var textField = ViewElements().textField
    private lazy var searchButton = ViewElements().searchButton
    private lazy var popularButton = ViewElements().popularButton
    private lazy var stateLabel = ViewElements().stateLabel
    var tableView = ViewElements().tableView
    let cellLabelAndImage = "cellLabelAndImage"
    let apiKeys = ["X-API-KEY" : "5a1aa54a-2e6d-40b4-aa36-e6950cc441ee"]
    let dispatchGroup = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    
    var nameRu: String = ""
    var nameOriginal: String = ""
    var descriptionText: String = ""
    var ratingKinopoisk: Double = 0.0
    var ratingImdb: Double = 0.0
    var year: Int = 0
    var filmLength: Int = 0
    var imageURL: String = ""
    var imagePoster: UIImage = UIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CellLabelAndImage.self, forCellReuseIdentifier: cellLabelAndImage)
        tableView.dataSource = self
        tableView.delegate = self
        textField.delegate = self
        setupView()
        setupConstraints()
        searchButton.addTarget(self, action: #selector(searchPressed(sender:)), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(popularPressed(sender:)), for: .touchUpInside)
    }
    
    private func setupView() {
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(popularButton)
        view.addSubview(stateLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview().inset(20)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottomMargin).inset(-20)
            make.centerXWithinMargins.equalTo(self.view)
        }
        popularButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottomMargin).inset(-20)
            make.centerXWithinMargins.equalTo(self.view)
        }
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(popularButton.snp.bottomMargin).inset(-40)
            make.left.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottomMargin).inset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func searchViewData() -> String {
        let text = self.textField.text!
        let searchText = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(text.lowercased().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")"
        return searchText
    }
    
    @objc func searchPressed(sender: UIButton) {
        dataForTable = [CellLabelAndImageModel]()
        textField.resignFirstResponder()
        
        if self.textField.text!.trimmingCharacters(in: .whitespaces).isEmpty == false {
            let text = textField.text!
            stateLabel.text = "Поиск по запросу: \(text)"
            let searchText = searchViewData()
            self.chooseButton = .searchAndPopularButton
            alamofireProcess(text: searchText, chooseButton: chooseButton)
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func popularPressed(sender: UIButton) {
        dataForTable = [CellLabelAndImageModel]()
        textField.resignFirstResponder()
        
        stateLabel.text = "Популярные фильмы"
        textField.text = ""
        let text = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        self.chooseButton = .searchAndPopularButton
        alamofireProcess(text: text, chooseButton: chooseButton)
        
        self.dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    
    private func unwrapString(string : String?) -> String{
        guard let string = string else {return ""}
        return string
    }
    
    private func unwrapInt(int : Int?) -> Int{
        guard let int = int else {return 0}
        return int
    }
    
    private func unwrapDouble(double : Double?) -> Double{
        guard let double = double else {return 0}
        return double
    }
    
    private func loadImage(urlString: String) -> UIImage?  {
        var imageForReturn: UIImage?
        let url = URL(string: urlString)!
        self.dispatchGroup2.enter()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("При запросе возникла ошибка")
                return
            }
            if let data = data {
                imageForReturn = UIImage(data: data)
            }
            self.dispatchGroup2.leave()
        }
        task.resume()
        dispatchGroup2.wait()
        return imageForReturn
    }
    
    private func alamofireProcess(text: String, chooseButton: listButton){
        let film = text
        dispatchGroup.enter()
        NetWorkWithAlamofire.shared.fetchData(text: film, apiKeys: self.apiKeys, chooseButton: chooseButton ) { [self] result in
            switch result{
                case .success(let filmResults):
                switch chooseButton {
                case .none:
                    return
                case .searchAndPopularButton:
                    let myData = filmResults.0!
                        let maxCount = myData.films.count
                        for i in 0...maxCount - 1 {
                            var name = self.unwrapString(string: myData.films[i].nameRu)
                            var id = self.unwrapInt(int: myData.films[i].filmId)
                            var imageURL = self.unwrapString(string: myData.films[i].posterUrlPreview)
                            var image = self.loadImage(urlString: imageURL)
                            if name != "" {
                                self.dataForTable.append(CellLabelAndImageModel(name: name, image: image!, id: id))
                            }
                        }
                    dispatchGroup.leave()
                case .tableChoose:
                    let myData = filmResults.1!
                    nameRu = unwrapString(string: myData.nameRu)
                    nameOriginal = unwrapString(string: myData.nameOriginal)
                    descriptionText = unwrapString(string: myData.description)
                    ratingKinopoisk = unwrapDouble(double: myData.ratingKinopoisk)
                    ratingImdb = unwrapDouble(double: myData.ratingImdb)
                    year = unwrapInt(int: myData.year)
                    filmLength = unwrapInt(int: myData.filmLength)
                    imageURL = unwrapString(string: myData.posterUrlPreview)
                    imagePoster = self.loadImage(urlString: imageURL) ?? UIImage()
                    
                    dispatchGroup.leave()
                }
                case .failure(_):
                    self.dispatchGroup.leave()
                    return
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLabelAndImage) as? CellLabelAndImage
        let viewModel = dataForTable[indexPath.row]
        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = dataForTable[indexPath.row]
        let id = viewModel.id
        let text = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)"
        self.chooseButton = .tableChoose
        
        alamofireProcess(text: text, chooseButton: chooseButton)
        
        dispatchGroup.notify(queue: .main) {
            print(self.nameRu)
            lazy var descriptionViewController = DescriptionViewController()
            
            descriptionViewController.ruName = self.nameRu
            descriptionViewController.duration = "\(self.filmLength) мин."
            descriptionViewController.enName = self.nameOriginal
            descriptionViewController.imdbValue = "\(self.ratingImdb)"
            descriptionViewController.kinopoiskValue = "\(self.ratingKinopoisk)"
            descriptionViewController.year = "\(self.year)"
            descriptionViewController.ruDescription = self.descriptionText
            descriptionViewController.image = self.imagePoster
            
            
//            print(descriptionViewController.ruName)
//            print(descriptionViewController.duration)
//            print(descriptionViewController.enName)
//            print(descriptionViewController.imdbValue)
//            print(descriptionViewController.kinopoiskValue)
//            print(descriptionViewController.year)
//            print(descriptionViewController.ruDescription)
//            print(descriptionViewController.image)
        
            
            self.present(descriptionViewController, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: false)

        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

}

