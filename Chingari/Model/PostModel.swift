//
//  PostModel.swift
//  Chingari
//
//  Created by Guru on 05/05/24.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageUrl: URL?
    let videoUrl: URL?
}
