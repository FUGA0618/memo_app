# frozen_string_literal: true

# Memo Class
class Memo
  attr_reader :id, :title, :description

  @connection = PG.connect(dbname: 'memo_app')

  class << self
    def execute_query(query, params = [])
      @connection.exec_params(query, params)
    end

    def create(title, description)
      query = 'INSERT INTO Memos (title, description) VALUES ($1, $2)'
      params = [title, description]
      Memo.execute_query(query, params)
    end

    def all
      query = 'SELECT * FROM Memos ORDER BY id'
      Memo.execute_query(query)
    end

    def find(id)
      query = 'SELECT title, description FROM Memos WHERE id = $1'
      params = [id.to_i]
      memo = Memo.execute_query(query, params)
      memo.ntuples.zero? ? nil : memo[0]
    end
  end

  def initialize(id, title, description)
    @id = id
    @title = title
    @description = description
  end

  def update(title, description)
    query = 'UPDATE Memos SET title= $1, description= $2 WHERE id = $3'
    params = [title, description, @id]
    Memo.execute_query(query, params)
  end

  def delete
    query = 'DELETE FROM Memos WHERE id = $1'
    params = [@id]
    Memo.execute_query(query, params)
  end
end
