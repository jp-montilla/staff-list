# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ruby encoding: utf-8

# rubocop:disable Metrics/LineLength

employee_list = [
  ['Admin Name', 'admin@email.com', 'Admin', 'password', 'password', 14.584675126561596, 120.98679036268592],
  ['John Doe', 'johndoe@email.com', 'Employee', 'password', 'password', 14.584675126561596, 120.98679036268592],
  ['Jane Doe', 'janedoe@email.com', 'Employee', 'password', 'password', 14.584675126561596, 120.98679036268592],
  ['Jonathan Doe', 'jonathandoe@email.com', 'Employee', 'password', 'password', 14.584675126561596, 120.98679036268592]
]

question_list = [
  ['Question 1?', 'Text'],
  ['Question 2?', 'Text'],
  ['Question 3?', 'Text'],
  ['Question 4?', 'Text'],
  ['Question 5?', 'Text'],
  ['Question 6?', 'Text'],
  ['Question 7?', 'Text'],
  ['Question 8?', 'Text'],
  ['Question 9?', 'Text'],
  ['Question 10?', 'Text']
]

employee_list.each do |name, email, role, password, password_confirmation, lat, long|
  Employee.create(name: name, email: email, role: role, password: password, password_confirmation: password_confirmation, lat: lat, long: long)
end

question_list.each do |question, answer_type|
  Question.create(question: question, answer_type: answer_type)
end
# rubocop:enable Metrics/LineLength
