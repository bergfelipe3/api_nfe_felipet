class CreateSqNnf894Sequence < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1
          FROM pg_class
          WHERE relkind = 'S'
            AND relname = 'sq_nnf_894'
        ) THEN
          CREATE SEQUENCE sq_nnf_894 START 1;
        END IF;
      END;
      $$;
    SQL
  end

  def down
    execute "DROP SEQUENCE IF EXISTS sq_nnf_894;"
  end
end
