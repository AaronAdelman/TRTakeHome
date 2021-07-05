//
//  TRModel.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import Foundation

class TRModel: ObservableObject {
    static let shared = TRModel()

    @Published var queryResponses: Array<TRQueryResponse> = []
    //    var total: Int = 0
    var totalQueryResponses: Int = 0
    @Published var queryString: String = ""
    @Published var error: Error?
    
    @Published var isWaitingForNewQueryResponse: Bool = false
    
//    var pageNumber = 1
    
    func update(withQueryResponse queryResponse: TRQueryResponse, queryString: String, pageNumber: Int) {
        DispatchQueue.main.async {
            if pageNumber == 1 {
                self.queryResponses.append(queryResponse)
                //            self.total         = queryResponses.total
                self.totalQueryResponses     = self.queryResponses.count
                self.queryString   = queryString
                self.error         = nil
                self.isWaitingForNewQueryResponse = false
                debugPrint(#file, #function, "Updated model")
            }
        }
    } // func update(with queryResponse: TRQueryResponse, queryString: String)
    
    func update(withError error: Error) {
        DispatchQueue.main.async {
            self.error = error
            self.isWaitingForNewQueryResponse = false
        }
    }
    
    func isLastHit(_ index: Int) -> Bool {
        if index == self.queryResponses.count - 1 {
            return true
        }
        
        return false
    }
    
    func getFirstPage(queryString: String) {
//        self.pageNumber = 1
        self.queryString = queryString
        self.query(queryString, pageNumber: 1)
    }
    
    func getNextPage() {
//        let totalPages = Int(ceil(Double(total) / Double(totalQueryResponses)))
//        let newPageNumber = pageNumber + 1
//        debugPrint(#file, #function, "Total:", total, "Total hits:", totalQueryResponses, "Total pages:", totalPages, "New page number:", newPageNumber)
//        if newPageNumber > totalPages {
//            // Weird things happen if we ask for nonexistent pages
//            return
//        }
//
//        pageNumber = newPageNumber
        
        let pageNumber = self.queryResponses.count + 1
        self.query(queryString, pageNumber: pageNumber)
    }
    
    func query(_ queryString: String, pageNumber: Int) {
        defer {
//            self.update(withError: false)
        } // defer
        
        let baseURLString = "https://www.tipranks.com/api/news/posts"
        let tweakedQueryString = queryString.replacingOccurrences(of: " ", with: "+")
        let urlString = "\(baseURLString)?page=\(pageNumber)&per_page=20&search=\(tweakedQueryString)"
        debugPrint(#file, #function, "Query:", queryString, "Page number:", pageNumber, "URL:", urlString)
        let url = URL(string: urlString)
        if url != nil {
            let session = URLSession.shared
            let task = session.dataTask(with: url!, completionHandler: {
                data, response, error
                in
//                debugPrint(#file, #function, "URL:", url as Any, "Data:", data as Any, "Response:", response as Any, "Error:", error as Any)
                DispatchQueue.main.async {
                    self.isWaitingForNewQueryResponse = false
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(error: error!)
                    return
                }
                
                if data == nil {
                    // Nothing to decode!
                    debugPrint(#file, #function, "Nothing to decode!")
                    return
                }
                
                let newJSONDecoder = JSONDecoder()
                if let queryResponse = try? newJSONDecoder.decode(TRQueryResponse.self, from: data!) {
//                    debugPrint(#file, #function, queryResponse, queryString)
                    
                    self.update(withQueryResponse: queryResponse, queryString: queryString, pageNumber: pageNumber)
                } else {
                    debugPrint(#file, #function, "Could not decode query response!")
                }
            })
            DispatchQueue.main.async {
                self.isWaitingForNewQueryResponse = true
            }
            task.resume()
        } else {
            debugPrint(#file, #function, "URL for “\(urlString)” was nil!")
        }
    } // public func query(_ queryString: String)
    
    func handleServerError(error: Error) {
        debugPrint(#file, #function, error)
        self.update(withError: error)
    }
}