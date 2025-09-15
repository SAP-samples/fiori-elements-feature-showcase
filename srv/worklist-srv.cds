using {sap.fe.showcase as persistence} from '../db/schema';

service WorkListBackend @(path : '/worklist-srv') {

    entity ChildEntities2 as projection on persistence.ChildEntities2;
}
