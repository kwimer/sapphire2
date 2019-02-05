module Importer

  extend ActiveSupport::Concern

  def import
    TmdbImportWorker.perform_async(self.class.name.underscore, tmdb_id)
  end

  class_methods do
    def import(tmdb_id)
      TmdbImportWorker.perform_async(name.underscore, tmdb_id)
    end
  end

end