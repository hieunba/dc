module Sufia
  class WorkShowPresenter < ::CurationConcerns::WorkShowPresenter
    # delegate fields from Sufia::Works::Metadata to solr_document
    delegate :based_near, :related_url, :depositor, :identifier, :resource_type,
             :keyword, :itemtype, :alternative, :format, :handle, :unit,
             :preservation_level, :preservation_level_rationale, :provenance,
             :spatial, :staff_notes, :temporal, :work_type, :material,
             :material_type, :measurement, :measurement_unit, :measurement_type,
             to: :solr_document

    def editor?
      current_ability.can?(:edit, solr_document)
    end

    def destroyer?
      current_ability.can?(:destroy, solr_document)
    end

    def tweeter
      user = ::User.find_by_user_key(depositor)
      if user.try(:twitter_handle).present?
        "@#{user.twitter_handle}"
      else
        I18n.translate('sufia.product_twitter_handle')
      end
    end

    def display_feature_link?
      user_can_feature_works? && solr_document.public? && FeaturedWork.can_create_another? && !featured?
    end

    def display_unfeature_link?
      user_can_feature_works? && solr_document.public? && featured?
    end

    def stats_path
      Sufia::Engine.routes.url_helpers.stats_work_path(self)
    end

    private

    def featured?
      if @featured.nil?
        @featured = FeaturedWork.where(work_id: solr_document.id).exists?
      end
      @featured
    end

    def user_can_feature_works?
      current_ability.can?(:create, FeaturedWork)
    end
  end
end
