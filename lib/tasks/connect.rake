# require "../fix.rb"
namespace :connect do
  desc "Connecting countries"
  task :countries => :environment do

    countries_left = []
    JSCountry.all.each{|jsc|
      real_country = Visa.find_by_name(jsc.name)
      countries_left << jsc.name unless real_country 
    }
    puts countries_left
  end


  desc "Fixing connections"
  task :fixing_connections => :environment do
    puts Dir.pwd
    FIX.each{|js_name,visahq_name|
      jsc = JSCountry.find_by_name(js_name)
      jsc.name = visahq_name
      jsc.save
    
    }
  end

  desc "Update the existin Visas with their JS country codes. This should be a one time release task" 
  task :update_exising_visas_with_country_codes => :environment do
    Visa.all.each{|v|
      jsc = JSCountry.find_by_name(v.name)
      if jsc
        v.country_code = jsc.code 
        v.save
      else
        puts "Didn't find shit for #{v.name}"
      end
    }
  end


  desc "Update the existin Countries with their JS country codes. This should be a one time release task" 
  task :update_exising_countries_with_country_code => :environment do
    Country.all.each{|v|
      jsc = JSCountry.find_by_name(v.name)
      if jsc
        v.country_code = jsc.code 
        v.save
      else
        puts "Didn't find shit for #{v.name}"
      end
    }
  end

  desc "Update missing Congo Visas"
  task :update_congo_visas => :environment do
   Visa.find_all_by_name("Congo_Republic").each{|c| c.country_code = "cd";c.save}
   Visa.find_all_by_name("Guinea").each{|c| c.country_code = "gn";c.save}
  end

  desc "Update missing Equitorial Guinea records" 
  task :update_equitorial_guinea_records do
    Visa.all.select{|v| v.name == "Equatorial_Guinea"}.each{|g| g.country_code = "gq"; g.save!}
  end
end

