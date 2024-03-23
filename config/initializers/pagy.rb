# frozen_string_literal: true

# require 'pagy/extras/countless'
require 'pagy/extras/headers'
require 'pagy/extras/metadata'

Pagy::I18n.load({ locale: 'pt-BR' }, { locale: 'en' })

Pagy::DEFAULT[:items] = 20

Pagy::DEFAULT.freeze
