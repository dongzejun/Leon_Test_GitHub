//
//  Leon_TagsView.swift
//  LeonCommonFunctionsDemo
//
//  Created by Leon on 2017/8/16.
//  Copyright © 2017年 Leon_. All rights reserved.
//

import UIKit

enum LeonTagsViewStyle {
    case LeonTagsViewStyle_MultiSelection
    case LeonTagsViewStyle_SingleSelection
    case LeonTagsViewStyle_NoSelection
    case LeonTagsViewStyle_DefaultSelection
}

//定义闭包类型
typealias ReturnSelectedTagTitlesArray = ([String]) ->Void

class Leon_TagsView: UIView {
    
    private var lastFrame: CGRect = CGRect()    //记录frame
    var totalHeight: CGFloat = 0.0      //标签总高度
    private var allBtnTagsArray: [UIButton] = []
    private var selectedTagTitlesArray: [String] = []
    private var ReturnSelectedTagTitlesArrayBlock: ReturnSelectedTagTitlesArray?
    //btn靠左靠右显示,默认靠左
    var isKeepRight: Bool = false
    
    //btn上文字字体
    var btnTextFont: UIFont = .systemFont(ofSize: 17)
    
    //单个btn的圆角值
    var btnCornerRadiusValue: CGFloat = 5.0
    
    //单个btn 文字左右两边距离btn左右边界的值
    var btnHorizontalPadding: CGFloat = 10.0
    
    //单个btn 文字上下两边距离btn上下边界的值
    var btnVerticalPadding: CGFloat = 5.0
    
    //btn之间的距离 (左右)
    var btnHorizontalMargin: CGFloat = 10.0
    
    //btn之间的距离 (上下)
    var btnVerticalMargin: CGFloat = 10.0
    
    //一行中，第一个tag距离左边边界的距离
    var btnLeftMargin: CGFloat = 10.0
    
    //一行中，最后一个tag距离右边边界的最小距离
    var btnRightMargin: CGFloat = 10.0
    
    //设置单个btn上字体的颜色
    var btnNormalTextColor: UIColor = .gray     //正常状态下
    var btnSelectedTextColor: UIColor = .red    //选中状态下
    var btnDefaultTextColor: UIColor = .white   //默认btn状态
    
    //btn的背景颜色
    var btnNormalBackgroundColor: UIColor = .cyan       //正常状态下
    var btnSelectedBackgroundColor: UIColor = .gray     //选中状态下
    var btnDefaultBackgroundColor: UIColor = .blue      //默认btn状态
    
    //btn的边界颜色
    var btnNormalBorderColor: UIColor = .yellow     //正常状态下
    var btnSelectedBorderColor: UIColor = .red      //选中状态下
    var btnDefaultBorderColor: UIColor = .cyan      //默认btn状态
    
    //设置 “多选” “单选” “不能点击” 状态
    var leonTagsViewStyle: LeonTagsViewStyle = .LeonTagsViewStyle_NoSelection
    
    
    //闭包回掉方法
    func ReturnSelectedTagTitlesArrayMethod(ReturnSelectedTagTitlesArrayFunction: @escaping (_ attributeType :[String])-> Void){
        ReturnSelectedTagTitlesArrayBlock = ReturnSelectedTagTitlesArrayFunction
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setTagsArray(array: [String]) {
        //防止cell重用
        for(index, view) in subviews.enumerated() {
            print("测试中...\(index) + \(view)")
            view.removeFromSuperview()
        }
        self.allBtnTagsArray.removeAll()
        self.totalHeight = 0.0
        var lastBtnRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        if isKeepRight {
            lastBtnRect = CGRect(x: self.bounds.size.width - self.btnRightMargin, y: 0, width: 0, height: 0)
        } else {
            lastBtnRect = CGRect(x: Int(self.btnLeftMargin), y: 0, width: 0, height: 0)
        }
        self.lastFrame = lastBtnRect
        
        for contentStr in array {
            setTagBtnWithTagTitle(tagTitle: contentStr, tagID: "-1")
        }
        self.setSomeTagBtnsSelected(tagTitles: self.selectedTagTitlesArray)
    }
    
    public func setTagsArray(tagsArray: [String], selectedTags: [String]) {
        self.setTagsArray(array: tagsArray)
        self.setSomeTagBtnsSelected(tagTitles: selectedTags)
    }
    
    public func setTagsArray(array: [String], selectedTagsArray: [String], defaultArray: [String]) {
        if array.count > 0 {
            self.setTagsArray(array: array)
        }
        if selectedTagsArray.count > 0 {
            self.setSomeTagBtnsSelected(tagTitles: selectedTagsArray)
        }
        if defaultArray.count > 0 {
            self.setDefaultTagBtnsAttributes(defaultTagsArray: defaultArray)
        }
    }
    
    private func setSomeTagBtnsSelected(tagTitles: [String]) {
        var tagTitleArray: [String] = tagTitles
        
        if self.selectedTagTitlesArray.count > 0 {
            tagTitleArray = self.selectedTagTitlesArray
        }
        
        for btn in self.allBtnTagsArray {
            if tagTitleArray.contains((btn.titleLabel?.text)!) {
                self.setBtnSelectedState(btn: btn)
                if self.selectedTagTitlesArray.count <= 0 {
                    self.selectedTagTitlesArray.append((btn.titleLabel?.text)!)
                }
            }
        }
    }
    
    private func setDefaultTagBtnsAttributes(defaultTagsArray: [String]) {
        
        for btn in self.allBtnTagsArray {
            if defaultTagsArray.contains((btn.titleLabel?.text)!) {
                self.setBtnDefaultState(btn: btn)
            }
        }
    }
    
    private func setTagBtnWithTagTitle(tagTitle: String, tagID: String) {
        let tagBtn: UIButton = UIButton(type: .custom)
        tagBtn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        tagBtn.contentHorizontalAlignment = .center
        tagBtn.setTitle(tagTitle as String, for: .normal)
        tagBtn.titleLabel?.font = self.btnTextFont
        tagBtn.layer.cornerRadius = CGFloat(self.btnCornerRadiusValue)
        tagBtn.layer.masksToBounds = true
        tagBtn.addTarget(self, action: #selector(tagBtnClickedAction(btn:)), for: .touchUpInside)
        
        let attribute = [NSFontAttributeName : self.btnTextFont]
        var tagTitleSize: CGSize = (tagTitle as NSString).size(attributes: attribute)
        tagTitleSize.width += CGFloat(self.btnHorizontalPadding * 2)
        tagTitleSize.height += CGFloat(self.btnVerticalPadding * 2)
        
        var tagNewRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        if isKeepRight {
            if (self.lastFrame.origin.x - tagTitleSize.width - self.btnHorizontalMargin - self.btnLeftMargin < 0) {
                tagNewRect.origin = CGPoint(x: self.bounds.size.width - self.btnRightMargin - tagTitleSize.width, y: self.lastFrame.origin.y + tagTitleSize.height + self.btnVerticalMargin)
            } else {
                let magin: CGFloat = self.lastFrame.size.width > 0 ? self.btnHorizontalMargin : 0
                tagNewRect.origin = CGPoint(x: self.lastFrame.origin.x - tagTitleSize.width - magin, y: self.lastFrame.origin.y)
            }
        } else {
            if CGFloat(self.lastFrame.origin.x) + CGFloat(self.lastFrame.size.width) + CGFloat(tagTitleSize.width) + CGFloat(self.btnHorizontalMargin) > CGFloat(self.bounds.size.width) - CGFloat(self.btnRightMargin) {
                tagNewRect.origin = CGPoint(x: CGFloat(self.btnLeftMargin), y: CGFloat(self.lastFrame.origin.y) + CGFloat(tagTitleSize.height) + CGFloat(self.btnVerticalMargin))
            } else {
                let magin: CGFloat = self.lastFrame.size.width > 0 ? self.btnHorizontalMargin : 0
                tagNewRect.origin = CGPoint(x: CGFloat(self.lastFrame.origin.x) + CGFloat(self.lastFrame.size.width) + magin, y: CGFloat(self.lastFrame.origin.y))
            }
        }
        
        tagNewRect.size = tagTitleSize
        tagBtn.frame = tagNewRect
        self.lastFrame = tagBtn.frame
        
        self.totalHeight = self.lastFrame.origin.y + self.lastFrame.height
        setHeight(view: self, height: self.totalHeight)
        setBtnNormalState(btn: tagBtn)
        self.allBtnTagsArray.append(tagBtn)
        self.addSubview(tagBtn)
    }
    
    
    @objc private func tagBtnClickedAction(btn: UIButton) {
        if self.leonTagsViewStyle == .LeonTagsViewStyle_NoSelection {
            return
        } else if self.leonTagsViewStyle == .LeonTagsViewStyle_SingleSelection {
            if self.selectedTagTitlesArray.contains((btn.titleLabel?.text)!) {
                
                let index = self.selectedTagTitlesArray.index(of: (btn.titleLabel?.text)!)
                self.selectedTagTitlesArray.remove(at: index!)
                setBtnNormalState(btn: btn)
            } else {
                for btn in self.allBtnTagsArray {
                    if self.selectedTagTitlesArray.contains((btn.titleLabel?.text)!) {
                        
                        let index = self.selectedTagTitlesArray.index(of: (btn.titleLabel?.text)!)
                        self.selectedTagTitlesArray.remove(at: index!)
                        setBtnNormalState(btn: btn)
                    }
                }
                self.selectedTagTitlesArray.append((btn.titleLabel?.text)!)
                self.setBtnSelectedState(btn: btn)
                if self.ReturnSelectedTagTitlesArrayBlock != nil{
                    self.ReturnSelectedTagTitlesArrayBlock!(self.selectedTagTitlesArray)
                }
            }
        } else if self.leonTagsViewStyle == .LeonTagsViewStyle_MultiSelection {
            if self.selectedTagTitlesArray.contains((btn.titleLabel?.text)!) {
                let index = self.selectedTagTitlesArray.index(of: (btn.titleLabel?.text)!)
                self.selectedTagTitlesArray.remove(at: index!)
                self.setBtnNormalState(btn: btn)
            } else {
                self.selectedTagTitlesArray.append((btn.titleLabel?.text)!)
                self.setBtnSelectedState(btn: btn)
            }
            if self.ReturnSelectedTagTitlesArrayBlock != nil {
                self.ReturnSelectedTagTitlesArrayBlock!(self.selectedTagTitlesArray)
            }
        } else {
            return
        }
        
    }
    //改变控件高度
    private func setHeight(view: UIView, height: CGFloat) {
        var tempFrame: CGRect = view.frame
        tempFrame.size.height = height
        view.frame = tempFrame
    }
    //设置btn正常展示属性
    private func setBtnNormalState(btn: UIButton) {
        btn.layer.borderColor = self.btnNormalBorderColor.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(self.btnNormalTextColor, for: .normal)
        btn.backgroundColor = self.btnNormalBackgroundColor
        btn.isUserInteractionEnabled = true
    }
    //设置btn选中btn属性
    private func setBtnSelectedState(btn: UIButton) {
        btn.layer.borderColor = self.btnSelectedBorderColor.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(self.btnSelectedTextColor, for: .normal)
        btn.backgroundColor = self.btnSelectedBackgroundColor
        btn.isUserInteractionEnabled = true
    }
    //设置默认btn属性
    private func setBtnDefaultState(btn: UIButton) {
        btn.layer.borderColor = self.btnDefaultBorderColor.cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(self.btnDefaultTextColor, for: .normal)
        btn.backgroundColor = self.btnDefaultBackgroundColor
        btn.isUserInteractionEnabled = false
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
