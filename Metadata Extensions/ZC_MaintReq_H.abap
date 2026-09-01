@Metadata.layer: #CORE
@UI: {
  headerInfo: { typeName: 'Maintenance Request',
                typeNamePlural: 'Maintenance Requests',
                title: { type: #STANDARD, value: 'RequestId' } } }
annotate view ZC_MaintReq_H with 
{
  @UI.facet: [ 
    { id: 'HeaderInfo', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Request Details', position: 10 },
    { id: 'PartsTable', purpose: #STANDARD, type: #LINEITEM_REFERENCE, label: 'Spare Parts', position: 20, targetElement: '_Parts' } 
  ]
  
  @UI.hidden: true
  ReqUuid;

  @EndUserText.label: 'Request ID'
  @UI: { lineItem: [ { position: 10 } ], identification: [ { position: 10 } ], selectionField: [ { position: 10 } ] }
  RequestId;

  @EndUserText.label: 'Equipment Name'
  @UI: { lineItem: [ { position: 20 } ], identification: [ { position: 20 } ], selectionField: [ { position: 20 } ] }
  EquipmentName;

  @EndUserText.label: 'Total Cost'
  @UI: { lineItem: [ { position: 30 } ], identification: [ { position: 30 } ] }
  TotalCost;
  
  @EndUserText.label: 'Status'
  @UI: { lineItem: [ { position: 40 } ], identification: [ { position: 40 } ] }
  Status;
}
