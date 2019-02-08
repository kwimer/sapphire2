module Importer

  extend ActiveSupport::Concern

  def import
    TmdbImportWorker.perform_async(self.class.name.underscore, tmdb_id)
  end

  class_methods do

    def import(tmdb_import_id)
      model, delim, tmdb_id = tmdb_import_id.to_s.rpartition('_')
      model = name.underscore if model.blank?
      media = model.classify.constantize.external_ids_where(tmdb_id: tmdb_id.to_s).first
      return media if media

      media = "tmdb/#{model}".classify.constantize.import(tmdb_id)
      media.import if media
      media
    end

  end

end