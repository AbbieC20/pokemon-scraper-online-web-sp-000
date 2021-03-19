class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize (id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL
    db.execute(sql, name, type)
    id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    Pokemon.new(id: id, name: name, type: type, db: db)
  end

  def self.find(id, db)
    sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        LIMIT 1
    SQL
    found_pokemon = db.execute(sql, id).first
    Pokemon.new(id: found_pokemon[0], name: found_pokemon[1], type: found_pokemon[2], db: db)
  end

end
