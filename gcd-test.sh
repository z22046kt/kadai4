#!/bin/sh

# シェルのプロセスIDを使用して、ユニークなファイル名のプリフィックスを準備（作業用）。
tmp=/tmp/$$ # 変数を使って表記を短く

# メッセージ定義
echo "input 2 argments" > $tmp-args    # エラー：引数の数が正しくない
echo "input natural number" > $tmp-nat # エラー：引数が数字以外を指定されている

# 作成したtmpファイルを削除
REMOVE_TMP () {
  rm -f $tmp-*
}

# 引数をエラーメッセージとしてエラー出力
ERROR_EXIT () {
  echo "$1" >&2
  REMOVE_TMP
  exit 1
}


# テスト開始
# ------------------------------------
# teat1: 引数の数が正しくない
# ------------------------------------
# 指定なし
./gcd.sh 2> $tmp-ans
diff $tmp-ans $tmp-args || ERROR_EXIT "ERROR:引数の数が正しくない。指定なし。"

# １つ指定（少ない）
./gcd.sh 1 2> $tmp-ans
diff $tmp-ans $tmp-args || ERROR_EXIT "ERROR:引数の数が正しくない。指定１つ指定（少ない）。"

# ３つ指定（多い）
./gcd.sh 1 2 3 2> $tmp-ans
diff $tmp-ans $tmp-args || ERROR_EXIT "ERROR:引数の数が正しくない。３つ指定（多い）"

# ------------------------------------
# teat2: 引数が数字以外を指定されている
# ------------------------------------
# 英字（1つ目が正しくない）
./gcd.sh A 1 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。英字（1つ目が正しくない）。"

# 英字（2つ目が正しくない）
./gcd.sh 1 A 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。英字（2つ目が正しくない）。"

# ------------------------------------
# 小数（1つ目が正しくない）
./gcd.sh 1.1 1 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。小数（1つ目が正しくない）。"

# 小数（2つ目が正しくない）
./gcd.sh 1 2.1 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。小数（2つ目が正しくない）。"

# ------------------------------------
# 0（1つ目が正しくない）
./gcd.sh 0 1 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。0（1つ目が正しくない）。"

# 0（2つ目が正しくない）
./gcd.sh 1 0 2> $tmp-ans
diff $tmp-ans $tmp-nat || ERROR_EXIT "ERROR:引数が数字以外を指定されている。0（2つ目が正しくない）。"

# ------------------------------------
# teat3: 正常終了
# ------------------------------------

# 最小
./gcd.sh 1 1 1> $tmp-ans
if [ $? -ne 0 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。正常終了していない。"
  exit 1
fi
r=`cat $tmp-ans`
if [ $r -ne 1 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。結果が違う。"
  exit 1
fi

# 一般（値が同じ）
./gcd.sh 20 20 1> $tmp-ans
if [ $? -ne 0 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。正常終了していない。"
  exit 1
fi
r=`cat $tmp-ans`
if [ $r -ne 20 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。結果が違う。"
  exit 1
fi

# 一般（1つ目が大きい）
./gcd.sh 100 10 1> $tmp-ans
if [ $? -ne 0 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。正常終了していない。"
  exit 1
fi
r=`cat $tmp-ans`
if [ $r -ne 10 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。結果が違う。"
  exit 1
fi

# 一般（2つ目が大きい）
./gcd.sh 10 100 1> $tmp-ans
if [ $? -ne 0 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。正常終了していない。"
  exit 1
fi
r=`cat $tmp-ans`
if [ $r -ne 10 ]; then
  ERROR_EXIT "ERROR:予期せぬエラー。結果が違う。"
  exit 1
fi


REMOVE_TMP