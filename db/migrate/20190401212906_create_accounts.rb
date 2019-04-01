class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :code
      t.string :type
			t.string :base_token_10
    	t.string :base_token_20
    	t.string :base_token_30
    	t.string :base_token_40
    	t.string :base_token_50
    	t.string :base_token_60
    	t.string :base_token_70
    	t.string :base_token_80
    	t.string :base_token_90
    	t.string :base_token_10
      t.timestamps
    end
  end
end
