@EndUserText.label: 'Certif. Managem. Status Projection View'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true

define view entity ZKLU_C_CertificateState
  as projection on ZKLU_I_CertificateState
{
  key StateUUID,
      CertUUID,

      Material,
      Version,
      Status,
      StatusOld,
      LastChangedBy,
      @Semantics.dateTime: true
      LastChangedAt,
      LocalLastChangedAt,

      /* Associations */
      _Certificate : redirected to parent ZKLU_C_Certificate
}
