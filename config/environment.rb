require 'bundler'
Bundler.require

require_relative '../lib/student.rb'

DB = {:conn => SQLite3::Database.new("db/students.db")}
