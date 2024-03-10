//
//  SupportStaffListView.swift
//  SwiftUIAPI
//
//  Created by Saurabh Pandey on 08/03/24.
//

import SwiftUI

struct SupportStaffListView: View {
    @ObservedObject private var viewModel = SupportStaffViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.staffMembers) { staffMember in
                NavigationLink(destination: SupportStaffDetailView(staffData: staffMember)) {
                    SupportStaffView(staffData: staffMember)
                }
            }
            .onAppear {
                viewModel.fetchSupportStaff()
            }
            .navigationTitle("Support Staff")
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct SupportStaffDetailView: View {
    let staffData: SupportStaffData
    
    var body: some View {
        List {
            Section(header: StaffHeaderView(staffData: staffData)) {
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StaffHeaderView: View {
    let staffData: SupportStaffData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(staffData.name)
                .font(.title)
                .fontWeight(.bold)
            Text(staffData.roleName)
                .font(.headline)
            HStack {
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
        .padding()
    }
}



struct SupportStaffListView_Previews: PreviewProvider {
    static var previews: some View {
        SupportStaffListView()
    }
}
