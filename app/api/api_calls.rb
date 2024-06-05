module ApiCalls
  # Supabase integration methods
  def supabase_get_documents(table_name)
    response = SupabaseClient.from(table_name).select("*").execute
    response.data
  end

  def supabase_add_document(table_name, document)
    response = SupabaseClient.from(table_name).insert(document).execute
    response.data
  end

  def supabase_remove_document(table_name, document_id)
    response = SupabaseClient.from(table_name).delete().match({id: document_id}).execute
    response.data
  end

  def get_total_docs(index_name)
    http = Curl.get("#{ENV['DOCMANAGER_URL']}/get_total_docs", {:index_name => index_name})
    return JSON.parse(http.body_str)
  end

  def get_collection_count(collection, index_name)
    http = Curl.get("#{ENV['DOCMANAGER_URL']}/get_collection_doc_total", {
                      :index_name => index_name,
                      :collection => collection})
    return JSON.parse(http.body_str)
  end
  
  def add_items(index_name, doc_type, items)
    c = Curl::Easy.new("#{ENV['DOCMANAGER_URL']}/add_items")
    c.http_post(Curl::PostField.content("item_type", doc_type),
                Curl::PostField.content("index_name", index_name),
                Curl::PostField.content("items", items))
  end

  def remove_items(index_name, collection, selectors)
    c = Curl::Easy.new("#{ENV['DOCMANAGER_URL']}/remove_items")
    c.http_post(Curl::PostField.content("collection", collection),
                Curl::PostField.content("index_name", index_name),
                Curl::PostField.content("selectors", JSON.generate(selectors)))
  end

  def get_project_spec(index_name)
    http = Curl.get("#{ENV['DOCMANAGER_URL']}/get_project_spec", {:index_name => index_name})
    return JSON.parse(http.body_str)
  end
end
