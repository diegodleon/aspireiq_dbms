require "rails_helper"

RSpec.describe StatementGeneratorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/statement_generators").to route_to("statement_generators#index")
    end

    it "routes to #show" do
      expect(get: "/statement_generators/1").to route_to("statement_generators#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/statement_generators").to route_to("statement_generators#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/statement_generators/1").to route_to("statement_generators#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/statement_generators/1").to route_to("statement_generators#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/statement_generators/1").to route_to("statement_generators#destroy", id: "1")
    end
  end
end
