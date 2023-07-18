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
        self.viewForPRToast.layer.cornerRadius = 12.5
        self.viewForPRToast.layer.masksToBounds = true
    }
    public static func showToastWith(title: String,descripation:String, backgroundColor : UIColor = .red, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white, screenTime: TimeInterval = 3.0,showTopOrBottomSide:String, dismissHandler: (()->Void)? = nil) {
        
        DispatchQueue.main.async {
            
            guard let toastView = Bundle.init(for: self.classForCoder()).loadNibNamed("PRToast", owner: nil, options: nil)?[0] as? PRToast else {
                return
            }
            
            toastView.manageFrameAndDataWith(title: title,descripations:descripation, backgroundColor: backgroundColor, bgColorAlpha: bgColorAlpha, textColor: textColor,showTopOrBottomSide:showTopOrBottomSide)
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
    
    fileprivate func manageFrameAndDataWith(title: String,descripations:String, backgroundColor : UIColor = .black, bgColorAlpha: CGFloat = 0.7, textColor: UIColor = .white,showTopOrBottomSide:String){
        
        self.lblTitle.text = title
        self.lblTitle.numberOfLines = 2
        self.lblTitle.textColor = textColor
        self.viewForPRToast.backgroundColor = backgroundColor.withAlphaComponent(bgColorAlpha)
        self.lblTitle.sizeToFit()
        
        var viewHeight:CGFloat = 0.0
        if descripations.isEmpty {
            self.lblDescripation.isHidden = true
            let viewHeight = self.lblTitle.frame.height + 36

        }else {
            self.lblDescripation.text = descripations
            self.lblDescripation.numberOfLines = 2
            self.lblDescripation.textColor = textColor
            self.lblDescripation.sizeToFit()
            let viewHeight = self.lblTitle.frame.height + 36 + self.lblDescripation.frame.height

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
