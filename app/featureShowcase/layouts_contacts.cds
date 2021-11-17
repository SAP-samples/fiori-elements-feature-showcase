using service1 as service from '../../srv/service';

/**
    Communication
    Search-Term: #Contact
 */
annotate service1.Contacts with @(
    Communication.Contact : {
        fn   : name, //full name
        kind : #org,
        tel  : [{
            uri         : phone,
            type        : #preferred
        }],
        adr  : [{
            building    : building,
            country     : country.name,
            street      : street,
            locality    : city,
            code        : postCode,
            type        : #preferred
        }],
    },
    //Search-Term: #AddressFacet
    Communication.Address : {
        building    : building,
        street      : street,
        locality    : city,
        code        : postCode,
        country     : country.name,
        label       : addressLabel,
        type        : #preferred,
    }
);