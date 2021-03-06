module Overrides
  module CurationConcerns
    module PermissionBadgeText
      extend ActiveSupport::Concern

      included do
        def link_title
          if open_access_with_embargo?
            'Public with Embargo'
          elsif open_access?
            ::I18n.translate('sufia.visibility.open')
          elsif registered?
            ::I18n.translate('curation_concerns.institution_name')
          else
            ::I18n.translate('sufia.visibility.private')
          end
        end
      end
    end
  end
end
