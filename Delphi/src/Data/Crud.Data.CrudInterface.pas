unit Crud.Data.CrudInterface;

interface
uses
  Data.DB;

type

  iPersistentObject<T: class> = interface
    ['{4CED34F0-0138-4625-9529-D821D516122D}']
    function Insert(aEntity: T): iPersistentObject<T>;
    function Update(aEntity: T): iPersistentObject<T>;
    function Delete(aEntity: T): iPersistentObject<T>;
    function FindId(aEntity: T): T;
    function FindAll(aDataSource: TDataSource): iPersistentObject<T>; overload;
    function FindAll(sEndPoint: string; aDataSource: TDataSource): iPersistentObject<T>; overload;
  end;

  iPersistentAPI = interface
    ['{DC3074B8-627C-4488-B37D-AB63A64A0AAF}']
    function FindAll(sEndPoint: string; aDataSource: TDataSource): iPersistentAPI;
  end;
implementation

end.
