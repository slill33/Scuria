class AddColumnHashcodeForBorads < ActiveRecord::Migration[5.2]
  def up
    execute <<-DDL
      ALTER TABLE backlogs ADD COLUMN hashcode varchar(255) NOT NULL DEFAULT ''
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE backlogs DROP COLUMN hashcode varchar(255) NOT NULL DEFAULT ''
    DDL
  end
end
