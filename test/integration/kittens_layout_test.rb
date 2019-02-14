require 'test_helper'

class KittensLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @jason = kittens(:jason)
    @hodja = kittens(:hodja)
  end

  test 'Links render correctly' do
    get kittens_path
    assert_select 'a[href=?]', kitten_path(@jason), count:2
    assert_select 'a[href=?]', kitten_path(@hodja), count: 2
    assert_select 'a[href=?]', edit_kitten_path(@jason)
    assert_select 'a[href=?]', edit_kitten_path(@hodja)
    assert_select 'a[href=?]', new_kitten_path


    get kitten_path(@jason)

    assert_select 'a[href=?]', kitten_path(@jason)
    assert_select 'a[href=?]', edit_kitten_path(@jason)
    assert_select 'a[href=?]', kittens_path
  end

  test 'Can create a new kitten' do
    new_kitten = {name: 'Testing', age: 5, softness: 4, cuteness: 3}
    get new_kitten_path
    assert_select 'input[name="kitten[name]"]'
    assert_select 'input[name="kitten[age]"]'
    assert_select 'select[name="kitten[softness]"]'
    assert_select 'select[name="kitten[cuteness]"]'
    assert_select 'input[type="submit"]'

    assert_difference 'Kitten.count', 1 do
      post kittens_path, params:{kitten: new_kitten}
    end

    assert_response :redirect

    follow_redirect!

    assert_match 'Testing', response.body

  end

  test 'Can delete a kitten' do
    get kitten_path(@jason)
    assert_difference 'Kitten.count', -1 do
      delete kitten_path(@jason)
    end

    assert_response :redirect

    follow_redirect!

    assert_select 'a[href=?]', kitten_path(@jason), count:0
    assert_select 'a[href=?]', kitten_path(@hodja), count: 2
    assert_select 'a[href=?]', edit_kitten_path(@jason), count:0
    assert_select 'a[href=?]', edit_kitten_path(@hodja)
    assert_select 'a[href=?]', new_kitten_path
  end

end
