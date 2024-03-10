//
//  SupportStaffViewModel.swift
//  SwiftUIAPI
//
//  Created by Saurabh Pandey on 08/03/24.
//

import Foundation

struct SupportStaffResponse: Decodable {
    let supportStaff: [SupportStaffData]
}

class SupportStaffViewModel: ObservableObject {
    @Published var staffMembers: [SupportStaffData] = []
    @Published var isLoading = false
    @Published var errorMessage: ErrorMessage?

    struct ErrorMessage: Identifiable {
        let id = UUID()
        let message: String
    }

    func fetchSupportStaff() {
        guard let url = URL(string: "https://raw.githubusercontent.com/sp15731/sp/main/db.json") else { return }
        isLoading = true
        errorMessage = nil
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error {
                    self?.errorMessage = ErrorMessage(message: "Failed to fetch data: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    self?.errorMessage = ErrorMessage(message: "No data received")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(SupportStaffResponse.self, from: data)
                    self?.staffMembers = response.supportStaff
                    print("Data:")
                    print(self?.staffMembers)
                } catch {
                    print("Error decoding data: \(error)")
                    self?.errorMessage = ErrorMessage(message: "Failed to decode data: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
