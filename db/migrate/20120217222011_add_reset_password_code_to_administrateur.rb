class AddResetPasswordCodeToAdministrateur < ActiveRecord::Migration
  def change
    add_column :administrateurs, :reset_password_code, :string
    add_column :administrateurs, :reset_password_code_until, :datetime
  end
end
