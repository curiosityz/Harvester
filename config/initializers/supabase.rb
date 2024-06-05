# Initializer for Supabase client
require 'supabase'

SupabaseClient = Supabase.create_client(
  url: ENV['SUPABASE_URL'],
  anon_key: ENV['SUPABASE_ANON_KEY']
)
