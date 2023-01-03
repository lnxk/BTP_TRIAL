@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}

define view entity ZKLU_I_MaterialText
  as select from zklu_makt as _MaterialText
    inner join   zklu_mara as _Material on _Material.matnr = _MaterialText.matnr
{
  key _MaterialText.matnr as Material,
      @Semantics.language: true
  key _MaterialText.spras as Language,
      @Semantics.text: true
      _MaterialText.text  as MaterialName

}
