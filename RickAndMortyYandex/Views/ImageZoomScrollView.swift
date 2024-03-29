//
//  SceneDelegate.swift
//  RickAndMortyYandex
//
//  Created by Роберт Згонников on 14.06.2022.
//

import UIKit

final class ImageZoomScrollView: UIScrollView, UIScrollViewDelegate {
    
    // MARK: Fields
   public var imageZoomView: UIImageView!
        
    private lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .bg
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
        
        configurateFor(imageSize: image.size)
        centerImage()
        imageZoomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageZoomView.topAnchor.constraint(equalTo: self.topAnchor),
            imageZoomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageZoomView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            
        ])
        
    }
    
    private func configurateFor(imageSize: CGSize) {
        self.contentSize = imageSize
        
        setCurrentMaxandMinZoomScale()
        self.zoomScale = self.minimumZoomScale
        
        self.imageZoomView.addGestureRecognizer(self.zoomingTap)
        self.imageZoomView.isUserInteractionEnabled = true
        
    }
    
    private func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = imageZoomView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        imageZoomView.frame = frameToCenter
    }
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    private func zoom(point: CGPoint, animated: Bool) {
        let currectScale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currectScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.animatableData)
    }
        
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
    
    func imageUnzoomable() {
        self.maximumZoomScale = self.minimumZoomScale
        self.zoomScale = self.minimumZoomScale
    }
    
    func setCurrentMaxandMinZoomScale() {
        let boundsSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        let xScale = boundsSize.width / imageSize.width
        self.minimumZoomScale = xScale
        self.maximumZoomScale = 3
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerImage()
    }
    
}
