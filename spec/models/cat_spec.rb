describe "Cat" do

  it "requires a name" do
    cat = Cat.new(name: "")

    cat.valid?

    expect(cat.errors[:name].any?).to eq(true)
  end

  it "accepts a name" do
    cat = Cat.new(name: "Sebastian")

    cat.valid?

    expect(cat.errors[:name].any?).to eq(false)
  end

  it "requires a birth date" do
    cat = Cat.new(birth_date: "")

    cat.valid?

    expect(cat.errors[:birth_date].any?).to eq(true)
  end

  it "accepts a birth date" do
    cat = Cat.new(birth_date: "2009-12-12")

    cat.valid?

    expect(cat.errors[:birth_date].any?).to eq(false)
  end

  it "requires a color" do
    cat = Cat.new(color: "")

    cat.valid?

    expect(cat.errors[:color].any?).to eq(true)
  end

  it "accepts a valid colors" do
    colors = ["Black", "White", "Golden Tabby", "Calico"]

    colors.each do |color|
      cat = Cat.new(color: color)

      cat.valid?

      expect(cat.errors[:color].any?).to eq(false)
    end
  end

  it "rejects invalid colors" do
    colors = ["Blacky", "Whitey", "Platinum 78", "..."]

    colors.each do |color|
      cat = Cat.new(color: color)

      cat.valid?

      expect(cat.errors[:color].any?).to eq(true)
    end
  end

  it "requires a description" do
    cat = Cat.new(description: "")

    cat.valid?

    expect(cat.errors[:description].any?).to eq(true)
  end

  it "accepts a description" do
    cat = Cat.new(description: "Sebastian is a friendly hermit")

    cat.valid?

    expect(cat.errors[:description].any?).to eq(false)
  end

  it "requires a sex" do
    cat = Cat.new(sex: "")

    cat.valid?

    expect(cat.errors[:sex].any?).to eq(true)
  end

  it "accepts a valid sexes" do
    sexes = ["M", "F"]

    sexes.each do |sex|
      cat = Cat.new(sex: sex)

      cat.valid?

      expect(cat.errors[:sex].any?).to eq(false)
    end
  end

  it "rejects invalid sexes" do
    sexes = ["Male", "female", "...", "72"]

    sexes.each do |sex|
      cat = Cat.new(sex: sex)

      cat.valid?

      expect(cat.errors[:sex].any?).to eq(true)
    end
  end

end
