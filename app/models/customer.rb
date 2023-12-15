# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  cpf        :string
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
end
