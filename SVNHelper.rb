SVN_FILE = ".svn/entries"
class SVNHelper
  
 attr_accessor :version, :date
 
 def initialize(version, date)
   @version  = version 
   @date     = date
 end
 alias rev version 
 
 def self.strip_break_line_flag(l)
   l.gsub(/\n$/, '')
 end
 
 def self.version(root)
   
   begin
     file = File.join(root, SVN_FILE)  
     raise "Specified SVN file [#{file}] does not exist, can not get the revision information."  unless File.exists?(file)
     #third line is the revision name, ninth line is the last modified date.
     lines   = IO.readlines(file)
     version = self.new(strip_break_line_flag(lines[3]),         
                        strip_break_line_flag(lines[9]).to_time)
   rescue
    #in case of a change of SVN kernel, just return 'no_svn' and we will look back here.
    version = self.new('NO_SVN',Date.today)     
   end
   
   version
   
 end
 
 def to_s
   rev
 end
 def rev_with_date
   %{#{version} [#{date.to_time.strftime("%y%m%d.%H%M%S")}]}
 end
 
end