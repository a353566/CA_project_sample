用這個檔案合成電路的結果才會比較正常，也可以看到最長運算的時間。

基本上只要去改動 rtl/YOUR_MODULE.v
將 INPUT1 & INPUT2 做運算到 OUTPUT 即可。
(範例是乘法)

如果要改動 bit 數量，要去 rtl/target.v 和 syn-saed32/tb.v
改動 n_A, n_B, n_OUTPUT 的數量

主要是為了有些同學不太了解外面那些環境而設計的。
所以如果熟知環境的話，自己設計是OK的喔！！！

就醬~~
