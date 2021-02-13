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

  def find_memo(id)
    memo = Memo.find(id)
    halt 404 unless memo
    Memo.new(id, memo['title'], memo['description'])
  end
end

get '/' do
  redirect to('/memos')
end

get '/memos' do
  @memos = Memo.all
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  Memo.create(params[:title], params[:description])
  redirect to('/memos')
end

get '/memos/:id' do |id|
  @memo = find_memo(id)
  erb :detail
end

delete '/memos/:id' do |id|
  memo = find_memo(id)
  memo.delete
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  @memo = find_memo(id)
  erb :edit
end

patch '/memos/:id' do |id|
  memo = find_memo(id)
  memo.update(params[:title], params[:description])
  redirect to('/memos')
end

not_found do
  erb :error
end
