import Foundation
import UIKit
import SnapKit

// MARK: - UI Setup
class ViewElements{
    lazy var textField: UITextField = {
        let text = UITextField()
        text.placeholder = "Тут пользовательский текст"
        text.borderStyle = .roundedRect
        return text
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Поиск ", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Популярные фильмы ", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.text = ""
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableHeaderView = .none
        return tableView
    }()
    
}
// MARK: - Cell Setup
class CellLabelAndImage: UITableViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private lazy var imageViewCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
//        imageViewCell.snp.makeConstraints { make in
//            make.left.equalTo(contentView.snp.leftMargin).inset(20)
//            make.top.equalTo(contentView.snp.topMargin).inset(5)
//            make.bottom.equalTo(contentView.snp.bottomMargin).inset(5)
//        }
        label.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).inset(0)
            make.left.equalTo(contentView.snp.leftMargin).inset(0)
            make.bottom.equalTo(contentView.snp.bottomMargin).inset(0)
        }

        
    }
    
    func configure(_ viewModel: CellLabelAndImageModel){
        label.text = viewModel.label
        //imageViewCell.image = viewModel.image
    }
    
}
