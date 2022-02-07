//
//  Food.swift
//  Onban
//
//  Created by lauren.c on 2022/02/03.
//


struct Food: Decodable {
    
    enum BadgeType: String {
        case event = "이벤트특가"
        case launch = "론칭특가"
    }
    
    let id: String
    let title: String
    let imagePath: String
    let delivery_type: [String]
    let description: String
    let originalPrice: String?
    let actualPrice: String
    let badge: [BadgeType]
    
    private enum CodingKeys: String, CodingKey {
        case id = "detail_hash"
        case imagePath = "image"
        case title, delivery_type, description, badge
        case originalPrice = "n_price"
        case actualPrice = "s_price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        imagePath = try values.decode(String.self, forKey: .imagePath)
        delivery_type = try values.decode([String].self, forKey: .delivery_type)
        description = try values.decode(String.self, forKey: .description)
        originalPrice = try? values.decode(String.self, forKey: .originalPrice)
        actualPrice = try values.decode(String.self, forKey: .actualPrice)
        let badge = try? values.decode([String].self, forKey: .badge)
        self.badge = badge?.compactMap { BadgeType(rawValue: $0 )} ?? []
    }
    
}
