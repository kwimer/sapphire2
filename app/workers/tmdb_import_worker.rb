class TmdbImportWorker < ApplicationWorker

  sidekiq_options queue: :import

  def perform(media_type, tmdb_id)
    "tmdb/#{media_type}".classify.constantize.send('import', tmdb_id, true)
  end

end