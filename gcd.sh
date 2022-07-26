#!/bin/sh

# 引数の数の確認。引数が2個でない場合はエラー。
if [ $# -ne 2 ]; then
  echo "input 2 argments" 1>&2
  exit 1
fi

# 引数の型の確認。exprに数字以外を渡すと終了ステータスが2以上になるのでエラー。
expr $1 + $2 > /dev/null 2>&1

if [ $? -ge 2 ]; then
  echo "input natural number" 1>&2
  exit 1
fi

# 値の確認。0又は負の値はエラー
if [ $1 -lt 1 ] || [ $2 -lt 1 ] ; then
  echo "input natural number" 1>&2
  exit 1
fi

# 最大公約数の計算
GCD() {
  a=$(($1 % $2))
  if [ $a -eq 0 ]; then
    echo $2 1>&1
  else
    GCD $2 $a
  fi
}

echo `GCD $1 $2` 1>&1
