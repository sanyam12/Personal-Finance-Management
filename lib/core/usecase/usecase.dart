abstract class UseCase<Type,Params1, Params2> {
  Future<Type> call({Params1 params1, Params2 params2});
}