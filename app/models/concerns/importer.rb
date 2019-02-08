module Importer

  extend ActiveSupport::Concern

  def reimport
    TmdbImportWorker.perform_async(self.class.name.underscore, tmdb_id)
  end

  class_methods do
    def import(tmdb_id, full_import = false)
      if full_import
        TmdbImportWorker.perform_async(name.underscore, tmdb_id)
      else
        "tmdb/#{name.underscore}".classify.constantize.send('import', tmdb_id)
      end
    end
  end

end