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

  def exists_object(object)
    halt 404 unless object.id
  end

  def build_object_and_exists(id)
    memo = Memo.new(id)
    exists_object(memo)
    memo
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
  @memo = build_object_and_exists(id)
  erb :detail
end

delete '/memos/:id' do |id|
  memo = build_object_and_exists(id)
  memo.delete
  redirect to('/memos')
end

get '/memos/:id/edit' do |id|
  @memo = build_object_and_exists(id)
  erb :edit
end

patch '/memos/:id' do |id|
  memo = build_object_and_exists(id)
  memo.update(params[:title], params[:description])
  redirect to('/memos')
end

not_found do
  erb :error
end
