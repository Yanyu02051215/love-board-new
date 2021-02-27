class Category < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      { id: "longrangelove", value: '遠距離恋愛' },
      { id: "koikatsu", value: '恋活' },
      { id: "marriage", value: '婚活' },
      { id: "brokenheart", value: '失恋' },
      { id: "workromance", value: '職場恋愛' },
      { id: "date", value: 'デート' },
      { id: "cohabitation", value: '同棲' },
      { id: "catastrophic", value: '破局' },
      { id: "firstlove", value: '初恋' },
      { id: "affair", value: '不倫' },
      { id: "divorce", value: '離婚' }
  ]
end