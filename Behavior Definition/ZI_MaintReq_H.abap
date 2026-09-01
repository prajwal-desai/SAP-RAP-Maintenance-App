managed implementation in class zbp_i_maintreq_h unique;
strict ( 2 );
with draft;

define behavior for ZI_MaintReq_H alias Request
persistent table zrap_mreq_h
draft table zrap_dmreq_h
lock master total etag LastChangedAt
authorization master ( instance )
{
  create;
  update;
  delete;
  association _Parts { create; with draft; }

  field ( numbering : managed, readonly ) ReqUuid;
  field ( readonly ) TotalCost;

 
  draft action Edit;
  draft action Activate;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare;


  mapping for zrap_mreq_h
  {
    ReqUuid       = req_uuid;
    RequestId     = request_id;
    EquipmentName = equipment_name;
    TotalCost     = total_cost;
    Currency      = currency;
    Status        = status;
    CreatedBy     = created_by;
    CreatedAt     = created_at;
    LastChangedAt = last_changed_at;
  }
}

define behavior for ZI_MaintReq_I alias Part
persistent table zrap_mreq_i
draft table zrap_dmreq_i
lock dependent by _Header
authorization dependent by _Header
{
  update;
  delete;
  association _Header { with draft; }

  field ( numbering : managed, readonly ) ItemUuid;
  field ( readonly ) ReqUuid;

  determination CalcPrice on modify { field Price, Quantity; }

 
  mapping for zrap_mreq_i
  {
    ItemUuid  = item_uuid;
    ReqUuid   = req_uuid;
    PartName  = part_name;
    Quantity  = quantity;
    Price     = price;
  }
}
