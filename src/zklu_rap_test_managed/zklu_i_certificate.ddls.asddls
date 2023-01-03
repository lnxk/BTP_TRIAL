@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Certificate Management Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZKLU_I_Certificate
  as select from zklu_certificate as Certificate
  composition [0..*] of ZKLU_I_CertificateState as _CertificateState
  association [0..1] to ZKLU_I_MaterialText     as _MaterialText on  _MaterialText.Material = $projection.Material
                                                                 and _MaterialText.Language = $session.system_language
  association [0..1] to ZKLU_I_StatusVH         as _StatusText   on  $projection.CertificationStatus = _StatusText.Low
{
  key cert_uuid             as CertUUID,

      matnr                 as Material,
      version               as Version,
      cert_status           as CertificationStatus,
      _StatusText.Text      as StatusText,
      cert_ce               as CertificateCe,
      cert_gs               as CertificateGs,
      cert_fcc              as CertificateFcc,
      cert_iso              as CertificateIso,
      cert_tuev             as CertificateTuev,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      case
        when ( cert_status = '01' or cert_status = '04' ) // new or partially active
          then 2         //ICON_YELLOW_LIGHT
        when ( cert_status = '03'  or cert_status is initial ) // inactive or empty
          then 1         //ICON_RED_LIGHT
        else 3           //ICON_GREEN_LIGHT
      end                   as Criticality,

      _CertificateState,
      _MaterialText,
      _StatusText
}
