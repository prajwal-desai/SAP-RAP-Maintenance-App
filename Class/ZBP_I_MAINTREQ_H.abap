" ====================================================================
" HANDLER CLASS FOR THE HEADER (REQUEST)
" ====================================================================
CLASS lhc_Request DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Request RESULT result.
ENDCLASS.

CLASS lhc_Request IMPLEMENTATION.

  METHOD get_instance_authorizations.


    result = VALUE #( FOR ls_key IN keys
                    ( %tky = ls_key-%tky
                      %action-Edit = if_abap_behv=>auth-allowed
                      %delete      = if_abap_behv=>auth-allowed ) ).
  ENDMETHOD.

ENDCLASS.


" ====================================================================
" HANDLER CLASS FOR THE CHILD ITEM (PART)
" ====================================================================
CLASS lhc_Part DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS CalcPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Part~CalcPrice.
ENDCLASS.

CLASS lhc_Part IMPLEMENTATION.
  METHOD CalcPrice.

    READ ENTITIES OF ZI_MaintReq_H IN LOCAL MODE
      ENTITY Part BY \_Header
        FIELDS ( ReqUuid ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_headers).

    SORT lt_headers BY %tky.
    DELETE ADJACENT DUPLICATES FROM lt_headers COMPARING %tky.


    LOOP AT lt_headers INTO DATA(ls_header).
      READ ENTITIES OF ZI_MaintReq_H IN LOCAL MODE
        ENTITY Request BY \_Parts
          FIELDS ( Quantity Price ) WITH VALUE #( ( %tky = ls_header-%tky ) )
        RESULT DATA(lt_parts).

      DATA lv_total TYPE p LENGTH 15 DECIMALS 2.
      CLEAR lv_total.

      LOOP AT lt_parts INTO DATA(ls_part).
        lv_total += ( ls_part-Quantity * ls_part-Price ).
      ENDLOOP.

      MODIFY ENTITIES OF ZI_MaintReq_H IN LOCAL MODE
        ENTITY Request
          UPDATE FIELDS ( TotalCost )
          WITH VALUE #( ( %tky = ls_header-%tky TotalCost = lv_total ) ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
