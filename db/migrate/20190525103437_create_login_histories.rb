class CreateLoginHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :login_histories do |t|
      t.string :login
      t.integer :user_id
      t.text :avatar_url
      t.text :url
      t.text :repos_url
      t.string :user_type
      t.string :name
      t.string :company
      t.string :location
      t.string :email
      t.integer :public_repos
      t.datetime :user_created_at
      t.datetime :user_updated_at
      t.integer :disk_usage

      t.timestamps
    end
  end
end
