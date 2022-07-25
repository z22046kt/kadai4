#!/bin/sh

tmp=/tmp/$$ # 変数を使って表記を短く

# メッセージ定義
echo "input 2 argments" > $tmp-args    # エラー：引数の数が正しくない
echo "input natural number" > $tmp-nat # エラー：引数が数字以外を指定されている

# 引数をエラーメッセージとしてエラー出力して、作成したtmpファイルを削除
ERROR_EXIT () {
  echo "$1" >&2
  rm -f $tmp-*
  exit 1
}

# テスト開始
# teat1: 引数の数が⾜りない
./same.sh 2> $tmp-ans
diff $tmp-ans $tmp-args && ERROR_EXIT "error in test1"
