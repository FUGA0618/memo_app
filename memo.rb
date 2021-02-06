# frozen_string_literal: true

# Memo Class
class Memo
  attr_accessor :id, :title, :description

  @connection = PG.connect(dbname: 'memo_app')

  class << self
    def execute_query(query, params = [])
      @connection.exec_params(query, params)
    rescue PG::InvalidTextRepresentation
      nil
    end

    def insert_new_memo(title, description)
      query = 'INSERT INTO Memos (title, description) VALUES ($1, $2)'
      params = [title, description]
      Memo.execute_query(query, params)
    end

    def show_all_memos
      query = 'SELECT * FROM Memos ORDER BY id'
      Memo.execute_query(query)
    end
  end

  def initialize(id)
    query = 'SELECT title, description FROM Memos WHERE id = $1'
    params = [id]
    memo = Memo.execute_query(query, params)
    return if !memo || memo.cmd_tuples.zero?

    @id = id
    @title = memo[0]['title']
    @description = memo[0]['description']
  end

  def update_memo(title, description)
    query = 'UPDATE Memos SET title=$1, description=$2 WHERE id = $3'
    params = [title, description, @id]
    Memo.execute_query(query, params)
  end

  def delete_memo
    query = 'DELETE FROM Memos WHERE id = $1'
    params = [@id]
    Memo.execute_query(query, params)
  end
end
