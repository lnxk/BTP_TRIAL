CLASS lhc_Certificate DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Certificate RESULT result.
    METHODS setinitialvalues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR certificate~setinitialvalues.

ENDCLASS.

CLASS lhc_Certificate IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF ZKLU_I_Certificate IN LOCAL MODE
      ENTITY Certificate
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(certificates).

    result = VALUE #( FOR Certificate IN certificates ( %tky = Certificate-%tky ) ).
  ENDMETHOD.

  METHOD setInitialValues.

    DATA:
      lt_certificate_state       TYPE TABLE FOR CREATE ZKLU_I_Certificate\_CertificateState,
      ls_certificate_state       LIKE LINE OF lt_certificate_state,
      ls_certificate_state_value LIKE LINE OF ls_certificate_state-%target.

    READ ENTITIES OF ZKLU_I_Certificate IN LOCAL MODE
      ENTITY Certificate
      FIELDS ( CertificationStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(certificates).

    IF certificates IS NOT INITIAL.
      MODIFY ENTITIES OF ZKLU_I_Certificate IN LOCAL MODE
        ENTITY Certificate
        UPDATE
        FIELDS ( version CertificationStatus )
        WITH VALUE #(
          FOR certificate IN certificates
          ( %tky = certificate-%key
            version = '00001'
            CertificationStatus = '01' ) )
        REPORTED DATA(ls_return).
    ENDIF.

    LOOP AT certificates ASSIGNING FIELD-SYMBOL(<ls_certificate>).

      ls_certificate_state-%key = <ls_certificate>-%key.
      ls_certificate_state-CertUUID = ls_certificate_state_value-CertUUID = <ls_certificate>-CertUUID.

      ls_certificate_state_value-Status = '01'.
      CLEAR: ls_certificate_state_value-StatusOld.
      ls_certificate_state_value-Version = '01'.

      ls_certificate_state_value-%control-CertUUID = if_abap_behv=>mk-on.
      ls_certificate_state_value-%control-Status = if_abap_behv=>mk-on.
      ls_certificate_state_value-%control-StatusOld = if_abap_behv=>mk-on.
      ls_certificate_state_value-%control-Version = if_abap_behv=>mk-on.
      ls_certificate_state_value-%control-LastChangedAt = if_abap_behv=>mk-on.
      ls_certificate_state_value-%control-LastChangedBy = if_abap_behv=>mk-on.

      APPEND ls_certificate_state_value TO ls_certificate_state-%target.

      APPEND ls_certificate_state TO lt_certificate_state.

      MODIFY ENTITIES OF ZKLU_I_Certificate IN LOCAL MODE
        ENTITY Certificate
        CREATE BY \_CertificateState
        FROM lt_certificate_state
        REPORTED DATA(ls_return_ass)
        MAPPED DATA(ls_mapped_ass)
        FAILED DATA(ls_failed_ass).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
