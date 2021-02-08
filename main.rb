# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require './memo'

helpers do
  include ERB::Util
  def escape(string)
    html_escape(string)
  end

  def check_file_exist(file)
    halt 404 unless file.id
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
  redirect to('/')
end

get '/memos/:id' do |id|
  @memo = Memo.new(id)
  check_file_exist(@memo)
  erb :detail
end

delete '/memos/:id' do |id|
  memo = Memo.new(id)
  check_file_exist(memo)
  memo.delete
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  @memo = Memo.new(id)
  check_file_exist(@memo)
  erb :edit
end

patch '/memos/:id' do |id|
  memo = Memo.new(id)
  check_file_exist(memo)
  memo.save(params[:title], params[:description])
  redirect to('/memos')
end

not_found do
  erb :error
end
