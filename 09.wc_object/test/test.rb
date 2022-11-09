# frozen_string_literal: true

require './lib/wc'
require 'minitest/autorun'
require 'debug'

class WcTest < Minitest::Test
  def test_1
    text = <<-TEXT
total 16
-rw-r--r--  1 m.kawamura  staff  284 11  7 10:10 README.md
drwxr-xr-x  3 m.kawamura  staff   96 11  5 02:03 lib
-rw-r--r--  1 m.kawamura  staff  820 11  7 11:56 package.json
drwxr-xr-x  3 m.kawamura  staff   96 11  5 01:37 test
    TEXT
    expected = <<-TEXT.chomp
       5      38     237
    TEXT
    actual = Wc.run(text: text, line_only: false)
    assert_equal expected, actual
  end

  def test_2
    text = <<-TEXT
total 16
-rw-r--r--  1 m.kawamura  staff  284 11  7 10:10 README.md
drwxr-xr-x  3 m.kawamura  staff   96 11  5 02:03 lib
-rw-r--r--  1 m.kawamura  staff  820 11  7 11:56 package.json
drwxr-xr-x  3 m.kawamura  staff   96 11  5 01:37 test
    TEXT
    expected = <<-TEXT.chomp
       5
    TEXT
    actual = Wc.run(text: text, line_only: true)
    assert_equal expected, actual
  end

  def test_3
    expected = <<-TEXT.chomp
      11      30     284 README.md
    TEXT
    actual = Wc.run(file_names: ['README.md'], line_only: false)
    assert_equal expected, actual
  end

  def test_4
    expected = <<-TEXT.chomp
      11 README.md
    TEXT
    actual = Wc.run(file_names: ['README.md'], line_only: true)
    assert_equal expected, actual
  end

  def test_5
    expected = <<-TEXT.chomp
      11      30     284 README.md
      36      71     820 package.json
      47     101    1104 total
    TEXT
    actual = Wc.run(file_names: ['README.md', 'package.json'], line_only: false)
    assert_equal expected, actual
  end

  def test_6
    expected = <<-TEXT.chomp
      11 README.md
      36 package.json
      47 total
    TEXT
    actual = Wc.run(file_names: ['README.md', 'package.json'], line_only: true)
    assert_equal expected, actual
  end

  def test_7
    text = <<-TEXT
total 16
-rw-r--r--  1 m.kawamura  staff  284 11  7 10:10 README.md
drwxr-xr-x  3 m.kawamura  staff   96 11  5 02:03 lib
-rw-r--r--  1 m.kawamura  staff  820 11  7 11:56 package.json
drwxr-xr-x  3 m.kawamura  staff   96 11  5 01:37 test
    TEXT
    expected = <<-TEXT.chomp
      11      30     284 README.md
    TEXT
    actual = Wc.run(text: text, file_names: ['README.md'], line_only: false)
    assert_equal expected, actual
  end
end
