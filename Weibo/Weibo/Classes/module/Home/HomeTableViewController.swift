//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeTableViewController: BaseTableViewController {
    
    /// 表格绑定的微博数据数组
    var statusesList: [Status]? {
        didSet {
            // 刷新表格
            tableView.reloadData()
        }
    }
    
    // 定义行高缓存 [statusId: 行高]
    lazy var rowHeightCache = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupViewInfo("visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜", isHome: true)
        
        // 如果用户没有登录，直接返回
        if !userLogon {
            return
        }
        
        // 以下代码都是用户登录后才需要执行的
        setupNavigationBar()
        loadData()
        
        // 注册可重用 cell
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: "Cell")
        // 设置行高 - 如果使用缓存行高(自己计算高度)，不能设置预估行高
        //        tableView.estimatedRowHeight = 200
        // 取消分隔线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // 清空缓存，提示：NSCache 不能清空
        rowHeightCache.removeAll()
    }
    
    ///  加载微博数据
    private func loadData() {
        Status.loadStatus { (statuses, error) -> () in
            
            if error != nil {
                // 不要把错误的相信信息告诉用户，程序员应该多测试！
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
                return
            }
            
            // 提示，后续会有下拉刷新，没有新微博的情况，不要抱错！
            if statuses == nil {
                print("没有数据")
                return
            }
            
            self.statusesList = statuses
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 开启动画
        visitorView?.startAnmiation()
    }
    
    // MARK: - 表格的数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesList?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 此方法必须注册可重用cell，如果不注册，会崩溃
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StatusCell
        
        // 设置 cell
        cell.status = statusesList![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // 1. 取到对象
        let status = statusesList![indexPath.row]
        
        // 1.1 判断是否缓存了行高，如果有直接返回
        if rowHeightCache[status.id] != nil {
            return rowHeightCache[status.id]!
        }
        
        // 2. 获取 cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! StatusCell
        
        // 3. 返回行高
        let height = cell.rowHeight(status)
        rowHeightCache[status.id] = height
        return height
    }
    
    ///  显示二维码界面
    func showQRCode() {
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        presentViewController(sb.instantiateInitialViewController()!, animated: true, completion: nil)
    }
    
    /// 动画转场代理
    let popoverAnimator = PopoverAnimator()
    
    func titleButtonClicked() {
        let sb = UIStoryboard(name: "FriendGroup", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("FriendGroupSB")
        
        // 1. 设置`转场 transitioning`代理
        vc.transitioningDelegate = popoverAnimator
        // 2. 设置视图的展现大小
        let x = (view.bounds.width - 200) * 0.5
        popoverAnimator.presentFrame = CGRectMake(x, 56, 200, 300)
        // 3. 设置专场的模式 - 自定义转场动画
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    /// 设置导航条
    private func setupNavigationBar() {
        // 判断用户是否登录
        if sharedUserAccount == nil {
            return
        }
        
        // 1. 设置按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", highlightedImageName: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", highlightedImageName: nil)
        print(navigationItem.rightBarButtonItem?.customView)
        // 1.1 获取 button
        let btn = navigationItem.rightBarButtonItem!.customView as! UIButton
        // 1.2 添加 target
        btn.addTarget(self, action: "showQRCode", forControlEvents: UIControlEvents.TouchUpInside)
        
        // 2. 设置标题
        let titleButton = HomeTitleButton.button(sharedUserAccount!.name!)
        
        titleButton.addTarget(self, action: "titleButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.titleView = titleButton
    }
}
