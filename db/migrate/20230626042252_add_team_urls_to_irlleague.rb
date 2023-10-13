class AddTeamUrlsToIrlleague < ActiveRecord::Migration[7.0]
  def change
    add_column :irlleagues, :teamurls, :text
  end
end
