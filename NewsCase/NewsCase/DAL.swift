//
//  DAL.swift
//  NewsCase
//
//  Created by burak ozen on 22.02.2022.
//

import Foundation
import CoreData
import UIKit

class DAL {
    
    static func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    static func saveData(title: String, author: String, newsdate: String, explain: String, newsimage: String, setfavorite: Bool, weburl: String) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        
        let data = NSManagedObject(entity: entity!, insertInto: context)
        
        data.setValue(title, forKey: "title")
        data.setValue(author, forKey: "author")
        data.setValue(newsdate, forKey: "newsdate")
        data.setValue(explain, forKey: "explain")
        data.setValue(newsimage, forKey: "newsimage")
        data.setValue(setfavorite, forKey: "setfavorite")
        data.setValue(weburl, forKey: "weburl")
        

        do{
            try context.save()
        } catch {}
        
    }
    
    static func getAllData() -> [News]? {
        
        let fetchRequest : NSFetchRequest<News> = News.fetchRequest()
        
        do {
            return try getContext().fetch(fetchRequest)
        } catch {
            
        }
        return nil
        
    }
    
    static func update() {
        
        try? getContext().save()
    }
    
    //delete func will be add
    static func deleteFunc(data: News){
        
        getContext().delete(data)
        
        try? getContext().save()
    }
    
    
    
    
}
