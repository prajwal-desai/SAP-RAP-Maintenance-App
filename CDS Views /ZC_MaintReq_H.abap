@EndUserText.label: 'Maintenance Request Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_MaintReq_H 
  provider contract transactional_query
  as projection on ZI_MaintReq_H
{
  key ReqUuid,
  RequestId,
  EquipmentName,
  TotalCost,
  Currency,
  Status,
  
  _Parts : redirected to composition child ZC_MaintReq_I
}
