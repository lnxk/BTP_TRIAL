CLASS zklu_cl_certi_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES:
*      if_sadl_exit,
      if_sadl_exit_calc_element_read.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zklu_cl_certi_service IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

*    DATA:
*      lt_calculated_data TYPE STANDARD TABLE OF zklu_c_certificate,
*      lt_lines           TYPE tline_tab,
*      lv_id              TYPE thead-tdid,
*      lv_language        TYPE thead-tdspras,
*      lv_name            TYPE thead-tdname,
*      lv_object          TYPE thead-tdobject.
*
*    lt_calculated_data = CORRESPONDING #( it_original_data ).
*
*    lv_id = 'GRUN'.
*    lv_language = sy-langu.
*    lv_object = 'MATERIAL'.
*
*    LOOP AT lt_calculated_data ASSIGNING FIELD-SYMBOL(<ls_calculated_data>).
*
*      lv_name = <ls_calculated_data>-material.
*
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          id                      = lv_id
*          language                = lv_language
*          name                    = lv_name
*          object                  = lv_object
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc = 0.
*        LOOP AT lt_lines ASSIGNING FIELD-SYMBOL(<ls_line>).
*          DATA(lv_sep) = COND string( WHEN <ls_calculated_data>-materialtext IS NOT INITIAL THEN ` ` ELSE `` ).
*          <ls_calculated_data>-materialtext = |{ <ls_calculated_data>-materialtext }{ lv_sep }{ <ls_line>-tdline }|.
*        ENDLOOP.
*      ENDIF.
*    ENDLOOP.
*
*    ct_calculated_data = CORRESPONDING #( lt_calculated_data ).
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

*    LOOP AT it_requested_calc_elements INTO DATA(ls_data).
*
*      CASE ls_data.
*        WHEN 'MATERIALTEXT'.
*          APPEND 'MATERIAL' TO et_requested_orig_elements.
*      ENDCASE.
*    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
