using {sap.fe.showcase as persistence} from '../db/schema';

@requires: 'authenticated-user'
service WorkListODataService @(path: '/worklist-srv') {

    entity Orders     as projection on persistence.Orders;
    entity Deliveries as projection on persistence.Deliveries;
}
