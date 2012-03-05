require "spec_helper"

describe ApplicationHelper do
  describe "#back_from_room" do
    let(:world) { Factory :world}
    let(:session) { Factory :session }

    context "When World Room" do
      it { helper.back_from_room(world).should eq "<a href=\"/worlds/#{world.to_param}\" class=\"btn\">Back</a>" }
    end

    context "When Session Room" do
      it { helper.back_from_room(session).should eq "<a href=\"/worlds/#{session.world.to_param}/sessions/#{session.to_param}\" class=\"btn\">Back</a>" }
    end

  end
end
