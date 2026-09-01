projection;
strict ( 2 );
use draft;

define behavior for ZC_MaintReq_H alias Request
{
  use create;
  use update;
  use delete;

  use action Edit;
  use action Activate;
  use action Discard;
  use action Resume;
  use action Prepare;

  use association _Parts { create; with draft; }
}

define behavior for ZC_MaintReq_I alias Part
{
  use update;
  use delete;

  use association _Header { with draft; }
}
