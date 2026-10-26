-- ============================================================
--  docs/schema.sql ― 自分のDB設計（これが「正」）
--  ・要件定義シートの「テーブル設計」シートを、1行ずつSQLに翻訳する
--      シートの1行（列）  →  SQLの1行
--      列名               →  そのまま書く
--      データ型           →  INT / NVARCHAR(50) / DATE / DECIMAL(10,0) …
--      主キー（PK）       →  PRIMARY KEY
--      外部キー（FK）     →  REFERENCES 親テーブル(親の主キー)
--      NOT NULL           →  NOT NULL（空でもよい列は NULL）
--  ・作る順番：親テーブル → 子テーブル（外部キーを持つ側は後）
--  ・日本語の列は NVARCHAR、値は N'...'
--  ・Codex には AGENTS.md で「読むだけ・変更禁止」と伝えてあります
--  ・下は例（部活の練習出欠アプリ）。自分のテーマに書き換えること
-- ============================================================

-- テーブル1：部員（ヒト）
CREATE TABLE 部員 (
  部員ID INT IDENTITY(1,1) PRIMARY KEY,
  名前   NVARCHAR(50) NOT NULL,
  学年   INT NOT NULL
);
-- 主キーの理由：名前は同姓同名がありうるので主キーにしない

-- テーブル2：練習日（できごとの「日」）
CREATE TABLE 練習日 (
  練習日ID INT IDENTITY(1,1) PRIMARY KEY,
  日付     DATE NOT NULL,
  場所     NVARCHAR(50) NULL
);
-- 主キーの理由：

-- テーブル3：出欠（部員と練習日の多対多をつなぐ中間テーブル）
CREATE TABLE 出欠 (
  部員ID   INT NOT NULL REFERENCES 部員(部員ID),
  練習日ID INT NOT NULL REFERENCES 練習日(練習日ID),
  出席区分 NVARCHAR(10) NOT NULL,
  PRIMARY KEY (部員ID, 練習日ID)
);
-- 主キーの理由：同じ部員が同じ日に2回出欠を付けられないようにするため
