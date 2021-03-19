//
//  Model.swift
//  Youtube Clone
//
//  Created by Dandy Ferdiansyah on 15/03/21.
//

import Foundation

protocol ModelDelegate {
    
    func videoFatchead(_ videos: [Video])
}

class Model {
    
    var delegate: ModelDelegate?
    
    // buat fungsi untuk ngambil data dari youtube API
    func getVideos(){
        // simpan url ke dalam varibael
        let url = URL (string: Constants.API_URL)
        
        // kita cek urlnya kosong gak?
        guard url != nil else{
            return
        }
        
        // mendapatkan URLSession dari object
        let session = URLSession.shared
        
        // mendapatkan data dari URLSession
        let dataTask = session.dataTask(with: url!){ (data, response, error) in
            
            // cek kalau ada error
            if error != nil || data == nil{
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil{
                    DispatchQueue.main.async {
                        self.delegate?.videoFatchead(response.items!)
                    }
                }
                
                dump(response)
            }
            catch{
            }
        }
        
        dataTask.resume()
    }
}
