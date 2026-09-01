@Metadata.layer: #CORE
@UI: { headerInfo: { typeName: 'Spare Part', typeNamePlural: 'Spare Parts', title: { type: #STANDARD, value: 'PartName' } } }
annotate view ZC_MaintReq_I with 
{
  @UI.hidden: true
  ItemUuid;
  
  @UI.hidden: true
  ReqUuid;

  @EndUserText.label: 'Part Name'
  @UI: { lineItem: [ { position: 10 } ], identification: [ { position: 10 } ] }
  PartName;

  @EndUserText.label: 'Quantity'
  @UI: { lineItem: [ { position: 20 } ], identification: [ { position: 20 } ] }
  Quantity;

  @EndUserText.label: 'Price'
  @UI: { lineItem: [ { position: 30 } ], identification: [ { position: 30 } ] }
  Price;
}
