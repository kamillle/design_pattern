システム中で1つのものを常に使いまわしたい時(例えば基本的なプログラムの設定とか)に使われる。
Singletonパターンを選択することで得られるメリットは、Singletonパターンを適用したクラスのインスタンスが必ず1つで有ることを保証できる。こと。

Singletonパターンは初期化時にクラスインスタンス変数領域に値を保持するような設計になっていることが多い。

Rubyには標準ライブラリとして Singleton ライブラリが用意されていて、includeすることでincludeしたクラスにはsingleton patternが適用される。

```
require 'singleton'

class Hoge
  # Singleton libraly provides us with .instance that returns one instance in everytime.
  include Singleton
end

hoge1 = Hoge.instance
hoge2 = Hoge.instance

puts 'same object' if hoge1 == hoge2
```
