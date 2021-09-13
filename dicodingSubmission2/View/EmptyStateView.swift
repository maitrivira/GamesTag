//
//  EmptyStateView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 08/09/21.
//

import SwiftUI

struct EmptyStateView: View {
    @State var view: String
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "doc.fill")
                .font(.system(size: 60))
                .padding(.bottom)
                .foregroundColor(Color("Green"))
            if view == "search" {
                Text("Start search for game")
                    .font(.title3)
                    .foregroundColor(Color("Green"))
            } else {
                Text("No Data")
                    .font(.title3)
                    .foregroundColor(Color("Green"))
            }
            Spacer()
        }
        .padding()
    }
}
