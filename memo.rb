# frozen_string_literal: true

# Memo Class
class Memo
  attr_accessor :id, :title, :description

  class << self
    def open_file_and_generate_json(file_name, ruby_hash)
      File.open(file_name, 'w') do |file|
        file.print JSON.pretty_generate(ruby_hash)
      end
    end

    def generate_new_memo(title, description)
      new_memo = { 'title': title, 'description': description }
      file_name = "#{PATH}#{Time.now.to_i}.json"
      open_file_and_generate_json(file_name, new_memo)
    end
  end

  def initialize(id)
    return unless File.exist?("#{PATH}#{id}.json")

    memo =
      File.open("#{PATH}#{id}.json") do |f|
        JSON.parse(f.read, symbolize_names: true)
      end
    @id = id
    @title = memo[:title]
    @description = memo[:description]
  end

  def save_memo(title, description)
    edited_memo = { 'title': title, 'description': description }
    file_name = "#{PATH}#{@id}.json"
    Memo.open_file_and_generate_json(file_name, edited_memo)
  end

  def delete_memo
    File.delete("#{PATH}#{@id}.json")
  end
end
