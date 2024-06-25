import Foundation
import UIKit
import SnapKit

class DescriptionViewController: UIViewController {
     
    var kinopoiskValue = ""
    var imdbValue = ""
    var ruName = ""
    var enName = ""
    var ruDescription = ""
    var year = ""
    var duration = ""
    var image = UIImage()
        
    private lazy var kinopoiskLabel: UILabel = {
        let label = UILabel()
        label.text = "Kinopoisk"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "IMBD"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "Год производства"
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "Продолжительность"
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private lazy var kinopoiskValueLabel: UILabel = {
        let label = UILabel()
        label.text = kinopoiskValue
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var imdbValueLabel: UILabel = {
        let label = UILabel()
        label.text = imdbValue
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var ruNameLabel: UILabel = {
        let label = UILabel()
        label.text = ruName
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var enNameLabel: UILabel = {
        let label = UILabel()
        label.text = enName
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private lazy var ruDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ruDescription
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yearValueLabel: UILabel = {
        let label = UILabel()
        label.text = year
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var durationValueLabel: UILabel = {
        let label = UILabel()
        label.text = duration
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        var oneThirdScreenWidth = UIScreen.main.bounds.width / 4
        
        setupView()
        setupConstraints(oneThirdScreenWidth: oneThirdScreenWidth)
    }
    
    private func setupConstraints(oneThirdScreenWidth: Double){
        ruNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.bottomMargin).inset(-30)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        enNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(ruNameLabel.snp.bottomMargin).inset(-10)
        }
        
        ruDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(enNameLabel.snp.bottomMargin).inset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).inset(40)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(ruDescriptionLabel.snp.bottomMargin).inset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(10)
        }
        
        yearValueLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottomMargin).inset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(10)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(yearValueLabel.snp.bottomMargin).inset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(10)
        }
        
        durationValueLabel.snp.makeConstraints { make in
            make.top.equalTo(durationLabel.snp.bottomMargin).inset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(10)
        }
        
        kinopoiskLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).inset(oneThirdScreenWidth)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(20)
        }
        
        kinopoiskValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).inset(oneThirdScreenWidth)
            make.top.equalTo(kinopoiskLabel.snp.bottomMargin).inset(-20)
        }
        
        imdbLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).inset(oneThirdScreenWidth)
            make.top.equalTo(kinopoiskValueLabel.snp.bottomMargin).inset(-20)
        }
        
        imdbValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.rightMargin).inset(oneThirdScreenWidth)
            make.top.equalTo(imdbLabel.snp.bottomMargin).inset(-20)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.leftMargin).inset(oneThirdScreenWidth)
            make.width.equalTo(150)
            make.height.equalTo(250)
        }
    }
    
    private func setupView(){
        view.addSubview(ruNameLabel)
        view.addSubview(enNameLabel)
        view.addSubview(ruDescriptionLabel)
        view.addSubview(yearLabel)
        view.addSubview(yearValueLabel)
        view.addSubview(durationLabel)
        view.addSubview(durationValueLabel)
        view.addSubview(kinopoiskLabel)
        view.addSubview(kinopoiskValueLabel)
        view.addSubview(imdbLabel)
        view.addSubview(imdbValueLabel)
        view.addSubview(imageView)
    }
    
    
}
