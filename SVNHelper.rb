class SVNHelper

 attr_accessor :revision, :date, :last_changed, :info

  def initialize(info)
   @revision = info[:revision]
   @date = Time.parse(info[:last_changed_date])
   @last_changed = info[:last_changed_rev]
   @info = info
  end
  alias rev revision

  MARKERS = {
   :url => 'URL',
   :repository_root => 'Repository Root',
   :repository_uuid => 'Repository UUID',
   :revision => 'Revision',
   :node_kind => 'Node Kind',
   :schedule => 'Schedule',
   :last_changed_author => 'Last Changed Author',
   :last_changed_rev => 'Last Changed Rev',
   :last_changed_date => 'Last Changed Date'
  }

  def self.version(root)
    return self.version_for_win(root) unless (RUBY_PLATFORM =~ /win32/).nil?  
    raise "Specified Application root: #{root} does not exist, can not get the revision information." unless File.exists?(root)
    begin
     #get the return result of command: svn info
     svn_info = %x{svn info #{root}}
     info = {}
     MARKERS.each do |name, mark|
       line = svn_info.match(/^#{mark}:\s(.*)/)
       info[name] = line[1]
     end
     version = self.new(info)
    rescue
      # in case of a change of svn info command or the application is not using svn, just return 'no_svn' and we will look back here.
      # the server maybe a non-english one, which returns some svn_info that we don't recognize, return 'no_svn' as well
      version = self.new({:revision=>'NO_SVN',:last_changed_rev=>'NO_SVN'})
    end 
    version.freeze 
    
  end

  def self.version_for_win(root)
    svn_file = File.join(root, ".svn/entries")  
    raise "Specified SVN file [#{file}] does not exist, can not get the revision information."  unless File.exists?(file)

    #third line is the revision name, ninth line is the last modified date.
    begin
    lines   = IO.readlines(file)
    version = self.new({:revision => lines[3].chomp,         
                        :last_changed_date => lines[9].chomp.to_time,
                        :last_changed_rev  =>  lines[10].chomp,
                        :last_changed_author  =>  lines[11].chomp
                      })
    rescue
    #in case of a change of SVN kernel, just return 'no_svn' and we will look back here.
    version = self.new('NO_SVN_WIN',Date.today)     
    end 
    version.freeze 
    
  end

  def to_s
    rev
  end
  def rev_with_date
   %{#{version} [#{date.to_time.strftime("%y%m%d.%H%M%S")}]}
  end
 
end