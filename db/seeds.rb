require_relative '../config/environment'
require_all 'app'

# Representative.destroy_all
# ActiveRecord::Base.connection.exec_query("DELETE FROM actions")
# ActiveRecord::Base.connection.exec_query("DELETE FROM bills")

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

def populate_actions()
    roll_call_1 = [*1..701]
    roll_call_2 = [*1..find_last_roll_call_ID()]
    get_votes(1, roll_call_1)
    get_votes(2, roll_call_2)
end

def gen_vote_URL(session_num,  roll_call_num)
    "https://api.propublica.org/congress/v1/116/house/sessions/#{session_num}/votes/#{roll_call_num}.json"
end 

def get_votes(session_num, session_arr)
    session_arr.map { |roll_call_num|
        response = generate_request(gen_vote_URL(session_num, roll_call_num), PUBLICA_KEY)
        puts "ProPublica API Call for Session: #{session_num} Roll Call: #{roll_call_num} failed." && next if response["status"] != "OK"

        vote = response["results"]["votes"]["vote"]
        positions = vote["positions"]

        bill_id = vote["bill"]["bill_id"]
        Bill.create(bill_id: bill_id)

        positions.each{|rep_vote|
            Action.create(
                representative_id: rep_vote["member_id"],
                bill_id: bill_id,
                rep_action: "Vote",
                vote: rep_vote["vote_position"]
            )
        }

    }
end


def gen_bills_URL(bill_id)
    "https://api.propublica.org/congress/v1/116/bills/#{bill_id}.json"
end

def populate_bills()
    
    Bill.all.each {|bill|
        bill_id = bill.bill_id
        response = generate_request(gen_bills_URL(bill_id), PUBLICA_KEY)
        puts "ProPublica API Call for Session: #{session_num} Roll Call: #{roll_call_num} failed." && next if response["status"] != "OK"
        results = response["results"][0]
        Bill.create(
            bill_id: results["bill_id"],
            title: results["short_title"],
            date_proposed: results["introduced_date"],
            passed: results["enacted"] != null,
            date_pass_reject: results["house_passage"],
            summary: results["summary"], 
            link: results["congressdotgov_url"]
        )
    }
end
 
# populate_rep()
# populate_actions()
binding.pry()
0

=begin

https://api.propublica.org/congress/{version}/
current congress = 116
https://api.propublica.org/congress/v1/
https://api.propublica.org/congress/v1/116/house/members.json
compare cosponsoring = GET https://api.propublica.org/congress/v1/members/{first-member-id}/bills/{second-member-id}/{congress}/{chamber}.json
member by district = GET https://api.propublica.org/congress/v1/members/{chamber}/{state}/{district}/current.json
Responses that are not date-based return the first 20 results; pagination is available via an offset query string parameter using multiples of 20 for most votes, 
nomination and bill requests that return more than one object.

=end