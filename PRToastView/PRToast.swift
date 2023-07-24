//
//  PRToast.swift
//  PRToast
//
//  Created by Spectus Infotech on 18/07/23.
//

import Foundation
import UIKit

//MARK: -Enum
public enum GradientDirection {
    case Horizontal
    case Vertical
}

public enum ViewOpenFrom {
    case Top
    case Bottom
}

public class PRToast:UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var viewForPRToast:UIView!
    @IBOutlet weak var imgForLeft:UIImageView!
    @IBOutlet weak var imgForRight:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescripation:UILabel!
    
   
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.imgForLeft.isHidden = true
        self.imgForRight.isHidden = true
        self.imgForLeft.layer.cornerRadius = 12.5
        self.imgForRight.layer.cornerRadius = 12.5
    }
    
  //MARK: -ShowToastWith
    public static func showToastWith(title: String,descripation:String? = nil, backgroundColor : UIColor = .red, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white,leftSideImage:UIImage?,rightSideImage:UIImage?, screenTime: TimeInterval = 3.0,viewOpenFrom:ViewOpenFrom = .Bottom,gradiantColor:[CGColor] = [],gradiantColorDirection:GradientDirection = .Horizontal, dismissHandler: (()->Void)? = nil) {
        
        DispatchQueue.main.async {
            //Load View XIB
            guard let toastView = Bundle.init(for: self.classForCoder()).loadNibNamed("PRToast", owner: nil, options: nil)?[0] as? PRToast else {
                return
            }
            //MaageFrameForView
            toastView.manageFrameAndDataWith(title: title,descripations:descripation ?? "", backgroundColor: backgroundColor, bgColorAlpha: bgColorAlpha, textColor: textColor, viewOpenFrom: viewOpenFrom, rightSideImage: rightSideImage ?? UIImage(), leftSideImage: leftSideImage ?? UIImage(),gradiantColor: gradiantColor,gradiantColorDirection: gradiantColorDirection)
            toastView.alpha = 0
           
            UIApplication.shared.windows[0].addSubview(toastView)
            
            UIView.animate(withDuration: 0.3) {
                toastView.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + screenTime) {
                toastView.dismissToastView(compleion: dismissHandler)
            }
        }
    }
    
    //MARK: -ManageFrameAndDataWith
    fileprivate func manageFrameAndDataWith(title: String,descripations:String? = nil, backgroundColor : UIColor = .black, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white,viewOpenFrom:ViewOpenFrom = .Bottom,rightSideImage:UIImage?,leftSideImage:UIImage?,gradiantColor:[CGColor] = [],gradiantColorDirection:GradientDirection = .Horizontal){
        
        //SetUp Label For Title
        self.lblTitle.text = title
        self.lblTitle.numberOfLines = 2
        self.lblTitle.textColor = textColor
        self.lblTitle.sizeToFit()
        
        //SetUp For Left ImageView
        if leftSideImage != nil {
            self.imgForLeft.isHidden = false
            self.imgForLeft.image = leftSideImage
        }else {
            self.imgForLeft.isHidden = true
        }
        
        //SetUp For Right ImageView
        if rightSideImage != nil {
            self.imgForRight.isHidden = false
            self.imgForRight.image = rightSideImage
        }else {
            self.imgForRight.isHidden = true
        }
        
        var viewHeight:CGFloat = 0.0
        //SetUp Label For Descripation
        if descripations?.isEmpty ?? false {
            self.lblDescripation.isHidden = true
            viewHeight = self.lblTitle.frame.height + 36
            
        }else {
            self.lblDescripation.text = descripations
            self.lblDescripation.numberOfLines = 2
            self.lblDescripation.textColor = textColor
            self.lblDescripation.sizeToFit()
            viewHeight = self.lblTitle.frame.height  +  self.lblDescripation.frame.height + 36
        }
        
        //View Open Top OR Bottom
        if viewOpenFrom == .Top {
            self.frame = CGRect.init(x: 0, y: (UIApplication.shared.windows[0].safeAreaInsets.top != 0 ? 30 : 0), width: UIScreen.main.bounds.width, height: viewHeight)
            
        }else if viewOpenFrom == .Bottom {
            let viewFrameY = UIScreen.main.bounds.height -  (30 + (UIApplication.shared.windows[0].safeAreaInsets.top != 0 ? 30 : 0) + viewHeight * 0.7)
            self.frame = CGRect.init(x: 0, y: viewFrameY, width: UIScreen.main.bounds.width, height: viewHeight)
        }
        
        
        let cornerRadiusForView = (self.viewForPRToast.frame.size.height)/2.0
        //SetUp ViewForPRToast
        self.viewForPRToast.backgroundColor = backgroundColor
        self.viewForPRToast.setCornerRadiusWithShadow(cornerRadiusForView, shadowOpacity: 1, shadowColor: .black, shadowOffset: CGSize(width: 1.0, height: 1.0), shadowRadius: 1)
        self.viewForPRToast.GradientView(Direction: gradiantColorDirection, Colors: gradiantColor,cornerRadius: cornerRadiusForView)
    }
    
    //MARK: -DismissToastView
    func dismissToastView(compleion : (()->Void)? = nil) {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        } completion: { finished in
            compleion?()
            self.removeFromSuperview()
        }
    }
}




