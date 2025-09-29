using {sap.fe.showcase as persistence} from '../db/schema';

@requires : 'authenticated-user'
service WorkListODataService @(path : '/worklist-srv') {

    entity ChildEntities2 as projection on persistence.ChildEntities2;
}
