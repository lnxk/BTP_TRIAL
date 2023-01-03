@EndUserText.label: 'Certificate Management Projection View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZKLU_C_Certificate
  as projection on ZKLU_I_Certificate
{
  key     CertUUID,

          @ObjectModel.text.element: ['MaterialName']
          @Consumption.valueHelpDefinition: [{entity: {name: 'ZKLU_I_MaterialText', element: 'Material'} }]
          @Search.defaultSearchElement: true
          @Consumption.semanticObject: 'Material'
          Material,

          //      @ObjectModel.readOnly: true
          Version,

          @Search.defaultSearchElement: true
          //      _MaterialText[Language = $session.system_language ].MaterialName as MaterialName,
          _MaterialText.MaterialName as MaterialName,
          CertificationStatus,

          @Search.defaultSearchElement: true
          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZKLU_I_StatusVH',
              element: 'Text'} }]
          StatusText,

          CertificateCe,
          CertificateGs,
          CertificateFcc,
          CertificateIso,
          CertificateTuev,
          LocalLastChangedAt,
          Criticality,

          //  @ObjectModel.readOnly: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZKLU_CL_CERTI_SERVICE'
  virtual MaterialText : zklu_dtel_maktx,

          /* Associations */
          _CertificateState : redirected to composition child ZKLU_C_CertificateState,

          _MaterialText
}
