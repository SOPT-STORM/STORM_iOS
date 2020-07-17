//
//  CarouselFlowLayout.swift
//  STORM
//
//  Created by seunghwan Lee on 2020/07/17.
//  Copyright © 2020 Team STORM. All rights reserved.
//

import UIKit

public enum CarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

class CarouselFlowLayout: UICollectionViewFlowLayout {

    private struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        func isEqual(otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }

    @IBInspectable public var sideItemScale: CGFloat = 0.849//0.757
    @IBInspectable public var sideItemAlpha: CGFloat = 0.5
    public var spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: 5)

    private var state = LayoutState(size: .zero, direction: .horizontal)

    override public func prepare() {
        super.prepare()
        
        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)

        if !self.state.isEqual(otherState: currentState) {

//            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }

    private func updateLayout() {
        guard let collectionView = self.collectionView else { return }

        let collectionSize = collectionView.bounds.size
        
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
        print("미니멈 라인 스페이싱\(self.minimumLineSpacing)")
    }
    
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
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
        
//        print(attributes,attributes.center.x)
//        print(collectionCenter,offset,normalizedCenter)

        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
//        if normalizedCenter < distance * 3 + 5 {
//            test = normalizedCenter
//        }
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        attributes.alpha = alpha
        
        print("maxDistance: \(maxDistance), 절대값: \(abs(collectionCenter - normalizedCenter))")
        print("레이시오 \(ratio) \(scale)")
        
//        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
//        print(maxDistance, distance)
//        print(offset, normalizedCenter, distance, abs(collectionCenter - normalizedCenter), ratio, scale  )
//        print("scale \(ratio) \(scale) \(self.sideItemScale)")
        
        return attributes
    }
}
    
