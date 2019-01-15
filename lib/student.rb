class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # p student_hash
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    student = @@all[0] 
    attributes_hash.each do |key, value|
      word = "@#{key.to_s}"
      student.instance_variable_set(word, value)
    end
    student
  end

  def self.all
    @@all
  end
end

