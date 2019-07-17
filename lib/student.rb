class Student
  # Access DB Connection with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    self.name = name
    self.grade = grade
    @id = nil
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    get_id_sql = <<-SQL
      SELECT last_insert_rowid() from students;
    SQL
    #save my id back to my Students instance
    @id = DB[:conn].execute(get_id_sql)[0][0]
    #return the object I'm being called by
    self
  end
  
  def self.create(name:, grade:) 
    new_student = Student.new(name, grade).save
    new_student
  end

end
