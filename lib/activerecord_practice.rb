require 'sqlite3'
require 'active_record'
require 'byebug'


ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')
# Show queries in the console.
# Comment this line to turn off seeing the raw SQL queries.
ActiveRecord::Base.logger = Logger.new(STDOUT)

class Customer < ActiveRecord::Base
  def to_s

    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.

  def self.any_candice
    # YOUR CODE HERE to return all customer(s) whose first name is Candice
    # probably something like:  Customer.where(....)
    where(first: 'Candice')
    
  end
  
  def self.with_valid_email
  	
    	where("email LIKE ?", "%@%")
  end
  
  def self.with_dot_org_email
  	where("email LIKE ?", "%.org%")
  end
  def self.with_invalid_email
    	where("email NOT LIKE ?", "%@%")
  end
  
  def self.with_blank_email
  	where(email: nil)
  end
  
  def self.born_before_1980
  	where("birthdate < ?", "1980-01-01")
  end
  
  def self.with_valid_email_and_born_before_1980
  	where("email LIKE ? AND birthdate < ?", "%@%", "1980-01-01" ) 
  end
  
  def self.last_names_starting_with_b
  	where("last LIKE ?", "B%").order(birthdate: 'asc')
  end
  
  def self.twenty_youngest
  	order(birthdate: :desc).limit(20)
  	
  end
  
  def self.update_gussie_murray_birthdate
  	where(first: 'Gussie').update(birthdate: '2004-02-08')
  end
  
  def self.change_all_invalid_emails_to_blank
  	where("email != ' ' AND email NOT NULL AND email NOT LIKE ?", "%@%").update(email: nil)
  end
  
  def self.delete_meggie_herman
  	find_by(:first => 'Meggie', :last => 'Herman').destroy
  end
  
  def self.delete_everyone_born_before_1978
  	where("birthdate < ?", "1978-01-01").destroy_all
  end
  
 
  # etc. - see README.md for more details
end
