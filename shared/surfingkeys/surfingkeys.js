//------------------------------------------------------------------------------------- 
// see https://github.com/SophiCeleste/SKSettings/blob/main/config.js 
//     https://github.com/Marin-Kitagawa/surfingkeys_config/blob/main/settings.js

// ------------ TODOs ------------
// Note: Surfingkeys is doing its best to make full use of keyboard for web browsing, but there are some limitations from Google Chrome itself, please see Brook Build of Chromium for a more thorough experience. Maybe in the futhre we can turn to Chromium ..

const maps = {}

maps.normal = [

    //---------------------------- Scroll Page / Element ---------------------------- 
    // // domain: /github\.com/  // only work for github, if it's null then work for global
    { old: 'h',         new: '_leftward',   hint: 'Scroll left',                        domain: '' },
    { old: 'i',         new: 'h',           hint: 'Select input field, insert',         domain: '' },
    { old: 'k',         new: 'i',           hint: 'Scroll up',                          domain: '' },
    { old: 'j',         new: 'k',           hint: 'Scroll down',                        domain: '' },
    { old: '_leftward', new: 'j',           hint: 'Scroll left',                        domain: '' },
    { old: '_leftward', new: '',            hint: 'Relrase, null',                      domain: '' },
    { old: 'l',         new: 'l',           hint: 'Scroll right',                       domain: '' },
    { old: 'e',         new: 'I',           hint: 'Scroll half page up',                domain: '' },
    { old: 'd',         new: 'K',           hint: 'Scroll half page down',              domain: '' },
    { old: 'U',         new: '<Ctrl-u>',    hint: 'Scroll full page up',                domain: '' },
    { old: 'P',         new: '<Ctrl-d>',    hint: 'Scroll full page down',              domain: '' },
    { old: 'gg',        new: 'gg',          hint: 'Scroll to top',                      domain: '' },
    { old: 'G',         new: 'G',           hint: 'Scroll to bottom',                   domain: '' },

    { old: '$',         new: 'L',           hint: 'Scroll right end',                   domain: '' },  // not work well ...
    { old: '0',         new: 'J',           hint: 'Scroll left end',                    domain: '' },
    { old: '%',         new: '%',           hint: 'Scroll percentage',                  domain: '' },

    { old: 'cS',        new: 'sr',          hint: 'Reset scroll target',                domain: '' },
    { old: 'cs',        new: 's;',          hint: 'Change scroll target',               domain: '' },
    { old: ';w',        new: 'u',           hint: 'Switch frames',                      domain: '' },
    { old: 'w',         new: 'U',           hint: 'Focus top frame',                    domain: '' },

    //---------------------------- Tabs ---------------------------- 
    { old: 't',       new: '',               hint: 'Release t',                     domain: '' },
    { old: 'on',      new: 'tn',             hint: 'Open a new tab',                domain: '' },
    { old: 'yT',      new: 'ty',             hint: 'Duplicate tab, non active',     domain: '' },
    { old: 'yt',      new: 'tt',             hint: 'duplucate tab',                 domain: '' },
    { old: 'E',       new: 'tj',             hint: 'Go tab left',                   domain: '' },
    { old: 'R',       new: 'tl',             hint: 'Go tab right',                  domain: '' },
    { old: 'g0',      new: 'tJ',             hint: 'Go to first tab',               domain: '' },
    { old: 'g$',      new: 'tL',             hint: 'Go to last tab',                domain: '' },
    { old: 'x',       new: 'x',              hint: 'Close current tab',             domain: '' },
    { old: 'x',       new: 'q',              hint: 'Close current tab',             domain: '' },
    { old: 'x',       new: 'Q',              hint: 'Close current tab',             domain: '' },
    { old: 'X',       new: 'X',              hint: 'Reopen closed tab',             domain: '' },
    { old: 'gxt',     new: 'cj',             hint: 'Close tab left',                domain: '' },
    { old: 'gxT',     new: 'cl',             hint: 'Close tab right',               domain: '' },
    { old: 'gx0',     new: 'CJ',             hint: 'Close all tabs on the left',    domain: '' },
    { old: 'gx$',     new: 'CL',             hint: 'Close all tabs on the right',   domain: '' },
    { old: 'gxx',     new: 'CC',             hint: 'Close all other tabs',          domain: '' },
    { old: 'gxp',     new: 'cs',             hint: 'Close playing tab',             domain: '' },
    { old: 'zr',      new: 'zr',             hint: 'Zoom reset',                    domain: '' },
    { old: 'zi',      new: 'zi',             hint: 'Zoom in',                       domain: '' },
    { old: 'zo',      new: 'zo',             hint: 'Zoom out',                      domain: '' },
    { old: '<Alt-p>', new: 'tp',             hint: 'Pin / unpin current tab',       domain: '' },
    { old: '<Alt-m>', new: 'ms',             hint: 'Mute / unmute current tab',     domain: '' },
    { old: 'W',       new: 'tmn',             hint: 'Move tab to another window',    domain: '' },
    { old: '<<',      new: 'tmj', hint: 'Move tab left',                 domain: '' },
    { old: '>>',      new: 'tml', hint: 'Move tab right',                domain: '' },

    //---------------------------- Help ---------------------------- 
    { old: '<Alt-s>', new: '<Ctrl-;>', hint: 'Toggle SurfingKeys on current site',                                      domain: '' },
    { old: '<Alt-i>', new: 'p',       hint: 'Enter pass through mode to temporarily suppress SurfingKeys',             domain: '' },
    { old: 'p',       new: 'ep',      hint: 'Enter ephemeral pass through mode to temporarily suppress SurfingKeys',   domain: '' },
    { old: '?',       new: '?',       hint: 'Show help',                                                               domain: '' },
    { old: '.',       new: '.',       hint: 'Repeat last action',                                                      domain: '' },

    //---------------------------- Mouse Click ---------------------------- 
    { old: 'cf',       new: ';f',       hint: 'Open multiple linew in a new tab',                domain: '' },
    { old: 'gi',       new: 'gi',       hint: 'Go to the first input field',                     domain: '' },
    { old: 'gf',       new: 'F',        hint: 'Open a link in a non-active new tab',             domain: '' },
    { old: 'C',        new: 'nf',       hint: 'Open a link in a non-active new tab',             domain: '' },
    { old: '[[',       new: '[[',       hint: 'Clicks the previous link on the current page',    domain: '' },
    { old: ']]',       new: ']]',       hint: 'Clicks the next link on the current page',        domain: '' },
    { old: ';m',       new: ';m',       hint: 'Mouse out final element',                         domain: '' },
    { old: ';fs',      new: 'sh',       hint: 'Display hints to focus scrollable elements',      domain: '' },
    { old: ';di',      new: ';di',      hint: 'Download image',                                  domain: '' },
    { old: 'O',        new: 'O',        hint: 'Open detected line from selected text',           domain: '' },
    { old: 'f',        new: 'f',        hint: 'Open a link in the current tab',                  domain: '' },
    { old: 'af',       new: 'af',       hint: 'Open a link in an active new tab',                domain: '' },

    { old: '<Ctrl-h>', new: 'mov',      hint: 'Mouse over element',                              domain: '' },
    { old: '<Ctrl-i>', new: '<Ctrl-h>', hint: 'open input field with vim editor',                domain: '' },
    { old: '<Ctrl-j>', new: 'mou',      hint: 'Mouse out element',                               domain: '' },
    { old: 'q',        new: 'ci',       hint: 'Click on an image or button',                     domain: '' },

   
    //---------------------------- Page Navigation ---------------------------- 
    { old: 'gp', new: 'gs', hint: 'Go to playing tab',                          domain: '' },
    { old: 'g?', new: 'R?', hint: 'Reload current tab without query string',    domain: '' },
    { old: 'g#', new: 'R#', hint: 'Reload current tab without hash fragment',   domain: '' },
    { old: 'gU', new: ';;', hint: 'Go to root URL',                             domain: '' },
    { old: 'S',  new: 'S',  hint: 'History back',                               domain: '' },
    { old: 'D',  new: 'D',  hint: 'History forward',                            domain: '' },
    { old: 'r',  new: 'r',  hint: 'Reload current tab',                         domain: '' },

    //---------------------------- Sessions ---------------------------- 
    { old: 'ZZ', new: 'ZZ', hint: 'Save session and quit',  domain: '' },
    { old: 'ZR', new: 'ZR', hint: 'Restore last session',   domain: '' },

    //---------------------------- Search Selected With ---------------------------- 
    { old: 'se', new: 'sk', hint: 'Search Wikipedia',       domain: '' },
    { old: 'ss', new: 'ss', hint: 'Search Stackoverflow',   domain: '' },
    { old: 'sh', new: 'si', hint: 'Search Github',          domain: '' },
    { old: 'sy', new: 'sy', hint: 'Search Youtube',         domain: '' },
    { old: 'sg', new: 'sg', hint: 'Search Google',          domain: '' },
    { old: 'sd', new: 'sd', hint: 'Search Duckduckgo',      domain: '' },
    { old: 'sb', new: 'sb', hint: 'Search Baidu',           domain: '' },
    { old: 'sw', new: 'sw', hint: 'Search Bing',            domain: '' },

    //---------------------------- Clipboard ---------------------------- 
    { old: 'yi', new: 'yi', hint: 'Yank input',             domain: '' },
    { old: 'yv', new: 'yt', hint: 'Yank text',              domain: '' },
    { old: 'yy', new: 'yy', hint: 'Yank current URL',       domain: '' },
    { old: 'yf', new: 'yf', hint: 'Yank form JSON',         domain: '' },

    //---------------------------- Vim-like Marks ---------------------------- 
    { old: 'm',        new: 'ma', hint: 'Add URL to marks',     domain: '' },
    { old: '\'',       new: 'M',  hint: 'Jump to mark',         domain: '' },
    { old: '<Ctrl-\'', new: 'am', hint: 'Jump to mark new tab', domain: '' },

    //---------------------------- Settings ---------------------------- 
    { old: ';e', new: ';e', hint: 'Edit settings',              domain: '' },
    { old: ';v', new: ';v', hint: 'Open neovim',                domain: '' },

    //---------------------------- Chrome URLs ---------------------------- 
    { old: 'gs', new: 'gs', hint: 'View page source',       domain: '' },
    { old: ';i', new: ';i', hint: 'Open Chrome inspect',    domain: '' },
    { old: ';j', new: ';j', hint: 'Close downloads',        domain: '' },

    //---------------------------- Misc ---------------------------- 
    { old: ';s',  new: ';s',    hint: 'Toggle PDF viewer',                  domain: '' },
    { old: ';t',  new: ';t',    hint: 'Translate selected text',            domain: '' },
    { old: ';dh', new: ';dh',   hint: 'Delete history older than 30 days',  domain: '' },
    { old: ';db', new: ';xb',   hint: 'Remove current bookmark',            domain: '' }
];

// Note: the same keys defined in other normal mode will conflict  
maps.omnibar = [
    //---------------------------- Unused ---------------------------- 
    // { old: 'Q',             new: '', hint: 'Open omnibar for translation',                      domain: '' },
    { old: 'om',            new: '', hint: 'Open URL from marks',                               domain: '' },
    // { old: '<Ctrl-d>',      new: '', hint: 'Delete focused item from bookmark / history',       domain: '' },
    { old: '<Ctrl-.>',      new: '', hint: 'Show results of next page',                         domain: '' },
    { old: '<Ctrl-,>',      new: '', hint: 'Show results of previous page',                     domain: '' },
    { old: '<Ctrl-c>',      new: '', hint: 'Copy selected item URL',                            domain: '' },
    { old: '<Ctrl-D>',      new: '', hint: 'Delete all listed items from bookmark / history',   domain: '' },
    { old: '<Ctrl-r>',      new: '', hint: 'Resort history by visit count or time',             domain: '' },
    { old: '<ArrowDown>',   new: '', hint: 'Cycle through candidates',                          domain: '' },
    { old: '<ArrowUp>',     new: '', hint: 'Cycle backwards through candidates',                domain: '' },
    { old: '<Ctrl-n>',      new: '', hint: 'Cycle through candidates',                          domain: '' },
    { old: '<Ctrl-p>',      new: '', hint: 'Cycle backwards through candidates',                domain: '' },

    //---------------------------- Omnibar ---------------------------- 
    { old: 'go',            new: 'go',          hint: 'Open URL in current tab',            domain: '' },
    { old: 'ab',            new: 'ab',          hint: 'Bookmark page to folder',            domain: '' },
    { old: 'oi',            new: 'oi',          hint: 'Incognito',                          domain: '' },
    { old: 'og',            new: 'og',          hint: 'Open search g',                      domain: '' },
    { old: 'od',            new: 'od',          hint: 'Open search d',                      domain: '' },
    { old: 'ob',            new: 'ob',          hint: 'Open search b',                      domain: '' },
    { old: 'oe',            new: 'ok',          hint: 'Open search k',                      domain: '' },
    { old: 'ow',            new: 'ow',          hint: 'Open search w',                      domain: '' },
    { old: 'os',            new: 'os',          hint: 'Open search s',                      domain: '' },
    { old: 'oy',            new: 'oy',          hint: 'Open search y',                      domain: '' },
    { old: 'ox',            new: 'ox',          hint: 'Open recently closed URL',           domain: '' },
    { old: 'oh',            new: 'oh',          hint: 'Open URL from history',              domain: '' },
    { old: ':',             new: ':',           hint: 'Open commands',                      domain: '' },
    // { old: 't',             new: 'ou',          hint: 'Open URL',                           domain: '' },
    { old: 'b',             new: 'b',           hint: 'Open a bookmark',                    domain: '' },
    { old: '<Ctrl-i>',      new: '<Ctrl-h>',    hint: 'Edit URL with vim then open',        domain: '' },
    { old: '<Ctrl-j>',      new: '<ctrl-j>',    hint: 'Toggle omnibar\'s position',         domain: '' },
    { old: '<Esc>',         new: '<Esc>',       hint: 'Close omnibar',                      domain: '' },
    { old: '<Ctrl-m>',      new: '<Ctrl-m>',    hint: 'Mark selected item',                 domain: '' },
    { old: '<Tab>',         new: '<Tab>',       hint: 'Cycle through candidates',           domain: '' },
    { old: '<Shift-Tab>',   new: '<Shift-Tab>', hint: 'Cycle backwards through candidates', domain: '' },
    { old: '<Tab>',         new: '<Ctrl-k>',    hint: 'Cycle through candidates',           domain: '' },
    { old: '<Shift-Tab>',   new: '<Ctrl-i>',    hint: 'Cycle backwards through candidates', domain: '' },
    { old: '<Ctrl-\'>',     new: '<Ctrl-\'>',   hint: 'Toggle quotes',                      domain: '' }
];

maps.visual = [
    //---------------------------- Unused ---------------------------- 
    { old: 'gr',    new: '', hint: 'Read selected text',            domain: '' },

    //---------------------------- Visual Mode ---------------------------- 
    { old: '/',             new: '/',               hint: 'Find',                                                   domain: '' },
    { old: 'zv',            new: 'zv',              hint: 'Enter visual mode and select entire element',            domain: '' },
    { old: '*',             new: '*',               hint: 'Find selected text',                                     domain: '' },
    { old: 'v',             new: 'v',               hint: 'Toggle visual mode',                                     domain: '' },
    { old: 'n',             new: 'n',               hint: 'Find next match',                                        domain: '' },
    { old: 'N',             new: 'N',               hint: 'Find previous match',                                    domain: '' },
    { old: '0',             new: 'J',               hint: 'Go to beginning / end of previous line',                 domain: '' },
    { old: '$',             new: 'L',               hint: 'Go to end of previous line',                             domain: '' },  // not work well ...
    { old: 'l',             new: 'l',               hint: 'Cursor right',                                           domain: '' },
    { old: 'h',             new: 'h',               hint: 'Cursor left',                                            domain: '' },
    { old: 'j',             new: 'j',               hint: 'Cursor down',                                            domain: '' },
    { old: 'k',             new: 'k',               hint: 'Cursor up',                                              domain: '' },
    { old: 'w',             new: 'w',               hint: 'Go to beginning of next word',                           domain: '' },
    { old: 'e',             new: 'e',               hint: 'Go to beginning of next word',                           domain: '' },
    { old: 'b',             new: 'W',               hint: 'Go to the beginning of previous word',                   domain: '' },
    { old: '$',             new: 'L',               hint: 'Go to beginning / end of next line',                     domain: '' },
    { old: 'o',             new: 'o',               hint: 'Go to other end of selection',                           domain: '' },
    { old: '<Enter>',       new: '<Enter>',         hint: 'Click element under cursor',                             domain: '' },
    { old: '<Shift-Enter>', new: '<Shift-Enter>',   hint: 'Click element under cursor new tab',                     domain: '' },
    { old: 'zt',            new: 'zt',              hint: 'Move cursor to top of window',                           domain: '' },
    { old: 'zz',            new: 'zz',              hint: 'Move cursor to center of window',                        domain: '' },
    { old: 'zb',            new: 'zb',              hint: 'Move cursor to bottom of window',                        domain: '' },
    { old: 'f',             new: 'f',               hint: 'Jump to next <char>',                                    domain: '' },
    { old: 'F',             new: 'F',               hint: 'Jump to previous <char>',                                domain: '' },
    { old: ';',             new: '.',               hint: 'Repeat last f / F',                                      domain: '' },
    { old: ',',             new: ',',               hint: 'Repeat last f / F in opposite direction',                domain: '' },
    { old: 'p',             new: 'p',               hint: 'Expand selection to parent element',                     domain: '' },
    { old: 'V',             new: 'V',               hint: 'Select a (w)ord, (l)ine, (s)entence, or (p)aragraph',    domain: '' },
    { old: '<Ctrl-u>',      new: '<Ctrl-u>',        hint: 'Jump 20 lines up',                                       domain: '' },
    { old: '<Ctrl-d>',      new: '<Ctrl-d>',        hint: 'Jump 20 lines down',                                     domain: '' },
    { old: 't',             new: 'Q',               hint: 'Translate selected text',                                domain: '' },
    { old: 'q',             new: 'q',               hint: 'Translate selected word',                                domain: '' }
];

maps.insert = [
    //---------------------------- Unused ---------------------------- 
    { old: '<Ctrl-Alt-i>', new: '', hint: 'Open neovim for current field', domain: '' },

    //---------------------------- Insert Mode ---------------------------- 
    // { old: '<Ctrl-e>',      new: '<Ctrl-l>',    hint: 'Move cursor to end of line',                 domain: '' },
    // { old: '<Ctrl-f>',      new: '<Ctrl-j>',    hint: 'Move cursor to beginning of line',           domain: '' },
    // { old: '<Ctrl-u>',      new: '<Ctrl-d>',    hint: 'Delete all characters before the cursor',    domain: '' },
    // { old: '<Alt-b>',       new: '<Ctrl-w>',    hint: 'Jump back a word',                           domain: '' },
    // { old: '<Alt-f>',       new: '<Ctrl-b>',    hint: 'Jump forward a word',                        domain: '' },
    // { old: '<Alt-w>',       new: '<Alt-h>',     hint: 'Delete previous word',                       domain: '' },
    // { old: '<Alt-d>',       new: '<Alt-l>',     hint: 'Delete next word',                           domain: '' },
    // { old: '<Esc>',         new: '<Esc>',       hint: 'Exit insert mode',                           domain: '' },
    // { old: '<Ctrl-\'>',     new: '<Ctrl-\'>',   hint: 'Toggle quotes',                              domain: '' },
    { old: '<Ctrl-i>',      new: '<Ctrl-h>',    hint: 'Open vim for current field',                 domain: '' }
];

function mapNormal() {
    let key = maps.normal;
    for (let i = 0; i < key.length; i++) {
        if (key[i].new == '') {
            api.unmap(key[i].old);
            //console.log(i + ' empty');
        } else if (key[i].old == key[i].new) {
            //console.log(i + ' skip');
            continue;
        } else {
            //console.log(i + ' remap ' + key[i].hint);
            api.map(key[i].new, key[i].old, key[i].domain, key[i].hint);
            // api.unmap(key[i].old);
        }
    }
}

function mapOmnibar() {
    let key = maps.omnibar;
    for (let i = 0; i < key.length; i++) {
        if (key[i].new == '') {
            api.unmap(key[i].old);
            //console.log(i + ' empty');
        } else if (key[i].old == key[i].new) {
            //console.log(i + ' skip');
            continue;
        } else {
            //console.log(i + ' remap ' + key[i].hint);
            api.cmap(key[i].new, key[i].old, key[i].domain, key[i].hint);
            // api.unmap(key[i].old);
        }
    }
}

function mapVisual() {
    let key = maps.visual;
    for (let i = 0; i < key.length; i++) {
        if (key[i].new == '') {
            api.vunmap(key[i].old);
            //console.log(i + ' empty');
        } else if (key[i].old == key[i].new) {
            //console.log(i + ' skip');
            continue;
        } else {
            //console.log(i + ' remap ' + key[i].hint);
            api.vmap(key[i].new, key[i].old, key[i].domain, key[i].hint);
            // api.vunmap(key[i].old);
        }
    }
}

function mapInsert() {
    let key = maps.insert;
    for (let i = 0; i < key.length; i++) {
        if (key[i].new == '') {
            api.iunmap(key[i].old);
            //console.log(i + ' empty');
        } else if (key[i].old == key[i].new) {
            //console.log(i + ' skip');
            continue;
        } else {
            //console.log(i + ' remap ' + key[i].hint);
            api.imap(key[i].new, key[i].old, key[i].domain, key[i].hint);
            // api.iunmap(key[i].old);
        }
    }
}

mapNormal();
mapOmnibar();
mapVisual();
mapInsert();


// ------------------------------------------------------------------------------------------------
// Website shortcuts

// Personal and some often-used webs
const MY_GITHUB = "https://github.com/ZelongGuo";
const MY_WEBSITE = "https://zelongguo.github.io/";
const MY_RESEARGATE = "https://www.researchgate.net/";
const MY_BILIBILI = "https://www.bilibili.com/";
const MY_YOUTUBE = "https://www.youtube.com/";

// AI webs
const MY_DEEPSEEK = "https://chat.deepseek.com/";
const MY_GEMINI = "https://gemini.google.com/";
const MY_CHATGPT = "https://chatgpt.com/";

api.mapkey('<Space>gh', 'Open My GitHub', function() { window.open(MY_GITHUB, "_blank"); });
api.mapkey('<Space>mw', 'Open My Website', function() { window.open(MY_WEBSITE, "_blank"); });
api.mapkey('<Space>bl', 'Open Bilibili', function() { window.open(MY_BILIBILI, "_blank"); });
api.mapkey('<Space>yt', 'Open Youtube', function() { window.open(MY_YOUTUBE, "_blank"); });
api.mapkey('<Space>rg', 'Open Research Gate', function() { window.open(MY_RESEARGATE, "_blank"); });

api.mapkey('<Space>ds', 'Open Deepseek', function() { window.open(MY_DEEPSEEK, "_blank"); });
api.mapkey('<Space>ge', 'Open Gemini', function() { window.open(MY_GEMINI, "_blank"); });
api.mapkey('<Space>cg', 'Open ChatGPT', function() { window.open(MY_CHATGPT, "_blank"); });



