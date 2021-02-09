# frozen_string_literal: true

# Memo Class
class Memo
  attr_reader :id, :title, :description

  PATH = './public/memo_files/'

  class << self
    def open_file_and_generate_json(file_name, ruby_hash)
      File.open(file_name, 'w') do |file|
        file.print JSON.pretty_generate(ruby_hash)
      end
    end

    def create(title, description)
      new_memo = { 'title': title, 'description': description }
      file_name = "#{PATH}#{Time.now.to_i}.json"
      open_file_and_generate_json(file_name, new_memo)
    end

    def all
      display_files = Dir.entries(PATH).sort.reject { |file| file =~ /^\..?/ }
      display_files.map { |file| Memo.new(file.to_s.delete('.json')) }
    end
  end

  def initialize(id)
    return unless File.exist?("#{PATH}#{id}.json")

    memo = File.open("#{PATH}#{id}.json") { |f| JSON.parse(f.read, symbolize_names: true) }
    @id = id
    @title = memo[:title]
    @description = memo[:description]
  end

  def save(title, description)
    edited_memo = { 'title': title, 'description': description }
    file_name = "#{PATH}#{@id}.json"
    Memo.open_file_and_generate_json(file_name, edited_memo)
  end

  def delete
    File.delete("#{PATH}#{@id}.json")
  end
end
