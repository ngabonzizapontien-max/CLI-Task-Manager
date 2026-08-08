abstract class Repository<T> {
  void add(T item);

  List<T> getAll();

  void delete(int index);
}