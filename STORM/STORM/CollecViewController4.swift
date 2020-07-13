//
//  CollecViewController4.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/06.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

class CollecViewController4: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var botConstOfMemo: NSLayoutConstraint!
    
    fileprivate var colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow ,UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.black, UIColor.red, UIColor.green]
    
    var botConst: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCollectionView()

        slider.value = 0
//        slider.maximumValue = Float(collectionView.collectionViewLayout.collectionViewContentSize.width)
//        print("collection. \(collectionView.collectionViewLayout.collectionViewContentSize.width)")
        slider.maximumValue = 550
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        botConst = botConstOfMemo.constant
        
        toolbarSetup()
        
        // 스크롤 시 빠르게 감속 되도록 설정, extension UIScrollViewDelegate
        
//        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        
    }
    
    @IBAction func slide(_ sender: UISlider) {

        collectionView.contentOffset.x = CGFloat(sender.value)
//        print("sender.value \(sender.value)")
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            botConstOfMemo.constant = keyboardHeight + 81
        }
    }
    
    func toolbarSetup() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 38)
        toolbar.barTintColor = UIColor.white
                
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
        let btnImg = UIImage.init(named: "Input_keyboard_icn")!.withRenderingMode(.alwaysOriginal)
        
        let hideKeybrd = UIBarButtonItem(image: btnImg, style: .done, target: self, action: #selector(hideKeyboard))

        toolbar.setItems([flexibleSpace, hideKeybrd], animated: true)
//        memoView.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard(_ sender: Any){
        self.view.endEditing(true)
        botConstOfMemo.constant = botConst
        print(botConstOfMemo.constant)
       }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let currentIndex:CGFloat = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
//        
//           pageControl.currentPage = Int(currentIndex)
        
        //
        
        
//        var visibleRect = CGRect()
//
//        visibleRect.origin = collectionView.contentOffset
//        visibleRect.size = collectionView.bounds.size
//
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//
//        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
//
//        print(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        slider.value = Float(scrollView.contentOffset.x)
    }
    
    func addCollectionView(){

            // This is just an utility custom class to calculate screen points
            // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        
//            let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)

            // This is where the magic is done. With the flow layout the views are set to make costum movements. See https://github.com/ink-spot/UPCarouselFlowLayout for more info
            
        let layout = UPCarouselFlowLayout()
        
            // This is used for setting the cell size (size of each view in this case)
            // Here I'm writting 400 points of height and the 73.33% of the height view frame in points.
//        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.63333), height: collectionView.frame.size.height) // 0.73333
        
        layout.itemSize = CGSize(width: collectionView.frame.size.width*0.811, height: collectionView.frame.size.height) // 0.73333
        
            // Setting the scroll direction
        
            layout.scrollDirection = .horizontal
        
            layout.sideItemScale = 0.849//0.757
            layout.sideItemAlpha = 0.5
        

            // Collection view initialization, the collectionView must be
            // initialized with a layout object.
        
//            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
            collectionView.collectionViewLayout = layout
        
            // This line if for able programmatic constrains.
            self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
            // CollectionView delegates and dataSource:
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self
            // Registering the class for the collection view cells
            self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: "cellId")

            // Spacing between cells:
            let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        
//            spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: -50)
            
            spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: -200) //170

//            self.collectionView?.backgroundColor = UIColor.gray
            self.view.addSubview(self.collectionView!)

        }

}


extension CollecViewController4: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CardCell

        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    //
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionat section: Int) -> CGFloat {
//        return 0
//    }
    
    //
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let pageWidth: Float = Float(self.collectionView.frame.width / 10) //480 + 50
//        // width + space
//        let currentOffset: Float = Float(scrollView.contentOffset.x)
//        let targetOffset: Float = Float(targetContentOffset.pointee.x)
//        var newTargetOffset: Float = 0
//        if targetOffset > currentOffset {
//            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
//        }
//        else {
//            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
//        }
//        if newTargetOffset < 0 {
//            newTargetOffset = 0
//        }
//        else if (newTargetOffset > Float(scrollView.contentSize.width)){
//            newTargetOffset = Float(Float(scrollView.contentSize.width))
//        }
//
//        targetContentOffset.pointee.x = CGFloat(currentOffset)
//        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
//
//    }
    

    
    
}

//class CardCell: UICollectionViewCell {
//    
//    let customView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 12
//        return view
//    }()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addSubview(self.customView)
//
//        self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
//        self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

//class RelativeLayoutUtilityClass {
//
//    var heightFrame: CGFloat?
//    var widthFrame: CGFloat?
//
//    init(referenceFrameSize: CGSize){
//        heightFrame = referenceFrameSize.height
//        widthFrame = referenceFrameSize.width
//    }
//
//    func relativeHeight(multiplier: CGFloat) -> CGFloat{
//
//        return multiplier * self.heightFrame!
//    }
//
//    func relativeWidth(multiplier: CGFloat) -> CGFloat{
//        return multiplier * self.widthFrame!
//
//    }
//}

extension CollecViewController4: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        print("콜렉션뷰 컨텐트 사이즈 \(layout.collectionViewContentSize)")
        
        // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
        // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
    
        // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.

        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        
        // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
