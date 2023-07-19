//
//  PRToast.swift
//  PRToast
//
//  Created by Spectus Infotech on 18/07/23.
//

import Foundation
import UIKit

public class PRToast:UIView {
    
    @IBOutlet weak var viewForPRToast:UIView!
    @IBOutlet weak var imgForLeft:UIImageView!
    @IBOutlet weak var imgForRight:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescripation:UILabel!
    
   
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.imgForLeft.isHidden = true
        self.imgForRight.isHidden = true
      //  self.viewForPRToast.layer.cornerRadius = 12.5
        //self.viewForPRToast.layer.masksToBounds = true
    }
    public static func showToastWith(title: String,descripation:String, backgroundColor : UIColor = .red, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white,leftSideImage:UIImage?,rightSideImage:UIImage?, screenTime: TimeInterval = 3.0,showTopOrBottomSide:String, dismissHandler: (()->Void)? = nil) {
        
        DispatchQueue.main.async {
            
            guard let toastView = Bundle.init(for: self.classForCoder()).loadNibNamed("PRToast", owner: nil, options: nil)?[0] as? PRToast else {
                return
            }
            
            toastView.manageFrameAndDataWith(title: title,descripations:descripation, backgroundColor: backgroundColor, bgColorAlpha: bgColorAlpha, textColor: textColor, showTopOrBottomSide:showTopOrBottomSide, rightSideImage: rightSideImage ?? UIImage(), leftSideImage: leftSideImage ?? UIImage())
            toastView.alpha = 0
        
            UIApplication.shared.windows[0].addSubview(toastView)
           // appDel.rootWindow.addSubview(toastView)

            UIView.animate(withDuration: 0.3) {
                toastView.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + screenTime) {
                toastView.dismissToastView(compleion: dismissHandler)
            }
        }
    }
    
    fileprivate func manageFrameAndDataWith(title: String,descripations:String, backgroundColor : UIColor = .black, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white,showTopOrBottomSide:String,rightSideImage:UIImage?,leftSideImage:UIImage?){
        
        self.lblTitle.text = title
        self.lblTitle.numberOfLines = 2
        self.lblTitle.textColor = textColor
        self.viewForPRToast.backgroundColor = backgroundColor.withAlphaComponent(bgColorAlpha)
        self.lblTitle.sizeToFit()
        
        
        if leftSideImage != nil {
            self.imgForLeft.isHidden = false
            self.imgForLeft.image = leftSideImage
        }else {
            self.imgForLeft.isHidden = true
        }
        if rightSideImage != nil {
            self.imgForRight.isHidden = false
            self.imgForRight.image = rightSideImage
        }else {
            self.imgForRight.isHidden = true
        }
        var viewHeight:CGFloat = 0.0
        if descripations.isEmpty {
            self.lblDescripation.isHidden = true
             viewHeight = self.lblTitle.frame.height + 36

        }else {
            self.lblDescripation.text = descripations
            self.lblDescripation.numberOfLines = 2
            self.lblDescripation.textColor = textColor
            self.lblDescripation.sizeToFit()
            viewHeight = self.lblTitle.frame.height + 36 + self.lblDescripation.frame.height

        }
        
        if showTopOrBottomSide == "Top" {
            let viewFrameY = UIScreen.main.bounds.height - (50 + (UIApplication.shared.windows[0].safeAreaInsets.top != 0 ? 30 : 0) + viewHeight * 0.7)
            self.frame = CGRect.init(x: 0, y: viewFrameY, width: UIScreen.main.bounds.width, height: viewHeight)
        }else {
            let viewFrameY = UIScreen.main.bounds.height - (50 + (UIApplication.shared.windows[0].safeAreaInsets.top != 0 ? 30 : 0) + viewHeight * 0.7)
            self.frame = CGRect.init(x: 0, y: viewFrameY, width: UIScreen.main.bounds.width, height: viewHeight)
        }
       
    }
    
    func dismissToastView(compleion : (()->Void)? = nil) {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        } completion: { finished in
            compleion?()
            self.removeFromSuperview()
        }
    }
}

class ViewCustomProperties : UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            return self.viewCornerRadius
        }set {
            self.viewCornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return self.viewShadowColor
        }set {
            self.viewShadowColor = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.viewShadowOffset
        }set {
            self.viewShadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.viewShadowOpacity
        }set {
            self.viewShadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.viewShadowRadius
        }set {
            self.viewShadowRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return self.viewBorderColor
        }set {
            self.viewBorderColor = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.viewBorderWidth
        }set {
            self.viewBorderWidth = newValue
        }
    }
    
    var viewCornerRadius : Double = 0
    var viewShadowColor = UIColor.black
    var viewShadowOffset = CGSize.zero
    var viewShadowOpacity : Float = 0
    var viewShadowRadius :  CGFloat  = 0
    var viewBorderColor = UIColor.clear
    var viewBorderWidth : CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            //Apply Radius
            self.layer.cornerRadius = self.viewCornerRadius
            self.layer.masksToBounds = true
            
            //Apply Border
            self.layer.borderColor = self.viewBorderColor.cgColor
            self.layer.borderWidth = self.viewBorderWidth
            self.layer.masksToBounds = true
            
            //Apply Shadow
            if self.viewShadowOpacity > 0 {
                self.layer.shadowColor = self.viewShadowColor.cgColor
                self.layer.shadowOffset =  self.viewShadowOffset
                self.layer.shadowOpacity = self.viewShadowOpacity
                self.layer.shadowRadius = self.viewShadowRadius
                self.layer.masksToBounds = false
            }
        }
    }
}
