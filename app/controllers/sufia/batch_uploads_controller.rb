module Sufia
  class BatchUploadsController < ApplicationController
    include Sufia::BatchUploadsControllerBehavior
    include ::SetUnitsBehavior

    before_action :disable_turbolinks, only: :new

    def self.form_class
      ::Sufia::BatchUploadForm
    end
  end
end
