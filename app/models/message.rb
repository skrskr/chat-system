class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :body, presence: true
  
  belongs_to :chat

  settings analysis: {
    tokenizer: {
      shingles_tokenizer: {
        type: 'whitespace'
      },
      edge_ngram_tokenizer: {  
        type: 'edge_ngram',
        min_gram: '2',
        max_gram: '20',
        token_chars: ['letter', 'digit'],
        filter: ['lowercase']
      }
    },
    analyzer: {
      shingle_analyzer: {
        type: 'custom',
        tokenizer: 'shingles_tokenizer',
        filter: ['shingle', 'lowercase', 'asciifolding']
      },
      edge_ngram_analyzer: {  
        tokenizer: 'edge_ngram_tokenizer',
        filter: ['lowercase']
      }
    }
  } do
    mappings dynamic: 'false' do
      indexes :body, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard', fields: {
        'shingle': {
          type: 'text',
          analyzer: 'shingle_analyzer',
          search_analyzer: 'standard'
        }
      }
      indexes :chat_id, type: 'integer'
      indexes :number, type: 'integer'
      indexes :created_at, type: 'date'
      indexes :updated_at, type: 'date'
    end
  end

  def as_indexed_json(_options = {})
    self.as_json(only: [:id, :body, :chat_id, :number, :created_at, :updated_at])
  end
end
