class Statement

  class << self

    # execute statements/name 
    def query(name, params={ })
      name = name.to_s

      # create es client
      client = Elasticsearch::Client.new
      erb    = ERB.new(content = File.read(
        "#{ENV['RAILS_ROOT']}/db/elasticsearch/statements/" +
        "#{name}.json.erb"
      ))

      # parse and return valid statement and pass to 
      # elasticsearch client
      statement = erb.result OpenStruct.new(params).instance_eval { 
        binding 
      }
      result    = client.search index: 'callowayart', 
                                body:  statement

      # now massage result set into a simpler data structure
      data = [ ]

      # if aggregations have been returned, we are returning
      # a grouped result set
      if result['aggregations'].nil?
        result['hits']['hits'].each do | hash |
          bucket = hash['_source']
          record = {
            title: bucket['title'],
            slug:  bucket['title_slug'],
            description: bucket['description'],
            image: bucket['constrainedw'],
            thumb: bucket['thumb'],
            artist: bucket['artist'],
            thumbh: bucket['thumbh'],
            available: !bucket['tags'].include?( 'not-available' )
          }

          %w{ 
            artist_description exhibit exhibit_description artist_slug exhibit_slug

          }.each do | field |
            record[field.to_sym] = bucket[field] unless bucket[field].nil?
          end

          data << record
        end

      else        
        result['aggregations'].first.pop['buckets'].each do | bucket |

          # we don't want collections larger than 150, we check
          # doc_count and exclude when over max count 
          # TODO: this should be moved to elasticsearch statement 
          # but there is currently not a max_doc_count field
          if bucket['doc_count'] < 150
            record = { 
              title: bucket['key'],
              slug:  bucket['key'],
              count: bucket['doc_count'],
              available: true
            }

            # iterate through bucket fields - the result set will
            # be the arbiter of what fields are available
            bucket.keys.each do | key |
              if ( value = bucket[key] ).kind_of?( Hash )
                # remove all empty value fields 
                buckets = value['buckets'].reject do | bucket | 
                  bucket['key'].nil? || 
                  bucket['key'].kind_of?( String) && bucket['key'].empty?
                end

                # now assign sample from buckets with non-null values
                record[key.to_sym] = buckets.sample['key'] unless buckets.empty?

                # also get reference to collection
                if buckets.count > 1
                  record["#{key}_collection"] = buckets.map { | bucket | bucket['key'] }
                end

    
              else
                record[key.to_sym] = value
              end


            end         

            # add record to queue
            data << record
          end
        end
      end

      data
    end

    def method_missing(name, *arguments)
      query name, arguments.pop
    end

    private 
      def tags( aggregate )
        raise aggregate.to_s  
      end


  end

end