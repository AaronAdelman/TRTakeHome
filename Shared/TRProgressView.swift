//
//  TRProgressView.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI

struct TRProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}

struct TRProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TRProgressView()
    }
}
