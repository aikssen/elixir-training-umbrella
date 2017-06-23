defmodule UsersWeb.V1.UserControllerSpec do
  use ESpec.Phoenix, controller: UserController, async: true

  describe "Users" do
    context "Test UsersWeb Phoenix application" do
      it "Always be true 1+1 == 2" do
        expect(1 + 1).to eq(3)
      end
    end
  end
end