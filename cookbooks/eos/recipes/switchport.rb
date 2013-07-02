#
# Chef Cookbook   : eos
# File            : recipes/switchport.rb
#    
# Copyright 2013 Arista Networks
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
config = get_config()
if config.has_key?('switchports')
  config['switchports'].each do |name, attribs|
    Chef::Log.info "Processing switchport #{name}"

    if attribs['state'] == 'absent'
      eos_switchport name do
        action :remove
      end
    
    else
      eos_switchport name do
        untagged_vlan attribs['untagged_vlan'] if attribs['untagged_vlan']
        tagged_vlans attribs['tagged_vlans'] if attribs['tagged_vlans']
        vlan_tagging attribs['vlan_tagging'] if attribs['vlan_tagging']
        action :manage
      end
    end
    
  end
else
  Chef::Log.fatal "Could not load switchport configuration"
end





