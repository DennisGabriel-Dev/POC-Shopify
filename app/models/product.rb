# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  html_body  :text
#  image      :string
#  name       :string
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
end
