//
//  TabCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class TabCell: UITableViewCell , UIScrollViewDelegate
{
   
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private var containerView: UIView!
    private var scrollView: UIScrollView!
    private var topBar: UIView!
    private var animatedBar: UIView!
    private var buttonTitles: [String] = ["說明","規格","保固"]
    private var buttonImages: [UIImage] = []
    private var pageViews: [UIViewController?] = []
    
    //Container view position variables
    private var xOrigin: CGFloat = 0
    private var yOrigin: CGFloat = 64
    private var distanceToBottom: CGFloat = 0
    
    //Color variables
    private var animatedBarColor = UIColor(red: 28/255, green: 95/255, blue: 185/255, alpha: 1)
    private var topBarBackground = UIColor.whiteColor()
    private var buttonsTextColor = UIColor.grayColor()
    private var containerViewBackground = UIColor.whiteColor()
    
    //Item size variables
    private var topBarHeight: CGFloat = 52
    private var animatedBarHeight: CGFloat = 3
    
    //Bar item variables
    private var aeroEffectInTopBar: Bool = false //This gives the top bap a blurred effect, also overlayes the it over the VC's
    private var buttonsWithImages: Bool = false
    private var barShadow: Bool = true
    private var buttonsTextFontAndSize: UIFont = UIFont(name: "HelveticaNeue-Light", size: 20)!
    
    // MARK: - Positions Of The Container View API -
    internal func setOriginX (origin : CGFloat) { xOrigin = origin }
    internal func setOriginY (origin : CGFloat) { yOrigin = origin }
    internal func setDistanceToBottom (distance : CGFloat) { distanceToBottom = distance }
    
    // MARK: - API's -
    internal func setAnimatedBarColor (color : UIColor) { animatedBarColor = color }
    internal func setTopBarBackground (color : UIColor) { topBarBackground = color }
    internal func setButtonsTextColor (color : UIColor) { buttonsTextColor = color }
    internal func setContainerViewBackground (color : UIColor) { containerViewBackground = color }
    internal func setTopBarHeight (pointSize : CGFloat) { topBarHeight = pointSize}
    internal func setAnimatedBarHeight (pointSize : CGFloat) { animatedBarHeight = pointSize}
    internal func setButtonsTextFontAndSize (fontAndSize : UIFont) { buttonsTextFontAndSize = fontAndSize}
    internal func enableAeroEffectInTopBar (boolValue : Bool) { aeroEffectInTopBar = boolValue}
    internal func enableButtonsWithImages (boolValue : Bool) { buttonsWithImages = boolValue}
    internal func enableBarShadow (boolValue : Bool) { barShadow = boolValue}

    
    
    override  func drawRect(rect: CGRect) {
        self.setOriginY(0.0)
        self.enableAeroEffectInTopBar(false)
        self.setButtonsTextColor(UIColor.blueColor())
        self.setAnimatedBarColor(UIColor.blueColor())
        
        // MARK: - Size Of The Container View -
        let pagesContainerHeight = self.frame.height - yOrigin - distanceToBottom
        let pagesContainerWidth = self.frame.width
        
        //Set the containerView, every item is constructed relative to this view
        containerView = UIView(frame: CGRectMake(xOrigin, yOrigin, pagesContainerWidth, pagesContainerHeight))
        containerView.backgroundColor = containerViewBackground
        self.addSubview(containerView)
        
        //Set the scrollview
        if (aeroEffectInTopBar) {
            scrollView = UIScrollView(frame: CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height))
        }
        else {
            scrollView = UIScrollView(frame: CGRectMake(0, topBarHeight, containerView.frame.size.width, containerView.frame.size.height - topBarHeight))
        }
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(scrollView)

        //Set the top bar
        topBar = UIView(frame: CGRectMake(0, 0, containerView.frame.size.width, topBarHeight))
        topBar.backgroundColor = topBarBackground
        if (aeroEffectInTopBar) {
            //Create the blurred visual effect
            //You can choose between ExtraLight, Light and Dark
            topBar.backgroundColor = UIColor.clearColor()
            let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = topBar.bounds
//            blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
            topBar.addSubview(blurView)
        }
        containerView.addSubview(topBar)
        
        //Set the top bar buttons
        var buttonsXPosition: CGFloat = 0
        var buttonNumber = 0
        for _ in buttonTitles {
            var barButton: UIButton!
            barButton = UIButton(frame: CGRectMake(buttonsXPosition, 0, containerView.frame.size.width/(CGFloat)(buttonTitles.count), topBarHeight))
            barButton.backgroundColor = UIColor.clearColor()
            barButton.titleLabel!.font = buttonsTextFontAndSize
            barButton.setTitle(buttonTitles[buttonNumber], forState: UIControlState.Normal)
            barButton.setTitleColor(buttonsTextColor, forState: UIControlState.Normal)
            barButton.tag = buttonNumber
            barButton.addTarget(self, action: "barButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            topBar.addSubview(barButton)
            buttonsXPosition = containerView.frame.size.width/(CGFloat)(buttonTitles.count) + buttonsXPosition
            buttonNumber++
        }
        
        //Set up the animated UIView
        animatedBar = UIView(frame: CGRectMake(0, topBarHeight - animatedBarHeight + 1, (containerView.frame.size.width/(CGFloat)(buttonTitles.count))*0.8, animatedBarHeight))
        animatedBar.center.x = containerView.frame.size.width/(CGFloat)(buttonTitles.count * 2)
        animatedBar.backgroundColor = animatedBarColor
        containerView.addSubview(animatedBar)
        
                
        //Defining the content size of the scrollview
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width,height: pagesScrollViewSize.height * CGFloat(buttonTitles.count))
        
    }
    
    
    internal func barButtonAction(sender: UIButton?) {
        let index: Int = sender!.tag
        _ = scrollView.frame.size
        let pagesScrollViewSize = scrollView.frame.size
        [scrollView.setContentOffset(CGPointMake(0,pagesScrollViewSize.height * (CGFloat)(index)), animated: true)]
//        println("Load Page\(index)")
    }
    
    internal func scrollViewDidScroll(scrollView: UIScrollView) {
        //The calculations for the animated bar's movements
        //The offset addition is based on the width of the animated bar (button width times 0.8)
        let scaleY = (CGFloat)(scrollView.contentOffset.y / (contentView.frame.size.height * (CGFloat)(buttonTitles.count)))
        
        let offsetAddition = (containerView.frame.size.width)*0.1
        animatedBar.frame = CGRectMake((offsetAddition + (contentView.frame.size.width * (CGFloat)(scaleY))),
            animatedBar.frame.origin.y, animatedBar.frame.size.width, animatedBar.frame.size.height);
    }
    
    

    
}
