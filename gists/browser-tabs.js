// run from Terminal: 
// osascript -l JavaScript myscript.js


// let browser = Application('Safari')
let browser = Application('Google Chrome')


const RESET = '\033[0m'
const GREEN = '\033[32;1m'
const URL = '\033[34;2m'
const RED = '\033[31;1m'

let tabs = ''



for (let i = 0; i < browser.windows.length; i++) {
    console.log(RED, '================ ' + 'window ' + i +  ' ================')
    tabs += '<h1>Window ' + i + '</h1>\n'
    tabs += '<ul>\n'
    for (let j = 0; j < browser.windows[i].tabs.length; j++) {
        let tab_name = browser.windows[i].tabs[j].name()
        let tab_url  = browser.windows[i].tabs[j].url()
        let tab = ''
        tab += '<li>'
        hostname = /^(?:\w+\:\/\/)?([^\/]+)(.*)$/.exec(tab_url)[1] // todo: make it more beautiful 
        tab += '<img align="center" src="https://s2.googleusercontent.com/s2/favicons?domain=' + hostname + '">'
        tab += '<a href="' + tab_url + '">'
        tab += tab_name
        tab += '</a></li>\n'
        tabs += tab
        console.log(GREEN, tab_name)
        console.log(URL, tab_url)
        console.log(RESET)
    }
    tabs += '</ul>\n\n\n'
}


var app = Application.currentApplication()
app.includeStandardAdditions = true

fileStr = $.NSString.alloc.initWithUTF8String(tabs)
fileStr.writeToFileAtomicallyEncodingError( '/Users/tandav/Desktop/tabs.html', true, $.NSUTF8StringEncoding, $() )

//app.doShellScript('echo' + tabs +  '> /Users/tandav/Desktop/1.txt')
//app.displayAlert(tabs)
//alert(tabs)
