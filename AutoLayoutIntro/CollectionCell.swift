import UIKit

class CollectionCell: UICollectionViewCell{
    
    var page: Page? {
        didSet{
            guard let unwrappedPage = page else {return}
            imageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n" + unwrappedPage.description, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        descriptionTextView.attributedText = attributedText
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textAlignment = .center
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isSelectable = false
        return descriptionTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topImageContainerView)
        addSubview(imageView)
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
        
        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5),
        
        descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
        descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -24),
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
