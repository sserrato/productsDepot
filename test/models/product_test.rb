require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
    description: "Yyy",
    price: 1,
    image_url: "Fred.gif")
    assert.product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
    description: "Yyy",
    price: 1,
    image_url: "Fred.gif")
    assert.product.invalid?
    assert_equal [i18n.translate('errors.messages.taken')],
    product.errors[:title]
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "produce price must be positive" do
    product = Product.new(  title: "This is the title",
                            description: "this is the description. ",
                            image_url: "image.png"
                            )
    product.price = -1
    assert product.invalid?
    assert_equal =["must be greater than or equal to 0.01"],
      product_errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal =["must be greater than or equal to 0.01"],
      product_errors[:price]

    product.price = 0
    assert product.valid?

  def new_product(image_url)
    product = Product.new(  title: "This is the title",
                            description: "this is the description. ",
                            image_url: "image.png",
                            price: 1
                            )
  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.JPG FRED.PNG http://a.b.c/x/y/z/fred.gif }

    bad = %w{fred.doc fred.gif/more fred.gif.more fred.xls fred.csv fred.mbp fred.js}

    ok.each.do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end


end
