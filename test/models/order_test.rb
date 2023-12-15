# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  customer_address :string
#  destiny          :string
#  email_contact    :string
#  id_shopify       :string
#  number           :integer
#  shipping_address :string
#  total_price      :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
