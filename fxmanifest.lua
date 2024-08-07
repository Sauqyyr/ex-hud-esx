fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'qb-hud'
version '2.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {  
    'client.lua',
    'HRSGears.lua',
    'seatbelt.lua' 
}

server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/*',
    'html/index.html',
    'html/styles.css',
    'html/responsive.css',
    'html/app.js',
}
