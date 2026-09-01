@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Item View'
define view entity ZI_MaintReq_I 
  as select from zrap_mreq_i
  association to parent ZI_MaintReq_H as _Header on $projection.ReqUuid = _Header.ReqUuid
{
  key item_uuid as ItemUuid,
  req_uuid as ReqUuid,
  part_name as PartName,
  quantity as Quantity,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  _Header.Currency as Currency,

  /* Parent Association */
  _Header
}
