# 1. `ArraryList`与`LinkedList`区别

- `ArraryList`,`(实际开发常用)`
  - 基于数组,需要连续内存
  - 随机访问快(指根据下标访问)
  - **尾部**插入,删除性能 可以; ;;**其他部分**插入,删除都会移动数据,因此性能会低
  - 可以利用`cpu`缓存,局部性原理
- `LinkedList`
  - 基于双向链表,无需连续内存
  - 随机访问慢(要沿着链表遍历)
  - **头尾**插入删除性能**高**
  - 占用内存多

