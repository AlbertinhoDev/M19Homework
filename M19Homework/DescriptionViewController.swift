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
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        
    }
    
    
    
}
