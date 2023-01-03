@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Input help for status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}

define view entity ZKLU_I_StatusVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name : 'ZKLU_DOMA_STATUS' )   as dv
    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name : 'ZKLU_DOMA_STATUS' ) as dv_t on  dv_t.domain_name    = dv.domain_name
                                                                                             and dv_t.value_position = dv.value_position
                                                                                             and dv_t.language       = $session.system_language

{
  key  dv.value_low as Low,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @Search.ranking: #HIGH
       dv_t.text    as Text
}
