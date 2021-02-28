class Gender < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      { id: "men", value: '男性' ,name:'men'},
      { id: "lady", value: '女性' ,name:'lady'}
  ]
end
