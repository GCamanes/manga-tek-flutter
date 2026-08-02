abstract class MapperTo<E, M> {
  E toEntity(M model);
}

abstract class MapperFrom<M, E> {
  M fromEntity(E entity);
}
