//
//  TRDatumView.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI
import Kingfisher

struct TRDatumView: View {
    var datum: Datum
        
    var body: some View {
        let nameAndDateString = datum.author.name + " / " + datum.date.formattedFromTimestamp
        
        VStack(alignment: .leading) {
            let imageSource = datum.image.src
            if imageSource != nil {
                let imageSourceURL: URL? = URL(string: imageSource!)
                if imageSourceURL != nil {
                    KFImage(imageSourceURL!)
                }
            }

            
            HStack {
                let authorImageSource = datum.author.image.src
                if authorImageSource != nil {
                    let authorImageSourceURL: URL? = URL(string: authorImageSource!)
                    if authorImageSourceURL != nil {
                        KFImage(authorImageSourceURL!)
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
    }
}


//struct TRDatumView_Previews: PreviewProvider {
//    static var previews: some View {
//        TRDatumView()
//    }
//}
