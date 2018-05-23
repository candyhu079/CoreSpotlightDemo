//
//  TableViewController.swift
//  CoreSpotlightDemo
//
//  Created by Candy on 2018/5/21.
//  Copyright © 2018年 com.CandyHu. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class TableViewController: UITableViewController {

    var contentsArray = [("雷神索爾", "《雷神索爾》（英語：Thor）是一部於2011年上映的美國超級英雄電影，根據漫威漫畫旗下超級英雄雷神索爾故事改編，驚奇工作室製作，並由派拉蒙影業發行。", "Thor.jpg"), ("美國隊長", "《美國隊長》（英語：Captain America: The First Avenger）是一部於2011年上映的美國超級英雄電影，根據漫威漫畫旗下超級英雄美國隊長故事改編，漫威工作室製作，派拉蒙影業負責發行。", "Captain.jpg"), ("鋼鐵人", "《鋼鐵人》（英語：Iron Man）是一部2008年上映的美國超級英雄電影，由強·法夫洛執導，馬克·弗格斯、霍克·奧斯比、艾特·馬柯姆與麥特·霍洛威共同編劇，劇情圍繞著漫威漫畫旗下超級英雄鋼鐵人展開。", "IronMan.jpg"), ("蜘蛛人", "《蜘蛛人：返校日》（英語：Spider-Man: Homecoming）是一部於2017年上映的美國超級英雄電影，由漫威漫畫旗下角色蜘蛛人故事改編，哥倫比亞電影公司與漫威工作室共同製片，並由索尼影視娛樂發行。", "SpiderMan.jpg"), ("浩克", "《無敵浩克》（英語：The Incredible Hulk）是一部於2008年上映的美國超級英雄電影，根據漫威漫畫旗下角色浩克故事改編，漫威工作室製作，並由環球影業發行。", "Hulk.jpg")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchableContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchableContent() {
        var coreSpotlightItems:[CSSearchableItem] = []
        
        for i in 0..<(contentsArray.count) {
            let content = contentsArray[i]
            
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            
            searchableItemAttributeSet.title = content.0
            searchableItemAttributeSet.contentDescription = content.1
            
            let tempArray = content.2.components(separatedBy: ".")
            if tempArray.count > 1 {
                searchableItemAttributeSet.thumbnailURL = Bundle.main.url(forResource: tempArray[0], withExtension: tempArray[1])
            }
            
            var keywords: [String] = []
            keywords.append(content.0)
            if tempArray.count > 0 {
                keywords.append(tempArray[0])
            }
            searchableItemAttributeSet.keywords = keywords
 
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.CandyHu.CoreSpotlightDemo.\(i)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
            
            coreSpotlightItems.append(searchableItem)
        }
        
        CSSearchableIndex.default().indexSearchableItems(coreSpotlightItems) { (error: Error?) in
            guard error == nil else {
                print("IndexSearchableItemsError: \(error.debugDescription)")
                return
            }
        }
    }
    
    func pushDetailVC(index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        guard vc != nil else {
            return
        }
        
        if contentsArray.count > index
        {
            vc!.contentInfo = contentsArray[index]
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if contentsArray.count > indexPath.row
        {
            cell.textLabel?.text = contentsArray[indexPath.row].0
            cell.detailTextLabel?.text = contentsArray[indexPath.row].1
            cell.imageView?.image = UIImage(named:contentsArray[indexPath.row].2)
            cell.imageView?.contentMode = .scaleAspectFit
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailVC(index: indexPath.row)
    }

}
