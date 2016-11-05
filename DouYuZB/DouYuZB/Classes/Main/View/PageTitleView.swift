//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by Xiaoyue on 2016/10/23.
//  Copyright © 2016年 李运洋. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView, selectedIndex : Int)
}

//MARK:-定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,119,0)
class PageTitleView: UIView {

    //MARK:-定义属性
     var titles : [String]
     var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    //MARK:-懒加载
    
  fileprivate  lazy var  titleLabels : [UILabel] = [UILabel]()
  fileprivate  lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
   fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    fileprivate lazy var bottomLine : UIView = {
       let bottomLine = UIView()
       bottomLine.backgroundColor = UIColor.lightGray
        return bottomLine
    }()
    
    //MARK:-自定义构造函数
    init(frame: CGRect,titles : [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:-设置UI
extension PageTitleView{
    
    func setupUI() {
        //不需要调整scrollView的内边距
        
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加标题
        setupTitleLabels()
        
        //设置底线和滚动滑块
    }
    
    private func setupTitleLabels(){
        
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            //创建UILabel
            let label = UILabel()
            //设置属性
            label.text = title
            label.tag  = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            //设置lable frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //添加点击时间
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(PageTitleView.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
        setupBottomLineAndScrollLine()
    }
    private func setupBottomLineAndScrollLine(){
        //添加底线
        let bottom = UIView()
        bottom.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottom.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottom)
        
        //获取第一个lable
        guard let fristLabel  =  titleLabels.first else{ return}
        fristLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height-kScrollLineH, width: fristLabel.frame.width, height: kScrollLineH)
        
    }
    
    
}

//MARK:-点击事件
extension PageTitleView{
    
    func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        //如果重复点击同一个title 直接返回
        
        //获取当前lebel的下标值
        guard let currentLabel = tapGes.view as? UILabel else{return}
        if currentLabel.tag == currentIndex {return}
        
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor     = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新的下标值
        currentIndex = currentLabel.tag
        
        //滚动条位置发生改变
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
    
}

//MARK:-对外暴露的方法
extension PageTitleView{
    
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        
        //取出sourceLablel
        let sourceLabel = titleLabels[sourceIndex]
        let targertLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
       let moveToTotalX =  targertLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX   = moveToTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //处理颜色渐变
        //取出变化的范围
        let colorDelta = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        //变化sourceLalel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //变化targetlabel
        
        targertLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //记录最新的index
        currentIndex = targetIndex
    }
    
    
}




























