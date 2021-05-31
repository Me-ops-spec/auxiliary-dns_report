require "msf/core"
require "em-resolv-replace"

class MetasploitModule < Msf::Auxiliary
	include Msf::Auxiliary::Report
	def initialize(info = {})
		super(update_info(

				'Name' => 'Auxiliary Dns Report Inforamtion',
				'Description' => %q{
					This Auxiliary Give reporte for all inforamtion of the Dns
				},
				'Aauthor' => ['mhvx <instagrame > mhv7x'],
				'License' => MSF_LICENSE,
				'Version' => '1.0'))
		register_options(

				[

					OptString.new('Port', [false, 'By Deffault H i you sed a deffaul port 80']),
					OptString.new("DNS", [true, 'Entre the Domain Name Server To Start']),

				], self.class

			)
	end

	def auxiliary
		$domain = datastore['DNS']
		$dns = Resolv::DNS.new
		dns.each-address("DNS") do |Ip|
			print_status("The Ip Address Found ")
			puts Ip
		end
		$dns.each_resource($domain,Resolv::DNS::Resource::IN::MX) do |mail_server|
			print_status("The Mail Server Found")
			puts mail_server.exchange 
		end
		$dns.each_resource($domain, Resolv::DNS::Resource::IN::NS) do |name_server|
			print_status("The Name Server Found ")
			puts name_server.name
		end
	end	

end