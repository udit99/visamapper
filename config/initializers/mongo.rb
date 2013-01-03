MongoMapper.config = { 
  Rails.env => { 'uri' => ENV['MONGOHQ_URL'] || 
                          'mongodb://localhost/sushi' ,
                  :logger => Rails.logger } }

MongoMapper.connect(Rails.env)

MongoMapper.database = ENV['MONGO_DATABASE']
MongoMapper.database.authenticate(ENV['MONGO_USER'],ENV['MONGO_PASSWORD'])
