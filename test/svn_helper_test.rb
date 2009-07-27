require '/test_helper'

class SVNHelperTest < ActiveSupport::TestCase 
  
 def test_create
   
    version_hash = { :revision => '100',
                     :last_changed_date => Time.now,
                     :last_changed_rev  => '99'
                   }
    assert_nothing_raise{
      rev = SVNHelper.new(version_hash)
    }
    assert_equal rev.to_s, '100'
    assert_equal rev.last_changed = '99'
    
  end
  
end
