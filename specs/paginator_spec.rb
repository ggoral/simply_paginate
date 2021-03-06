require_relative 'spec_helper'

include SimplyPaginate

describe Paginator do
  let(:paginator) { Paginator.new([1,2,3,4,5,6,7,8,9], 3) }
  subject { paginator }

  describe "#[]" do
    let (:index) { 1 }
    context "there are no elements to paginate" do
      before(:each) { allow(subject).to receive(:collection).and_return([]) }

      specify { expect(subject[index]).to be_nil }
    end

    context "there is at least one element" do
      let(:elements) { [1] }
      before(:each) { allow(subject).to receive(:collection).and_return(elements) }

      specify { expect(subject[index]).to be_instance_of(Page) }
    end

    context "index is zero" do
      let(:zero_index) { 0 }
      specify { expect(subject[zero_index]).to be_nil }
    end

    context "index is negative" do
      let(:negative_index) { -1 }
      specify { expect(subject[negative_index]).to be_nil }
    end

    context "index greater than amount of pages" do
      specify { expect(subject[4]).to be_nil }
    end
  end

  describe "iteration" do
    describe "next!" do
      context "iteration hasn't started" do
        before(:each) { allow(subject).to receive(current).and_return(nil) }

        # TODO: specify { expect(subject.next!).to raise_exception }
      end

      context "iteration started" do
        before(:each) { subject.start }

        specify { expect(subject.next!).to be_instance_of(Page) }
      end

      context "there are no more pages" do
        before(:each) { allow(subject).to receive(current).and_return(nil) }

        # TODO: specify { expect(subject.next!).to raise_exception }
      end
    end
  end
end
