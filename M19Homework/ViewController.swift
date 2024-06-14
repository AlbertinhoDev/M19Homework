import UIKit
import SnapKit

enum listButton {
    case none
    case searchAndPopularButton
    case tableChoose
}

class ViewController: UIViewController {
    
    var chooseButton: listButton = .none
    
    private lazy var textField = ViewElements().textField
    private lazy var searchButton = ViewElements().searchButton
    private lazy var popularButton = ViewElements().popularButton
    private lazy var stateLabel = ViewElements().stateLabel
    var tableView = ViewElements().tableView
    
    let cellLabelAndImage = "cellLabelAndImage"
    
    
    let apiKeys = ["X-API-KEY" : "5a1aa54a-2e6d-40b4-aa36-e6950cc441ee"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CellLabelAndImage.self, forCellReuseIdentifier: cellLabelAndImage)
//        tableView.dataSource = self
//        tableView.delegate = self
        
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
        let text = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(self.textField.text!.lowercased().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")"
        return text
    }
    
    @objc func searchPressed(sender: UIButton) {
        textField.resignFirstResponder()
        if self.textField.text!.trimmingCharacters(in: .whitespaces).isEmpty == false {
            let text = textField.text!
            stateLabel.text = "Поиск по запросу: \(text)"
            
            let searchText = searchViewData()
            self.chooseButton = .searchAndPopularButton
            alamofireProcess(text: searchText, chooseButton: chooseButton)
            
        }
    }
    
    @objc func popularPressed(sender: UIButton) {
        textField.resignFirstResponder()
        stateLabel.text = "Популярные фильмы"
        textField.text = ""
        let text = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        self.chooseButton = .searchAndPopularButton
        alamofireProcess(text: text, chooseButton: chooseButton)
        
    }
    
    private func unwrapString(string : String?) -> String{
        guard let string = string else {return ""}
        return string
    }
    
    private func unwrapInt(int : Int?) -> Int{
        guard let int = int else {return 0}
        return int
    }
    
    private func alamofireProcess(text: String, chooseButton: listButton){
        let film = text
        var dataForTable: [CellLabelAndImageModel] = []
        NetWorkWithAlamofire.shared.fetchData(text: film, apiKeys: self.apiKeys, chooseButton: chooseButton ) { result in
            switch result{
                case .success(let filmResults):
                switch chooseButton {
                case .none:
                    return
                case .searchAndPopularButton:
                    let myData = filmResults.0!
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {return}
                            let maxCount = myData.films.count
                            for i in 0...maxCount - 1 {
                                var name = unwrapString(string: myData.films[i].nameRu)
//                                var picture = myData.films[i].posterUrlPreview
//                                var id = myData.films[i].filmId
                                dataForTable.append(CellLabelAndImageModel(label: name))
                            }
                        }
                    
                case .tableChoose:
                        let myData = filmResults.1!
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else {return}
                                print(myData)
                            }
                }
                case .failure(_):
                    return
            }
        }
        //print(dataForTable)
    
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLabelAndImage) as? CellLabelAndImage
//        let viewModel = dataForTable[indexPath.row]
//        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewModel = dataForTable[indexPath.row]
//        
//        let descriptionViewController = DescriptionViewController()
//        present(descriptionViewController, animated: true, completion: nil)
//        
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
