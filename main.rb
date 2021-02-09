# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require './memo'

helpers do
  include ERB::Util
  def escape(string)
    html_escape(string)
  end

  def check_column_exist(object)
    halt 404 unless object.id
  end

  def create_memo_object(id)
    memo = Memo.new(id)
    check_column_exist(memo)
    memo
  end
end

get '/' do
  redirect to('/memos')
end

get '/memos' do
  @memos = Memo.show_all_memos
  erb :index
end

get '/memos/new' do
  erb :form
end

post '/memos' do
  Memo.insert_new_memo(params[:title], params[:description])
  redirect to('/memos')
end

get '/memos/:id' do |id|
  @memo = create_memo_object(id)
  erb :detail
end

delete '/memos/:id' do |id|
  memo = create_memo_object(id)
  memo.delete_memo
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  @memo = create_memo_object(id)
  erb :edit
end

patch '/memos/:id' do |id|
  memo = create_memo_object(id)
  memo.update_memo(params[:title], params[:description])
  redirect to('/memos')
end

not_found do
  erb :error
end
