import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    let pages: [Page] = [
        Page(imageName: "bear_first", title: "Join us today in our fun and games", description: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our store soon."),
        Page(imageName: "heart_second", title: "Subscribe and get coupons on our daily ivents.", description: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", title: "VIP members specials services.", description: ""),
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal )
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlerPrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlerPrev(){
        let prevPage = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevPage, section: 0)
        pageControl.currentPage = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal )
        button.setTitleColor( .mainPink, for: .normal)
        button.addTarget(self, action: #selector(handlerNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlerNext(){
        let nextPage = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .mainPink.withAlphaComponent(0.5)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "Item")
        collectionView.isPagingEnabled = true
    }
    
    //MARK: - methods
    
    private func setupBottomControls() {
        let bottomControlStack = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStack.distribution = .fillEqually
        bottomControlStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomControlStack)
        
        NSLayoutConstraint.activate([
            bottomControlStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStack.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(row: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! CollectionCell
        
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
