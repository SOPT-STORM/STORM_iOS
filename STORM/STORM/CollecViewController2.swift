//
//  CollecViewController2.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/05.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
let kRoomCellScaling: CGFloat = 0.6

class CollecViewController2: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // This method sets up the collection view
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal

        layout.sideItemAlpha = 1
        layout.sideItemScale = 0.8
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60)

        collectionView?.setCollectionViewLayout(layout, animated: false)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)



        // Configure the cell
        switch indexPath.row%3 {

        case 0:
            cell.backgroundColor = UIColor.red
        case 1:
            cell.backgroundColor = UIColor.black
        case 2:
            cell.backgroundColor = UIColor.blue
        default:
            break
        }

        return cell
    }
}

public enum UPCarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

public class UPCarouselFlowLayout: UICollectionViewFlowLayout {

    private struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        func isEqual(otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }

    @IBInspectable public var sideItemScale: CGFloat = 0.757//0.757
    @IBInspectable public var sideItemAlpha: CGFloat = 0.5
    public var spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 5)

    private var state = LayoutState(size: .zero, direction: .horizontal)

    // Tells the layout object to update the current layout.
    override public func prepare() {
        super.prepare()
        
        print("prepare 실행")
        print(self.collectionView!.bounds.size, self.scrollDirection)
        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)

        if !self.state.isEqual(otherState: currentState) {
            print("실행2")
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }

    private func setupCollectionView() {
//        guard let collectionView = self.collectionView else { return }
//        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
//            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
//        }
    }

    private func updateLayout() {
        guard let collectionView = self.collectionView else { return }

        let collectionSize = collectionView.bounds.size
//        let isHorizontal = (self.scrollDirection == .horizontal)

        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let side = self.itemSize.width
        let scaledItemOffset =  (side - side*self.sideItemScale) / 2
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = xInset
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }

    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // Returns the layout attributes for all of the cells and views in the specified rectangle.
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }

    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
//        let isHorizontal = (self.scrollDirection == .horizontal)

        let collectionCenter = collectionView.frame.size.width/2
        let offset = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x - offset

        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        var test = Float()
        
//        if normalizedCenter < distance * 3 + 5 {
//            test = normalizedCenter
//        }
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
//        print(maxDistance, distance)
        print(offset, normalizedCenter, distance, abs(collectionCenter - normalizedCenter), ratio, scale  )
        print("scale \(ratio) \(scale) \(self.sideItemScale)")
        
        return attributes
    }
    
//    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        guard let collectionView = collectionView, !collectionView.isPagingEnabled,
//            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
//            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
//
//        let isHorizontal = (self.scrollDirection == .horizontal)
//
//        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
//        let proposedContentOffsetCenterOrigin = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
//
//        var targetContentOffset: CGPoint
//        if isHorizontal {
//            let closest = layoutAttributes.sort { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
//            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
//        }
//        else {
//            let closest = layoutAttributes.sort { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
//            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
//        }
//
//        return targetContentOffset
//    }
    
    /*
     You can translate your items to a small negative z value based on distance from center.

     Replace this line:
     
     attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
     
     let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
     let dist = CGRectGetMidX(attributes.frame) - CGRectGetMidX(visibleRect)
     var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
     transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
     attributes.transform3D = transform
     
     */
    
    
}
