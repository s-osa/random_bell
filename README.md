# RandomBell

[![Build Status](https://travis-ci.org/s-osa/random_bell.svg?branch=0.1.1)](https://travis-ci.org/s-osa/random_bell)

RandomBell is Ruby gem to generate normal(Gaussian) random number.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'random_bell'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install random_bell
```

## Usage

### Basic

#### Code

```ruby
bell = RandomBell.new
bell.rand #=> 0.596308234257563
bell.rand #=> 0.4986734346841275
bell.rand #=> 0.6441978387725272
```

#### Histogram

```
+0.050: ***
+0.100: *****
+0.150: *********
+0.200: *************
+0.250: **********************
+0.300: **************************
+0.350: **********************************
+0.400: ****************************************
+0.450: ***********************************************
+0.500: *************************************************
+0.550: *************************************************
+0.600: ***********************************************
+0.650: **************************************
+0.700: **********************************
+0.750: **************************
+0.800: *********************
+0.850: *************
+0.900: ********
+0.950: *****
+1.000: ***
```

### Specify mean

#### Code

```ruby
bell = RandomBell.new(mu: 0.75)
bell.rand
```

#### Histogram

```
+0.050:
+0.100:
+0.150:
+0.200:
+0.250: *
+0.300: **
+0.350: *****
+0.400: *********
+0.450: *************
+0.500: ********************
+0.550: ***************************
+0.600: ***********************************
+0.650: ****************************************
+0.700: ************************************************
+0.750: *************************************************
+0.800: *************************************************
+0.850: ********************************************
+0.900: *******************************************
+0.950: ***********************************
+1.000: *************************
```

### Specify standard diviation

#### Code

```ruby
bell = RandomBell.new(sigma: 0.5)
bell.rand
```

#### Histogram

```
+0.050: *******************************
+0.100: *********************************
+0.150: *********************************
+0.200: *************************************
+0.250: ******************************************
+0.300: ********************************************
+0.350: ***********************************************
+0.400: *********************************************
+0.450: *************************************************
+0.500: ***********************************************
+0.550: ************************************************
+0.600: ***********************************************
+0.650: ******************************************
+0.700: ********************************************
+0.750: *********************************************
+0.800: ******************************************
+0.850: ****************************************
+0.900: *****************************************
+0.950: *********************************
+1.000: **********************************
```

### Specify range of number

#### Code

```ruby
bell = RandomBell.new(range: 0.4..1.2)
bell.rand
```

#### Histogram

```
+0.440: *********************************************
+0.480: *************************************************
+0.520: **************************************************
+0.560: *************************************************
+0.600: ********************************************
+0.640: *****************************************
+0.680: ***********************************
+0.720: *****************************
+0.760: ************************
+0.800: ********************
+0.840: *************
+0.880: **********
+0.920: *******
+0.960: ****
+1.000: ***
+1.040: *
+1.080: *
+1.120:
+1.160:
+1.200:
```

### Composition

#### Code

```ruby
bell = RandomBell.new(mu: 25, sigma: 2, range: 20..30)
bell.rand
```

```
+20.500: **
+21.000: *****
+21.500: *********
+22.000: *************
+22.500: ********************
+23.000: *************************
+23.500: *********************************
+24.000: *************************************
+24.500: ********************************************
+25.000: ************************************************
+25.500: **********************************************
+26.000: *******************************************
+26.500: ****************************************
+27.000: ********************************
+27.500: *************************
+28.000: *******************
+28.500: ************
+29.000: *******
+29.500: *****
+30.000: **
```

### Tips

`RandomBell#to_histogram` returns primitive histogram string.
The histograms in this page are drawn by this method.

```ruby
bell = RandomBell.new
puts bell.to_histogram
```

## Contributing

1. Fork it ( https://github.com/s-osa/random_bell/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
