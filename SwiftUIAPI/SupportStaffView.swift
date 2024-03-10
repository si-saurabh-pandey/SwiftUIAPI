//
//  SupportStaffView.swift
//  SwiftUIAPI
//
//  Created by Saurabh Pandey on 08/03/24.
//

import SwiftUI

struct SupportStaffView: View {
    var staffData: SupportStaffData

    var body: some View {
        HStack(alignment: .top) {
            // AsyncImage to load staff image
            AsyncImage(url: URL(string: staffData.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                let names = staffData.name.split(separator: " ", maxSplits: 1).map(String.init)
                let firstName = names.first?.capitalized ?? ""
                let lastName = names.count > 1 ? names[1].capitalized : ""

                Text(firstName)
                    .font(.headline)
                Text(lastName)
                    .font(.subheadline)
                Text(staffData.roleName)
                    .font(.caption)
                HStack {
                    // AsyncImage to load country flag
                    AsyncImage(url: URL(string: staffData.countryURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 20, height: 20)
                    .clipShape(Rectangle())

                    Text(staffData.nationalityName)
                        .font(.caption)
                }
            }
            Spacer()
        }
        .padding()
    }
}
