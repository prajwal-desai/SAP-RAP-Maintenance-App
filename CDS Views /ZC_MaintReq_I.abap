@EndUserText.label: 'Maintenance Item Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MaintReq_I 
  as projection on ZI_MaintReq_I
{
  key ItemUuid,
  ReqUuid,
  PartName,
  Quantity,
  Price,
  Currency,

  _Header : redirected to parent ZC_MaintReq_H
}
