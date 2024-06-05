module SaveData
  include IndexData
  include CrawlerManager
  include ApiCalls # Include ApiCalls for Supabase integration

  @queue = :save

  def self.perform(results, dataset, term, source, out_file_name)
    save_data(results, dataset, term, source, out_file_name)
  end

  # Save all data
  def save_data(results, dataset, term, source, out_file_name)
    term = Term.find(term["_id"])
    dataset = Dataset.find(dataset["_id"])
    
    results_to_index = Array.new
    results.each do |dataitem|
      # Create item for appropriate model
      item_values = gen_params_hash(dataitem, source)
   
      # Set collection time
      item_values.merge!(collection_time: Time.now)

      # Push to array to index
      results_to_index.push(item_values)
      # Adjust saving process to store documents in Supabase instead of local files
      supabase_add_document('documents', item_values)
    end
    
    # Add collection time to term, index term, and save
    term.update_attributes(latest_collection_time: Time.now)
    index_elastic(results_to_index, term, source, nil)
  end
                                              
  # Generate parameters hash
  def gen_params_hash(dataitem, source)
    item_hash = Hash.new
    output_fields = JSON.parse(get_crawler_info(source))["output_fields"]
    output_fields.each do |field|
      item_hash[field] = dataitem[field]
    end

    # Integrate NLP analysis during the data saving process
    item_hash.merge!(nlp_analysis: perform_nlp_analysis(dataitem))

    return item_hash
  end

  # Perform NLP analysis on the data item
  def perform_nlp_analysis(dataitem)
    # Placeholder for NLP analysis logic
    # This should include the extraction of ideas, concepts, etc. using NLP techniques
    # For now, returning a dummy hash as a placeholder
    { dummy_nlp_feature: "example_value" }
  end
end
