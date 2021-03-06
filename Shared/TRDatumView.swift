//
//  TRDatumView.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI
import Kingfisher
import WebKit
import Foundation

struct TRDatumView: View {
    var datum: Datum
    var index: Int
    
    fileprivate func requestURL() -> URL {
        let provisionalURL: URL? = URL(string: datum.link)
        if provisionalURL == nil {
            return URL(string: "http://google.com")! // Fallback URL you get when the programmer is in a hurry.
        }
        return provisionalURL!
    }
    
    var body: some View {
        let nameAndDateString = datum.author.name + " / " + datum.date.formattedFromTimestamp
        
        let request = URLRequest(url: requestURL())
        NavigationLink(destination: WebView(request: request)) {
            VStack(alignment: .leading) {
                let imageSource = datum.image.src
                if imageSource != nil {
                    let imageSourceURL: URL? = URL(string: imageSource!)
                    if imageSourceURL != nil {
                        KFImage(imageSourceURL!)
                            .placeholder({
                                TRProgressView()
                            })
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                let IMAGE_MAX_DIMENSION: CGFloat = 64.0
                HStack {
                    let authorImageSource = datum.author.image.src
                    if authorImageSource != nil {
                        let authorImageSourceURL: URL? = URL(string: authorImageSource!)
                        if authorImageSourceURL != nil {
                            KFImage(authorImageSourceURL!)
                                .placeholder({
                                    TRProgressView()
                                })
                                .resizable()
                                .frame(maxWidth: IMAGE_MAX_DIMENSION, maxHeight: IMAGE_MAX_DIMENSION)
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(datum.title)
                            .font(.title)
                            .lineLimit(1)
                        
                        Text(nameAndDateString)
                            .lineLimit(1)
                    } // VStack
                } // HStack
                
                Text(datum.datumDescription.withoutHTMLTags())
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
            } // VStack
            .onAppear() {
                if TRModel.shared.isLastDatum(index) {
                    TRModel.shared.getNextPage()
                }
            }
        }
    }
}

