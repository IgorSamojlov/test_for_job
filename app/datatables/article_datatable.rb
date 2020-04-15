class ArticleDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Article.id", cond: :eq },
      preview: { source: "Article.preview", cond: :like },
      description: { source: "Article.description" },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        preview: record.preview,
        description: record.description,
        author: record.author.email
      }
    end
  end

  def get_raw_records
    Article.includes(:author).all
  end
end
