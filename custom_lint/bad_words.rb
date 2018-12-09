module CustomLint
  class BadWords

    BAD_WORD_LIST = [
      'Kad tau kelnėse ežys išdygtų',
      'Kad tave šikantį sutrauktų',
      'Kad tu aukštielnikas apsitriestum',
      'Kūtvela pasipūtęs',
      'Rupūžė',
      'Žaltys',
      'Po ššššimts kalakutų',
      'Žžžžalia rūta',
      'Lysk tu vabalo blauzdon',
      'Ot rūūūūkštele',
      'Ot tu šuns pasturgali',
      'Ššššššokoladas',
      'Birbink genį',
      'Pakasyk sliekui pažastį',
      'Eik teptukų gamyba užsiimti',
      'Kapok varškę',
      'Galvijas',
      'Karvė',
      'Kiaulė',
      'Kad tave perkūnas [nutrenktų]',
      'Asilas',
      'Eik skradžiai žemės',
      'Kad tave velnias nusineštų',
      'Eik debesų spardyti',
      'Velnio išpera',
      'Rupūs miltai',
      'Eik po velniais',
      'Mižnius',
      'Davatka',
      'Kvailys',
      'Po galais',
      'Po kelmais',
      'Prakeikimas',
      'Šimts perkūnų',
      'Velniai griebtų',
      'Velniai rautų',
      'Šuns užkulni',
      'Rupūže purvinom akim',
      'Uostyk slieko pažastį',
      'Kad tu ištintum, kaip avilys',
      'Eik (tu) į peklą autų skalbti',
      'Eik (tu) kialėms uodegas mazgoti',
      'Po šimts gegučių',
      'Tu paršo koja užpakalinė',
      'Tu šuns kumpi',
      'Šūdiną'
    ]

    def scan
      for bad_word in BAD_WORD_LIST
        result = `ack -r '#{bad_word}' . --ignore-case --ignore-dir=custom_lint/`
        if result.length > 0
          p result
        end
      end
    end
  end
end

CustomLint::BadWords.new.scan