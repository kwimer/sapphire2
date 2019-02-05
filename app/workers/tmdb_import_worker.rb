class TmdbImportWorker < ApplicationWorker

  def perform(media_type, tmdb_id)
    "tmdb/#{media_type}".classify.constantize.send('import', tmdb_id)
  end

end