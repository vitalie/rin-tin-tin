class CreateRinTinTinWebhooks < ActiveRecord::Migration
  def change
    create_table :rin_tin_tin_webhooks do |t|

      t.timestamps
    end
  end
end
