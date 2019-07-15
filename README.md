# GoF_design_pattern
https://www.amazon.co.jp/dp/4797327030/ref=cm_sw_r_li_dp_U_-ZlpCbPVQHQFA

これを読んでRubyで書き直すよ

# UML
## クラス図
矢印の△部分は、サブクラスからスーパークラスに対して伸びる。
javaのextendsは継承元を指定する。

```
class HogeClass extends FugaClass {
}
```

クラスの四角形は クラス名 → フィールド名 → メソッド名

## インターフェースと実装
矢印の△部分は、実装クラスからインターフェースに対して伸びる。
javaのimplementsはインターフェース側で実装されたメソッドの内部処理を実装するために使用する。

interface側では何も実装しない。(ぽい)

```
interface Printable {
    abstract void print();
    abstract void newPage();
}

class PrintClass implements Printable {
  void print() {
      // implement something
  }
  void newPage() {
      // implement something
  }
}
```

## 集約

## アクセス制御
+ がついている場合publicなメソッド or フィールドを表す。
- がついている場合privateなメソッド or フィールドを表す。
`#` がついている場合protectedなメソッド or フィールドを表す。
~ がついているのは同じパッケージ内からのみアクセスできるメソッド or フィールドを表す。

## クラスの関係
AがBを使う時は A ➡ B という➡で表現される。

