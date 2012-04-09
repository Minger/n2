class ChangeViewObjectTemplateNames < ActiveRecord::Migration
  def up
    ViewObjectTemplate.all.each do |t|
      pn = String.new(t.pretty_name)
      pn = pn.replace(pn[10..100] + "(#{pn[0..8]})") unless !pn.match(/^Version.*/) 
      t.update_attribute :pretty_name, pn unless pn.nil?
    end
  end

  def down
    ViewObjectTemplate.all.each do |t| 
      pn = String.new(t.pretty_name)
      pn = pn.replace(pn[(pn.length-10)..(pn.length-2)] + " " + pn[0,(pn.length-11)]) unless !pn.match(/.?\(Version 2|3\)$/)
      t.update_attribute :pretty_name, pn unless pn.nil?
    end
  end
end
