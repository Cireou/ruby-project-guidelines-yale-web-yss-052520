require_relative '../config/environment'
require_all 'app'

# Representative.destroy_all
# ActiveRecord::Base.connection.exec_query("DELETE FROM votes")
# ActiveRecord::Base.connection.exec_query("DELETE FROM bills")
# ActiveRecord::Base.connection.exec_query("DELETE FROM amendments")
# Vote.delete_all
# Bill.delete_all
# Amendment.delete_all

PUBLICA_KEY = ENV['PRO_PUBLICA_KEY']
#google_key = ENV['GOOGLE_KEY']

REP_URL = 'https://api.propublica.org/congress/v1/116/house/members.json'

def find_age(dob_str)#dob: "YYYY-MM-DD"
    dob = Date._parse(dob_str)
    now = Time.now.utc.to_date
    now.year - dob[:year] - ((now.month > dob[:mon] || (now.month == dob[:mon] && now.day >= dob[:mday])) ? 0 : 1)
end

def generate_request(url, key = nil)
    key == nil ? HTTParty.get(url) : 
    HTTParty.get(url, :headers => {"X-Api-Key" => "#{key}"})
end

def populate_rep()
    response = generate_request(REP_URL, PUBLICA_KEY)
    members = response["results"][0]["members"]
    members.each{|member| 
        if member["in_office"]
            Representative.create(
                name: member["first_name"].concat(" " + member["last_name"]), 
                age: find_age(member["date_of_birth"]),
                experience: member["seniority"], 
                state: member["state"],
                district: member["district"], 
                party: member["party"], 
                next_election: member["next_election"],
                rep_id: member["id"]
            )
        end
    }
end

def find_last_roll_call_ID
    response = generate_request("https://api.propublica.org/congress/v1/house/votes/recent.json", PUBLICA_KEY)
    if response["status"] != "OK"
        puts "ProPublica API Call for Most Recent House Votes failed."
        return
    end
    response["results"]["votes"][0]["roll_call"]
end

def populate_amendments()
    roll_call_1 = [*1..701]
    roll_call_2 = [*1..find_last_roll_call_ID()]
    get_votes(1, roll_call_1)
    get_votes(2, roll_call_2)
end

def gen_vote_URL(session_num,  roll_call_num)
    "https://api.propublica.org/congress/v1/116/house/sessions/#{session_num}/votes/#{roll_call_num}.json"
end 

def get_bill(vote)
    bill = vote["bill"]

    if should_create_bill(bill)
        return  Bill.create(
            bill_id: get_bill_id(bill),
            title: bill["short_title"]|| bill["title"] || vote["question"]
        )
    else 
        return Bill.find_by(bill_id: get_bill_id(bill))
    end

end

def get_bill_id(bill)
    return nil if bill == {}
    bill["bill_id"].chomp("-116")
end

def should_create_bill(bill)
    # binding.pry
    bill_id = get_bill_id(bill)
    return true if !bill_id
    is_non_bill(bill_id) || !Bill.exists?(bill_id: bill_id)
end

def is_non_bill(bill_id)
    bill_id == "quorum" || bill_id == "adjourn" || bill_id == "journal"
end

def get_votes(session_num, session_arr)
    session_arr.map { |roll_call_num|
        response = generate_request(gen_vote_URL(session_num, roll_call_num), PUBLICA_KEY)
        puts "ProPublica API Call for Session: #{session_num} Roll Call: #{roll_call_num} failed." && next if response["status"] != "OK"
        begin
            vote = response["results"]["votes"]["vote"]
            # binding.pry
            
            bill_ins = get_bill(vote)

            Amendment.create(
                bill_id: bill_ins.id,
                session_num: vote["session"],
                roll_call_num: vote["roll_call"], 
                decision: vote["result"],
                decision_date: vote["date"], 
                description: vote["description"] == "" ? vote["question"] : "#{vote["question"]} : #{vote["description"]}"
            )

            positions = vote["positions"]
            # binding.pry
            positions.each{|rep_vote|
                Vote.create(
                    representative_id: rep_vote["member_id"],
                    bill_id: bill_ins.id,
                    vote: rep_vote["vote_position"]
                )
                #  binding.pry
            }
        rescue Exception
            "ProPublica API Call for Session: #{session_num} Roll Call: #{roll_call_num}"
        end
    }
end


def gen_bills_URL(bill_id)
    "https://api.propublica.org/congress/v1/116/bills/#{bill_id}.json"
end

def populate_bills()
    Bill.all.each {|bill|
        bill_id = bill.bill_id
        # binding.pry()
        response = generate_request(gen_bills_URL(bill_id), PUBLICA_KEY)
        # binding.pry
        puts "ProPublica API Call for Bill: #{bill_id} failed." && next if response["status"] != "OK"
        results = response["results"][0]
        # binding.pry

        bill.sponsor = results["sponsor_id"]
        bill.date_proposed = results["introduced_date"]
        bill.summary = results["summary"]
        bill.link = results["congressdotgov_url"]
    }
end

def get_cosponsors()
    Bill.all.each {|bill|
        # binding.pry()
        bill_id = bill.bill_id
        response = generate_request(get_cosponsor_URL(bill_id), PUBLICA_KEY)
        # binding.pry
        puts "ProPublica API Call for Bill: #{bill_id} failed." && next if response["status"] != "OK"
        
        cosponsors = response["results"][0]["cosponsors"]
        # binding.pry
        cosponsors.each {|cosponsor|
            Cosponsor.create(
                bill_id: bill.id,
                rep_id: cosponsor["consponsor_id"]
            )
      }
    }
end

def get_cosponsor_URL(bill_id)
    "https://api.propublica.org/congress/v1/116/bills/#{bill_id}/cosponsors.json"
end
# binding.pry
# populate_rep()
# populate_amendments()
# # populate_bills()
# # get_votes(1, [697,698])
# populate_bills()
# # get_cosponsors()
# # binding.pry
# # 0
# get_cosponsors()
binding.pry
0

