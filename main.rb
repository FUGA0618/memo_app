# frozen_string_literal: true

PATH = './public/memo_files/'

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
  @display_files = Dir.entries(PATH).sort.reject { |file| file =~ /^\..?/ }
  erb :index
end

get '/memos/new' do
  erb :form
end
post '/memos/new' do
  Memo.generate_new_memo(params[:title], params[:description])
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
  memo.delete_memo
  redirect to('/')
end

get '/memos/:id/edit' do |id|
  @memo = Memo.new(id)
  check_file_exist(@memo)
  erb :edit
end
patch '/memos/:id/edit' do |id|
  memo = Memo.new(id)
  check_file_exist(memo)
  memo.save_memo(params[:title], params[:description])
  redirect to('/')
end

not_found do
  erb :error
end
