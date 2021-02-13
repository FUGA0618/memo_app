## memo_appについて

Sinatraで作成した簡単なメモアプリです。
メモの作成・編集・削除ができます。

## 使用しているもの

- Sinatra
  - erb
- PostgreSQL

## 使い方

### データベースの作成

データベースにログインします。

```shell
$ psql -U [dbname]
```

新しいデータベースを作成します。

```postgresql
postgres=# CREATE DATABASE memo_app;
```

接続先のデータベースを`memo_app`に変更します。

```postgresql
postgres=# \c memo_app
```

テーブルを作成します。

```postgresql
note_app=# CREATE TABLE Note
            (id SERIAL NOT NULL, 
             title VARCHAR NOT NULL, 
             description text NOT NULL, 
             PRIMARY KEY (note_id));
```

### アプリの準備

`memo_app`ディレクトリを作成して、移動します。

```shell
$ mkdir memo_app
$ cd memo_app
```

必要なgemをインストールします。

```shell
$ bundle install
```

アプリを起動します。

```shell
$ bundle exec main.rb
```

`http://localhost:4567`にアクセスします。
