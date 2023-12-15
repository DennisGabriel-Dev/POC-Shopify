class AddFieldsToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :email_contact, :string
    add_column :orders, :number, :integer
  end
end
