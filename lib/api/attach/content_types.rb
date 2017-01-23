module Api::Attach::ContentTypes
  PERMITTED_MIME =
    [
      'application/pdf',
      /\Aimage\/.*\z/,
      'application/msword',
      /openxmlformats.*/,
      /ms-excel.*/,
      /ms-powerpoint.*/,
      /\Aaudio\/.*\z/,
      /\Avideo\/.*\z/,
      'application/zip',
      'application/x-compressed-zip'
    ].freeze
end
