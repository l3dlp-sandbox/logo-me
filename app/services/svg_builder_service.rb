# builds svg
class SVGBuilderService
  def logo(params)
    opts = options(params)
    svg = build_svg(opts)
    svg
  end

  def options(params)
    font_size = 40
    name = params[:name] || random_company
    {
      name: name,
      size: font_size,
      width: rough_length(name, font_size),
      align: params[:align] || %w(center left).sample,
      weight: params[:weight] || %w(700 400 300).sample,
      family: params[:family] || 'sans-serif',
      color: params[:color] || '#222',
      icon: params[:icon] == 'false' ? nil : random_icon
    }
  end

  def build_svg(opts)
    width = opts[:width]
    align = opts[:align]
    if opts[:icon]
      height = align == 'center' ? opts[:size] * 4 : opts[:size] * 2
      width += opts[:size] * 2 if align == 'left'
    else
      height = opts[:size]
    end
    height += opts[:size] * 0.2
    artboard = {
      w: width,
      h: height
    }
    view_box = define_view_box(align, artboard)
    text = build_text(align, artboard, opts)
    icon_use = opts[:icon] ? build_icon(align, opts) : ''

    "#{credits}
    <svg xmlns='http://www.w3.org/2000/svg'
          xmlns:xlink='http://www.w3.org/1999/xlink'
          width='#{width}px' height='#{height}px'
          viewBox='#{view_box}'>
      <defs>
        <symbol id='icon' viewBox='0 0 1024 1024'>
          #{opts[:icon]}
        </symbol>
      </defs>
      #{text}
      #{icon_use}
    </svg>"
  end

  def rough_length(str, size)
    lg = %(W)
    md = %(A C D G K M O Q T X Y m w)
    sm = %(B E F H J L N P R S U V Z a b c d e g h k n o p q s u v x y z 2 3 4 5 6 7 8 9 0 _)
    xs = %(I f i j l r t 1 -)

    large = 1.25
    medium = 1
    small = 0.66
    xsmall = 0.25
    # ' ' = small
    length = 0
    str.split('').each do |s|
      if s == ' ' || (sm.include? s)
        length += small * size
      elsif md.include? s
        length += medium * size
      elsif xs.include? s
        length += xsmall * size
      elsif lg.include? s
        length += large * size
      else
        length += medium * size
      end
    end

    length
  end

  def define_view_box(align, artboard)
    w = artboard[:w]
    h = artboard[:h]
    if align == 'center'
      return "#{w / -2} #{h / -2} #{w} #{h}"
    else
      return "0 #{h / -2} #{w} #{h}"
    end
  end

  def build_text(align, artboard, opts)
    text_anchor = align == 'center' ? 'middle' : 'start'
    if align == 'center'
      x = 0
      y = opts[:icon] ? opts[:size] * 1.5 : 0
    else
      x = opts[:icon] ? opts[:size] * 2.5 : 0
      y = 0
    end
    "
    <text x='#{x}' y='#{y}'
          alignment-baseline='central'
          text-anchor='#{text_anchor}'
          font-size='#{opts[:size]}'
          font-weight='#{opts[:weight]}'
          font-family='#{opts[:family]}'
          fill='#{opts[:color]}'>
      #{opts[:name]}
    </text>
    "
  end

  def build_icon(align, opts)
    size = opts[:size] * 2
    if align == 'center'
      x = size / -2
      y = size * -0.66
    else
      x = 0
      y = size / -2
    end
    "<use x='#{x}' y='#{y}' fill='#{opts[:color]}' width='#{size}' height='#{size}'
        xlink:href='#icon'></use>"
  end

  def credits
    '
    <!--

      Logo Me Logo Generator
      @jake_albaugh
      jakealbaugh.com

      Icons courtesy of icomoon.io
      https://icomoon.io

    -->
    '
  end

  def random_company
    companies = [
      'Static Interactive',
      'Unlimited LLC',
      'Modern.biz',
      'Wunderbar',
      'Crusty Canyon Boulder Derby',
      'F.O.O. Int\'l',
      'Widget Corp',
      '123 Warehousing',
      'Smith and Co.',
      'Foo Bars',
      'ABC Telecom',
      'Fake Brothers',
      'QWERTY Logistics',
      'Allied Biscuit',
      'Ankh-Sto Associates',
      'Extensive Enterprise',
      'Galaxy Corp',
      'Globo-Chem',
      'Mr. Sparkle',
      'Globex Corporation',
      'LexCorp',
      'LuthorCorp',
      'North Central Positronics',
      'Omni Consimer Products',
      'Praxis Corporation',
      'Sombra Corporation',
      'Sto Plains Holdings',
      'Tessier-Ashpool',
      'Wayne Enterprises',
      'Wentworth Industries',
      'ZiffCorp',
      'Bluth Company',
      'Strickland Propane',
      'Thatherton Fuels',
      'Three Waters',
      'Water and Power',
      'Western Gas & Electric',
      'Mammoth Pictures',
      'Mooby Corp',
      'Gringotts',
      'Thrift Bank',
      'Flowers By Irene',
      'The Legitimate Businessmens Club',
      'Osato Chemicals',
      'Transworld Consortium',
      'Universal Export',
      'United Fried Chicken',
      'Virtucon',
      'Kumatsu Motors',
      'Keedsler Motors',
      'Powell Motors',
      'Industrial Automation',
      'Sirius Cybernetics Corporation',
      'U.S. Robotics and Mechanical Men',
      'Colonial Movers',
      'Corellian Engineering Corporation',
      'Incom Corporation',
      'General Products',
      'Leeding Engines Ltd.',
      'Blammo',
      'Input, Inc.',
      'Mainway Toys',
      'Videlectrix',
      'Zevo Toys',
      'Ajax',
      'Axis Chemical Co.',
      'Barrytron',
      'Carrys Candles',
      'Cogswell Cogs',
      'Spacely Sprockets',
      'General Forge and Foundry',
      'Duff Brewing Company',
      'Dunder Mifflin',
      'General Services Corporation',
      'Monarch Playing Card Co.',
      'Krustyco',
      'Initech',
      'Roboto Industries',
      'Primatech',
      'Sonky Rubber Goods',
      'St. Anky Beer',
      'Stay Puft Corporation',
      'Vandelay Industries',
      'Wernham Hogg',
      'Gadgetron',
      'Burleigh and Stronginthearm',
      'BLAND Corporation',
      'Nordyne Defense Dynamics',
      'Petrox Oil Company',
      'Roxxon',
      'McMahon and Tate',
      'Sixty Second Avenue',
      'Charles Townsend Agency',
      'Spade and Archer',
      'Megadodo Publications',
      'Rouster and Sideways',
      'C.H. Lavatory and Sons',
      'Globo Gym American Corp',
      'The New Firm',
      'SpringShield',
      'Compuglobalhypermeganet',
      'Data Systems',
      'Gizmonic Institute',
      'Initrode',
      'Taggart Transcontinental',
      'Atlantic Northern',
      'Niagular',
      'Plow King',
      'Big Kahuna Burger',
      'Big T Burgers and Fries',
      'Chez Quis',
      'Chotchkies',
      'The Frying Dutchman',
      'Klimpys',
      'The Krusty Krab',
      'Monks Diner',
      'Milliways',
      'Minuteman Cafe',
      'Taco Grande',
      'Tip Top Cafe',
      'Moes Tavern',
      'Central Perk',
      'Chasers'
    ]
    companies.sample
  end

  def random_icon
    [
      '<symbol id="icon-home3" viewBox="0 0 1024 1024">
        <path d="M1024 608l-192-192v-288h-128v160l-192-192-512 512v32h128v320h320v-192h128v192h320v-320h128z"></path>
      </symbol>',
      '<symbol id="icon-camera" viewBox="0 0 1024 1024">
        <path d="M304 608c0 114.876 93.124 208 208 208s208-93.124 208-208-93.124-208-208-208-208 93.124-208 208zM960 256h-224c-16-64-32-128-96-128h-256c-64 0-80 64-96 128h-224c-35.2 0-64 28.8-64 64v576c0 35.2 28.8 64 64 64h896c35.2 0 64-28.8 64-64v-576c0-35.2-28.8-64-64-64zM512 892c-156.85 0-284-127.148-284-284 0-156.85 127.15-284 284-284 156.852 0 284 127.15 284 284 0 156.852-127.146 284-284 284zM960 448h-128v-64h128v64z"></path>
      </symbol>',
      '<symbol id="icon-clubs" viewBox="0 0 1024 1024">
        <path d="M786.832 392.772c-59.032 0-112.086 24.596-149.852 64.694-15.996 16.984-43.762 37.112-73.8 54.81 14.11-53.868 58.676-121.7 89.628-151.456 39.64-38.17 63.984-91.83 63.984-151.5 0.006-114.894-91.476-208.096-204.788-209.32-113.32 1.222-204.796 94.426-204.796 209.318 0 59.672 24.344 113.33 63.986 151.5 30.954 29.756 75.52 97.588 89.628 151.456-30.042-17.7-57.806-37.826-73.8-54.81-37.768-40.098-90.82-64.694-149.85-64.694-114.386 0-207.080 93.664-207.080 209.328 0 115.638 92.692 209.338 207.080 209.338 59.042 0 112.082-25.356 149.85-65.452 16.804-17.872 46.444-40.138 78.292-58.632-3.002 147.692-73.532 256.168-145.318 298.906v37.742h384.014v-37.74c-71.792-42.736-142.32-151.216-145.32-298.906 31.852 18.494 61.488 40.768 78.292 58.632 37.766 40.094 90.808 65.452 149.852 65.452 114.386 0 207.078-93.7 207.078-209.338-0.002-115.664-92.692-209.328-207.080-209.328z"></path>
      </symbol>',
      '<symbol id="icon-bullhorn" viewBox="0 0 1024 1024">
        <path d="M1024 429.256c0-200.926-58.792-363.938-131.482-365.226 0.292-0.006 0.578-0.030 0.872-0.030h-82.942c0 0-194.8 146.336-475.23 203.754-8.56 45.292-14.030 99.274-14.030 161.502s5.466 116.208 14.030 161.5c280.428 57.418 475.23 203.756 475.23 203.756h82.942c-0.292 0-0.578-0.024-0.872-0.032 72.696-1.288 131.482-164.298 131.482-365.224zM864.824 739.252c-9.382 0-19.532-9.742-24.746-15.548-12.63-14.064-24.792-35.96-35.188-63.328-23.256-61.232-36.066-143.31-36.066-231.124 0-87.81 12.81-169.89 36.066-231.122 10.394-27.368 22.562-49.266 35.188-63.328 5.214-5.812 15.364-15.552 24.746-15.552 9.38 0 19.536 9.744 24.744 15.552 12.634 14.064 24.796 35.958 35.188 63.328 23.258 61.23 36.068 143.312 36.068 231.122 0 87.804-12.81 169.888-36.068 231.124-10.39 27.368-22.562 49.264-35.188 63.328-5.208 5.806-15.36 15.548-24.744 15.548zM251.812 429.256c0-51.95 3.81-102.43 11.052-149.094-47.372 6.554-88.942 10.324-140.34 10.324-67.058 0-67.058 0-67.058 0l-55.466 94.686v88.17l55.46 94.686c0 0 0 0 67.060 0 51.398 0 92.968 3.774 140.34 10.324-7.236-46.664-11.048-97.146-11.048-149.096zM368.15 642.172l-127.998-24.51 81.842 321.544c4.236 16.634 20.744 25.038 36.686 18.654l118.556-47.452c15.944-6.376 22.328-23.964 14.196-39.084l-123.282-229.152zM864.824 548.73c-3.618 0-7.528-3.754-9.538-5.992-4.87-5.42-9.556-13.86-13.562-24.408-8.962-23.6-13.9-55.234-13.9-89.078s4.938-65.478 13.9-89.078c4.006-10.548 8.696-18.988 13.562-24.408 2.010-2.24 5.92-5.994 9.538-5.994 3.616 0 7.53 3.756 9.538 5.994 4.87 5.42 9.556 13.858 13.56 24.408 8.964 23.598 13.902 55.234 13.902 89.078 0 33.842-4.938 65.478-13.902 89.078-4.004 10.548-8.696 18.988-13.56 24.408-2.008 2.238-5.92 5.992-9.538 5.992z"></path>
      </symbol>',
      '<symbol id="icon-cart" viewBox="0 0 1024 1024">
        <path d="M384 928c0 53.019-42.981 96-96 96s-96-42.981-96-96c0-53.019 42.981-96 96-96s96 42.981 96 96z"></path>
        <path class="path2" d="M1024 928c0 53.019-42.981 96-96 96s-96-42.981-96-96c0-53.019 42.981-96 96-96s96 42.981 96 96z"></path>
        <path class="path3" d="M1024 512v-384h-768c0-35.346-28.654-64-64-64h-192v64h128l48.074 412.054c-29.294 23.458-48.074 59.5-48.074 99.946 0 70.696 57.308 128 128 128h768v-64h-768c-35.346 0-64-28.654-64-64 0-0.218 0.014-0.436 0.016-0.656l831.984-127.344z"></path>
      </symbol>',
      '<symbol id="icon-lifebuoy" viewBox="0 0 1024 1024">
        <path d="M512 0c-282.77 0-512 229.23-512 512s229.23 512 512 512 512-229.23 512-512-229.23-512-512-512zM320 512c0-106.040 85.96-192 192-192s192 85.96 192 192-85.96 192-192 192-192-85.96-192-192zM925.98 683.476v0l-177.42-73.49c12.518-30.184 19.44-63.276 19.44-97.986s-6.922-67.802-19.44-97.986l177.42-73.49c21.908 52.822 34.020 110.73 34.020 171.476s-12.114 118.654-34.020 171.476v0zM683.478 98.020v0 0l-73.49 177.42c-30.184-12.518-63.276-19.44-97.988-19.44s-67.802 6.922-97.986 19.44l-73.49-177.422c52.822-21.904 110.732-34.018 171.476-34.018 60.746 0 118.654 12.114 171.478 34.020zM98.020 340.524l177.422 73.49c-12.518 30.184-19.442 63.276-19.442 97.986s6.922 67.802 19.44 97.986l-177.42 73.49c-21.906-52.822-34.020-110.73-34.020-171.476s12.114-118.654 34.020-171.476zM340.524 925.98l73.49-177.42c30.184 12.518 63.276 19.44 97.986 19.44s67.802-6.922 97.986-19.44l73.49 177.42c-52.822 21.904-110.73 34.020-171.476 34.020-60.744 0-118.654-12.114-171.476-34.020z"></path>
      </symbol>',
      '<symbol id="icon-user-tie" viewBox="0 0 1024 1024">
        <path d="M320 192c0-106.039 85.961-192 192-192s192 85.961 192 192c0 106.039-85.961 192-192 192s-192-85.961-192-192zM768.078 448h-35.424l-199.104 404.244 74.45-372.244-96-96-96 96 74.45 372.244-199.102-404.244h-35.424c-127.924 0-127.924 85.986-127.924 192v320h768v-320c0-106.014 0-192-127.922-192z"></path>
      </symbol>',
      '<symbol id="icon-cog" viewBox="0 0 1024 1024">
        <path d="M933.79 610.25c-53.726-93.054-21.416-212.304 72.152-266.488l-100.626-174.292c-28.75 16.854-62.176 26.518-97.846 26.518-107.536 0-194.708-87.746-194.708-195.99h-201.258c0.266 33.41-8.074 67.282-25.958 98.252-53.724 93.056-173.156 124.702-266.862 70.758l-100.624 174.292c28.97 16.472 54.050 40.588 71.886 71.478 53.638 92.908 21.512 211.92-71.708 266.224l100.626 174.292c28.65-16.696 61.916-26.254 97.4-26.254 107.196 0 194.144 87.192 194.7 194.958h201.254c-0.086-33.074 8.272-66.57 25.966-97.218 53.636-92.906 172.776-124.594 266.414-71.012l100.626-174.29c-28.78-16.466-53.692-40.498-71.434-71.228zM512 719.332c-114.508 0-207.336-92.824-207.336-207.334 0-114.508 92.826-207.334 207.336-207.334 114.508 0 207.332 92.826 207.332 207.334-0.002 114.51-92.824 207.334-207.332 207.334z"></path>
      </symbol>',
      '<symbol id="icon-bug" viewBox="0 0 1024 1024">
        <path d="M1024 576v-64h-193.29c-5.862-72.686-31.786-139.026-71.67-192.25h161.944l70.060-280.24-62.090-15.522-57.94 231.76h-174.68c-0.892-0.694-1.796-1.374-2.698-2.056 6.71-19.502 10.362-40.422 10.362-62.194 0.002-105.76-85.958-191.498-191.998-191.498s-192 85.738-192 191.5c0 21.772 3.65 42.692 10.362 62.194-0.9 0.684-1.804 1.362-2.698 2.056h-174.68l-57.94-231.76-62.090 15.522 70.060 280.24h161.944c-39.884 53.222-65.806 119.562-71.668 192.248h-193.29v64h193.37c3.802 45.664 15.508 88.812 33.638 127.75h-123.992l-70.060 280.238 62.090 15.524 57.94-231.762h112.354c58.692 78.032 147.396 127.75 246.66 127.75s187.966-49.718 246.662-127.75h112.354l57.94 231.762 62.090-15.524-70.060-280.238h-123.992c18.13-38.938 29.836-82.086 33.636-127.75h193.37z"></path>
      </symbol>',
      '<symbol id="icon-leaf" viewBox="0 0 1024 1024">
        <path d="M1011.328 134.496c-110.752-83.928-281.184-134.034-455.91-134.034-216.12 0-392.226 75.456-483.16 207.020-42.708 61.79-66.33 134.958-70.208 217.474-3.454 73.474 8.884 154.726 36.684 242.146 94.874-284.384 359.82-507.102 665.266-507.102 0 0-285.826 75.232-465.524 308.192-0.112 0.138-2.494 3.090-6.614 8.698-36.080 48.278-67.538 103.162-91.078 165.328-39.87 94.83-76.784 224.948-76.784 381.782h128c0 0-19.43-122.222 14.36-262.79 55.89 7.556 105.858 11.306 150.852 11.306 117.678 0 201.37-25.46 263.388-80.124 55.568-48.978 86.198-114.786 118.624-184.456 49.524-106.408 105.654-227.010 268.654-320.152 9.33-5.332 15.362-14.992 16.056-25.716s-4.040-21.080-12.606-27.572z"></path>
      </symbol>',
      '<symbol id="icon-rocket" viewBox="0 0 1024 1024">
        <path d="M704 64l-320 320h-192l-192 256c0 0 203.416-56.652 322.066-30.084l-322.066 414.084 421.902-328.144c58.838 134.654-37.902 328.144-37.902 328.144l256-192v-192l320-320 64-320-320 64z"></path>
      </symbol>',
      '<symbol id="icon-airplane" viewBox="0 0 1024 1024">
        <path d="M768 639.968l-182.82-182.822 438.82-329.15-128.010-127.996-548.52 219.442-172.7-172.706c-49.78-49.778-119.302-61.706-154.502-26.508-35.198 35.198-23.268 104.726 26.51 154.5l172.686 172.684-219.464 548.582 127.99 128.006 329.19-438.868 182.826 182.828v255.98h127.994l63.992-191.988 191.988-63.996v-127.992l-255.98 0.004z"></path>
      </symbol>',
      '<symbol id="icon-truck" viewBox="0 0 1024 1024">
        <path d="M1024 576l-128-256h-192v-128c0-35.2-28.8-64-64-64h-576c-35.2 0-64 28.8-64 64v512l64 64h81.166c-10.898 18.832-17.166 40.678-17.166 64 0 70.692 57.308 128 128 128s128-57.308 128-128c0-23.322-6.268-45.168-17.166-64h354.334c-10.898 18.832-17.168 40.678-17.168 64 0 70.692 57.308 128 128 128s128-57.308 128-128c0-23.322-6.27-45.168-17.168-64h81.168v-192zM704 576v-192h132.668l96 192h-228.668z"></path>
      </symbol>',
      '<symbol id="icon-shield" viewBox="0 0 1024 1024">
        <path d="M960 0l-448 128-448-128c0 0-4.5 51.698 0 128l448 140.090 448-140.090c4.498-76.302 0-128 0-128zM72.19 195.106c23.986 250.696 113.49 672.234 439.81 828.894 326.32-156.66 415.824-578.198 439.81-828.894l-439.81 165.358-439.81-165.358z"></path>
      </symbol>',
      '<symbol id="icon-power" viewBox="0 0 1024 1024">
        <path d="M384 0l-384 512h384l-256 512 896-640h-512l384-384z"></path>
      </symbol>'
    ].sample
  end
end
