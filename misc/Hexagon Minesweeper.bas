OPTION _EXPLICIT 'Bplus started 2019-08-08 from quick version of Hex Minesweeper and Minesweeper Custom Field
' 2021-01-19 update move all ogg files into separate sub folder  for Windows users
'============================================================================================================
'
'         Hex Minesweeper v3.1W: Field Customization, Sound Effects and mod Crater Maker!
'
'                                      bplus mod 2021-01-19
'=============================================================================================================

' Attention: this program creates a file: "Hexagon Minefield Custom Specs.txt"
' that you edit with your text editor, if you select that option in the opening screen menu.

' 2019-08-13 Hex Minesweeper Custom and Sound.bas add ogg file sound effects
'   Public domain .ogg files source
'   https://bigsoundbank.com/detail-0029-computer-mouse.html
'   and bomb #6: https://www.mediacollege.com/downloads/sound-effects/explosion/

'2020-02-09 adding Crater Maker effect I devloped for SmallBASIC 2020-02-08 should work even better with QB64.
'                                      It does indeed!!!!
'
'2020-02-10 refined Crater Maker to scale to board size and Bombsound time of blast
'

DEFINT A-Z
CONST P2 = 6.28318531
'to make things easy set cellR as const at 25
CONST cellR = 25 ' which makes the following constant
DIM SHARED xspacing!, yspacing!
xspacing! = 2 * cellR * COS(_D2R(30)): yspacing! = cellR * (1 + SIN(_D2R(30)))
DIM SHARED xmax, ymax, Xarrd, Yarrd, mines 'set all this in customField sub

'sound events
DIM SHARED ToggleSnd AS LONG, BombSnd AS LONG, ApplauseSnd AS LONG, openSnd AS LONG
DIM SHARED SwooshSnd AS LONG

_TITLE "Hexagon Minesweeper v3.1W: Customize, Sound Effects and now Crater Maker"
DIM ogg$
ogg$ = "Ogg Files\"

ToggleSnd = _SNDOPEN(ogg$ + "Toggle.ogg")
openSnd = _SNDOPEN(ogg$ + "Ticking.ogg")
BombSnd = _SNDOPEN(ogg$ + "bomb.ogg")
ApplauseSnd = _SNDOPEN(ogg$ + "Applause sm.ogg")
SwooshSnd = _SNDOPEN(ogg$ + "Flyby.ogg")
'_SNDPLAY SwooshSnd: IF SwooshSnd = 0 THEN PRINT " not loaded." ELSE PRINT "OK loaded.": END
'rnd reveal sounds
DIM SHARED rndSnd(28) AS LONG
rndSnd(0) = _SNDOPEN(ogg$ + "357 shot.ogg")
rndSnd(1) = _SNDOPEN(ogg$ + "alarm.ogg")
rndSnd(2) = _SNDOPEN(ogg$ + "Apple bite.ogg")
rndSnd(3) = _SNDOPEN(ogg$ + "Barkings.ogg")
rndSnd(4) = _SNDOPEN(ogg$ + "Bike.ogg")
rndSnd(5) = _SNDOPEN(ogg$ + "brake.ogg")
rndSnd(6) = _SNDOPEN(ogg$ + "bumble bee.ogg")
rndSnd(7) = _SNDOPEN(ogg$ + "creaking.ogg")
rndSnd(8) = _SNDOPEN(ogg$ + "crows.ogg")
rndSnd(9) = _SNDOPEN(ogg$ + "Ding.ogg")
rndSnd(10) = _SNDOPEN(ogg$ + "dinggg.ogg")
rndSnd(11) = _SNDOPEN(ogg$ + "Donkey.ogg")
rndSnd(12) = _SNDOPEN(ogg$ + "elec phone.ogg")
rndSnd(13) = _SNDOPEN(ogg$ + "Fill mug.ogg")
rndSnd(14) = _SNDOPEN(ogg$ + "goat.ogg")
rndSnd(15) = _SNDOPEN(ogg$ + "hen.ogg")
rndSnd(16) = _SNDOPEN(ogg$ + "Horse.ogg")
rndSnd(17) = _SNDOPEN(ogg$ + "Kids.ogg")
rndSnd(18) = _SNDOPEN(ogg$ + "M scream.ogg")
rndSnd(19) = _SNDOPEN(ogg$ + "Male Hilarious.ogg")
rndSnd(20) = _SNDOPEN(ogg$ + "Marimba.ogg")
rndSnd(21) = _SNDOPEN(ogg$ + "neighing.ogg")
rndSnd(22) = _SNDOPEN(ogg$ + "polaris ring.ogg")
rndSnd(23) = _SNDOPEN(ogg$ + "pull top can.ogg")
rndSnd(24) = _SNDOPEN(ogg$ + "Punch line drum.ogg")
rndSnd(25) = _SNDOPEN(ogg$ + "Ring 2.ogg")
rndSnd(26) = _SNDOPEN(ogg$ + "Rooster.ogg")
rndSnd(27) = _SNDOPEN(ogg$ + "Unlock door.ogg")
rndSnd(28) = _SNDOPEN(ogg$ + "whook.ogg")
'DIM i 'test load and sounds
'FOR i = 10 TO 28
'    _SNDPLAY (rndSnd(i))
'    PRINT i;
'    IF rndSnd(i) = 0 THEN PRINT i; " not loaded." ELSE PRINT
'    _DELAY 2
'NEXT
'END

customField
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE (1280 - xmax) / 2 + 60, (760 - ymax) / 2
RANDOMIZE TIMER
TYPE boardType
    x AS SINGLE 'pixel location
    y AS SINGLE 'pixel location
    dx AS SINGLE 'for Crater making
    dy AS SINGLE ' ditto
    id AS INTEGER '0 to 6 neighbor mines
    reveal AS INTEGER ' 1 for marked, 0 hidden, -1 for revealed
    mine AS INTEGER '0 or -1
END TYPE
REDIM SHARED b(0 TO Xarrd + 1, 0 TO Yarrd + 1) AS boardType 'oversize the board to make it easy to count mines
DIM SHARED restart
DIM gameOver, cc, cr, mbN, s$, sz!
_TITLE _TRIM$(STR$(Yarrd * Xarrd - mines)) + " Cells to Free   Instructions: Left click Reveals, Right Marks Red"
restart = 1
WHILE 1
    gameOver = 0
    WHILE gameOver = 0
        IF restart THEN initialize
        mbN = 0
        getCell cc, cr, mbN
        IF mbN = 1 AND b(cc, cr).reveal = 0 THEN
            IF b(cc, cr).mine THEN 'ka boom
                makeCrater cc, cr
                's$ = "KA - BOOOMMMM!"           'comment out since post code
                'sz! = 1.2 * xmax / LEN(s$)
                'cText xmax / 2, ymax / 2, sz!, &HFF000000, s$
                'cText xmax / 2 - 4, ymax / 2 - 4, sz!, &HFFFF0000, s$
                'cText xmax / 2 - 8, ymax / 2 - 8, sz!, &HFFFFFF00, s$
                gameOver = -1
                _DELAY 4
            ELSE
                b(cc, cr).reveal = -1: showCell cc, cr
                IF b(cc, cr).id = 0 THEN
                    sweepZeros cc, cr
                ELSE
                    _SNDPLAY rndSnd(INT(RND * 29))
                END IF
            END IF
        ELSEIF mbN = 2 THEN
            _SNDPLAY ToggleSnd
            IF b(cc, cr).reveal = 1 THEN
                b(cc, cr).reveal = 0: showCell cc, cr
            ELSE
                IF b(cc, cr).reveal = 0 THEN b(cc, cr).reveal = 1: showCell cc, cr
            END IF
        END IF
        IF TFwin THEN
            s$ = "Good Job!"
            sz! = 1.2 * xmax / LEN(s$)
            cText xmax / 2, ymax / 2, sz!, &HFF000000, s$
            cText xmax / 2 - 1, ymax / 2 - 2, sz!, &HFF000055, s$
            _DELAY 4
            _SNDPLAY ApplauseSnd
            _DELAY 7
            gameOver = -1
        END IF
        _LIMIT 60
    WEND
    restart = 1
WEND

NoOff:
DATA 1,0,0,-1,0,1,-1,-1,-1,0,-1,1

xOff:
DATA -1,0,0,-1,0,1,1,-1,1,0,1,1

SUB makeCrater (col, row)
    TYPE Particle
        x AS SINGLE
        y AS SINGLE
        dx AS SINGLE
        dy AS SINGLE
        sz AS SINGLE
        c AS _UNSIGNED LONG
        type AS INTEGER
    END TYPE

    DIM nP, r, c, a!, i, ra!, red!, j, stopper
    nP = 25 * Xarrd * Yarrd
    DIM p(nP) AS Particle
    _SNDPLAY BombSnd
    _DELAY .500 'need a fairly long delay before actually hear sound
    LINE (0, 0)-(xmax, ymax), &HFFFFFFFF, BF
    _DELAY .01
    CLS
    FOR r = 1 TO Yarrd 'show all mines
        FOR c = 1 TO Xarrd
            IF b(c, r).mine THEN b(c, r).reveal = -1
            showCell c, r
            a! = _ATAN2(b(c, r).y - b(col, row).y, b(c, r).x - b(col, row).x)
            b(c, r).dx = .005 * Xarrd * Yarrd * COS(a!)
            b(c, r).dy = .005 * Xarrd * Yarrd * SIN(a!)
        NEXT
    NEXT
    FOR i = 0 TO nP
        p(i).x = b(col, row).x + RND * 2 * cellR - cellR
        p(i).y = b(col, row).y + RND * 2 * cellR - cellR
        p(i).sz = RND * 6.5 + .1
        ra! = RND * P2
        p(i).dx = .09 * Xarrd * Yarrd / p(i).sz * COS(ra!)
        p(i).dy = .09 * Xarrd * Yarrd / p(i).sz * SIN(ra!)
        red! = RND * 100
        p(i).c = _RGB32(red!, .5 * red! + .1 * red! * RND - .05 * red!, .25 * red! + .05 * red! * RND - .025 * red!)
        p(i).type = INT(RND * 2)
    NEXT
    stopper = .5 * nP 'orig .3
    FOR i = 1 TO 170 'make a Crater!!! maybe runs to long try 70 from original post 270
        CLS
        FOR r = 1 TO Yarrd 'redraw board with cells moved
            FOR c = 1 TO Xarrd
                IF r = row AND c = col THEN
                ELSE
                    IF i > 70 THEN
                        b(c, r).dx = .9 * b(c, r).dx
                        b(c, r).dy = .9 * b(c, r).dy
                    END IF
                    b(c, r).x = b(c, r).x + b(c, r).dx
                    b(c, r).y = b(c, r).y + b(c, r).dy
                    showCell c, r
                END IF
            NEXT
        NEXT
        FOR j = 1 TO stopper
            IF p(j).type THEN
                fcirc p(j).x, p(j).y, p(j).sz, p(j).c
            ELSE
                LINE (p(j).x - .5 * p(i).sz, p(j).y - .5 * p(j).sz)-STEP(p(j).sz, p(j).sz), p(j).c, BF
            END IF
            p(j).x = p(j).x + p(j).dx
            p(j).y = p(j).y + p(j).dy
            p(j).dx = .97 * p(j).dx ' original post .992
            p(j).dy = .97 * p(j).dy
        NEXT
        _DISPLAY
        _LIMIT 35
        IF i < 70 THEN stopper = stopper + 80 ' ELSE stopper = stopper + 1
        IF stopper > nP THEN stopper = nP
    NEXT
    _AUTODISPLAY
END SUB

'set all these 'DIM SHARED xmax, ymax, XarrD, YarrD, mines
SUB customField
    DIM fName$, fe, fLine$, p, inCnt, beenHere, allow$, choice$

    fName$ = "Hexagon Minefield Custom Specs.txt"
    IF _FILEEXISTS(fName$) THEN fe = -1 ELSE fe = 0
    allow$ = "12" + CHR$(27)
    PRINT
    PRINT "     Hexagom Minesweeper options:"
    PRINT
    PRINT "  1. Use mine field settings: 10 X 10 cells and 10 mines."
    PRINT "  2. Customize your own field settings."
    IF fe THEN PRINT "  3. Use the last customized mine field settings.": allow$ = allow$ + "3"
    PRINT
    PRINT "     or press esc to quit."
    choice$ = getChar$(allow$)
    SELECT CASE choice$
        CASE "1": xmax = 800: ymax = 600: Xarrd = 10: Yarrd = 10: mines = 10
        CASE "2": GOSUB editCustom
        CASE "3": GOSUB loadCustom
        CASE ELSE: SYSTEM
    END SELECT
    xmax = (Xarrd + 2.5) * xspacing!: ymax = (Yarrd + 2) * yspacing!
    EXIT SUB

    editCustom:
    IF fe = 0 THEN
        OPEN fName$ FOR OUTPUT AS #1
        PRINT #1, " "
        PRINT #1, "          Custom Field Specs For Your Hexagon Minesweeper Game"
        PRINT #1, " "
        PRINT #1, " We will be sizing the screen according to a constant cell radius of 25"
        PRINT #1, " and then numbers filled in here."
        PRINT #1, " "
        PRINT #1, " Please fill out the right side of all Equal signs."
        PRINT #1, " "
        PRINT #1, "   X dimensions across the screen:"
        PRINT #1, "         Your Max Screen Width (pixels) = "
        PRINT #1, "      Number of Horizontal Cells Across = "
        PRINT #1, " "
        PRINT #1, "   Y dimensions going down:"
        PRINT #1, "        Your Max Screen Height (pixels) = "
        PRINT #1, "                   Number of Cells Down = "
        PRINT #1, " "
        PRINT #1, "The percent of mines (8 easy - 15 hard) = "
        PRINT #1, " "
        PRINT #1, "    To finish, Save the file and then close the editor."
        CLOSE #1
    END IF
    ' I picked up this shortcut from Ken, normally I would call a text editor that I don't know if you have!
    SHELL fName$
    GOSUB loadCustom
    RETURN

    loadCustom:
    beenHere = beenHere + 1 'we'll give it 5 tries
    IF beenHere > 5 THEN
        PRINT "OK we tried 5 times, going with default settings..."
        xmax = 800: ymax = 600: Xarrd = 10: Yarrd = 10: mines = 10
        RETURN
    END IF
    inCnt = 0
    OPEN fName$ FOR INPUT AS #1
    WHILE EOF(1) = 0 ' look to get 5 values from 5 = signs
        LINE INPUT #1, fLine$
        p = INSTR(fLine$, "=")
        IF p > 0 THEN
            inCnt = inCnt + 1
            SELECT CASE inCnt
                CASE 1: xmax = VAL(rightOf$(fLine$, "="))
                CASE 2: Xarrd = VAL(rightOf$(fLine$, "="))
                CASE 3: ymax = VAL(rightOf$(fLine$, "="))
                CASE 4: Yarrd = VAL(rightOf$(fLine$, "="))
                CASE 5: mines = VAL(rightOf$(fLine$, "=")) * Xarrd * Yarrd / 100
            END SELECT
            IF inCnt = 5 THEN EXIT WHILE
        END IF
    WEND
    CLOSE #1
    IF inCnt = 5 THEN 'alternate exit from gosub
        IF xmax >= (Xarrd + 2.5) * xspacing! THEN
            IF ymax < (Yarrd + 2) * yspacing! THEN 'all good
                PRINT "Opps, Screen height is not big enough for Y cells down."
            ELSE
                RETURN
            END IF
        ELSE
            PRINT "Opps, Screen width is not big enough for X cells across."
        END IF
    ELSE
        PRINT "We did not get everything filled out by = signs."
    END IF
    PRINT: PRINT "Press any to continue.. "
    SLEEP
    SHELL fName$
    GOTO loadCustom
END SUB

SUB initialize ()
    DIM minesPlaced, rx, ry, x, y, nMines, xoffset!
    CLS
    _SNDPLAY openSnd
    restart = 0
    REDIM b(0 TO Xarrd + 1, 0 TO Yarrd + 1) AS boardType
    minesPlaced = 0
    WHILE minesPlaced < mines
        rx = INT(RND * Xarrd) + 1: ry = INT(RND * Yarrd) + 1
        IF b(rx, ry).mine = 0 THEN
            b(rx, ry).mine = -1: minesPlaced = minesPlaced + 1
        END IF
    WEND
    'count mines amoung the neighbors
    FOR y = 1 TO Yarrd
        IF y MOD 2 = 0 THEN xoffset! = .5 * xspacing! ELSE xoffset! = 0
        FOR x = 1 TO Xarrd
            IF b(x, y).mine <> -1 THEN 'not already a mine
                '2 sets of neighbors depending if x offset or not
                IF xoffset! > .1 THEN
                    nMines = b(x - 1, y).mine + b(x, y - 1).mine + b(x, y + 1).mine
                    nMines = nMines + b(x + 1, y - 1).mine + b(x + 1, y).mine + b(x + 1, y + 1).mine
                ELSE
                    nMines = b(x + 1, y).mine + b(x, y - 1).mine + b(x, y + 1).mine
                    nMines = nMines + b(x - 1, y - 1).mine + b(x - 1, y).mine + b(x - 1, y + 1).mine
                END IF
                b(x, y).id = -nMines
            ELSE
                b(x, y).id = 0
            END IF
            b(x, y).x = x * xspacing! + xoffset! + .5 * xspacing!
            b(x, y).y = y * yspacing! + .5 * yspacing!
            b(x, y).reveal = 0
            showCell x, y
        NEXT
    NEXT
END SUB

SUB showCell (c, r)
    DIM da, x!, y!, lastx!, lasty!, clr AS _UNSIGNED LONG
    SELECT CASE b(c, r).reveal
        CASE -1: IF b(c, r).mine THEN clr = &HFF883300 ELSE clr = &HFFFFFFFF 'revealed  white with number of mine neighbors
        CASE 0: clr = &HFF008800 'hidden green
        CASE 1: clr = &HFFFF0000 'marked red
    END SELECT
    lastx! = b(c, r).x + cellR * COS(_D2R(-30))
    lasty! = b(c, r).y + cellR * SIN(_D2R(-30))
    FOR da = 30 TO 330 STEP 60
        x! = b(c, r).x + cellR * COS(_D2R(da))
        y! = b(c, r).y + cellR * SIN(_D2R(da))
        LINE (lastx!, lasty!)-(x!, y!), &HFFFF00FF
        lastx! = x!: lasty! = y!
    NEXT
    PAINT (b(c, r).x, b(c, r).y), clr, &HFFFF00FF
    IF b(c, r).reveal = -1 THEN
        'cText b(c, r).x, b(c, r).y, 15, &HFF000000, _TRIM$(STR$(c)) + "," + _TRIM$(STR$(r))
        IF b(c, r).id > 0 THEN cText b(c, r).x, b(c, r).y, 35, &HFF000000, _TRIM$(STR$(b(c, r).id))
        IF b(c, r).mine = -1 THEN cText b(c, r).x, b(c, r).y, 35, &HFFFFFFFF, "*"
    END IF
END SUB

FUNCTION TFwin
    DIM c, x, y
    FOR y = 1 TO Yarrd
        FOR x = 1 TO Xarrd
            IF b(x, y).reveal = -1 AND b(x, y).mine = 0 THEN c = c + 1
        NEXT
    NEXT
    IF c = Xarrd * Yarrd - mines THEN TFwin = -1
END FUNCTION

SUB getCell (returnCol AS INTEGER, returnRow AS INTEGER, mbNum AS INTEGER)
    DIM m, mx, my, mb1, mb2, r, c
    WHILE _MOUSEINPUT: WEND
    mb1 = _MOUSEBUTTON(1): mb2 = _MOUSEBUTTON(2)
    IF mb1 THEN mbNum = 1
    IF mb2 THEN mbNum = 2
    IF mb1 OR mb2 THEN '                      get last place mouse button was down
        WHILE mb1 OR mb2 '                    wait for mouse button release as a "click"
            m = _MOUSEINPUT: mb1 = _MOUSEBUTTON(1): mb2 = _MOUSEBUTTON(2)
            mx = _MOUSEX: my = _MOUSEY
        WEND
        FOR r = 1 TO Yarrd
            FOR c = 1 TO Xarrd
                IF ((mx - b(c, r).x) ^ 2 + (my - b(c, r).y) ^ 2) ^ .5 < .5 * xspacing! THEN
                    returnCol = c: returnRow = r: EXIT SUB
                END IF
            NEXT
        NEXT
        mbNum = 0 'still here then clicked wrong
    END IF
END SUB

SUB sweepZeros (col, row) ' recursive sweep
    DIM c, r, cMin, cMax, rMin, rMax, x, y, id
    _SNDPLAY SwooshSnd
    c = col: r = row 'get copies for recursive sub
    IF c > 2 THEN cMin = c - 1 ELSE cMin = 1
    IF c < Xarrd - 1 THEN cMax = c + 1 ELSE cMax = Xarrd
    IF r > 2 THEN rMin = r - 1 ELSE rMin = 1
    IF r < Yarrd - 1 THEN rMax = r + 1 ELSE rMax = Yarrd
    FOR y = rMin TO rMax
        FOR x = cMin TO cMax
            IF b(x, y).reveal = 0 THEN
                id = b(x, y).id
                IF b(x, y).mine = 0 AND id = 0 THEN
                    b(x, y).reveal = -1 'mark played
                    showCell x, y
                    sweepZeros x, y
                ELSE
                    IF b(x, y).mine = 0 AND id >= 1 AND id <= 8 THEN
                        b(x, y).reveal = -1
                        showCell x, y
                    END IF
                END IF
            END IF
        NEXT
    NEXT
END SUB

'center the text around (x, y) point, needs a graphics screen!
SUB cText (x, y, textHeight AS SINGLE, K AS _UNSIGNED LONG, txt$)
    DIM fg AS _UNSIGNED LONG, cur&, I&, mult!, xlen
    fg = _DEFAULTCOLOR
    'screen snapshot
    cur& = _DEST
    I& = _NEWIMAGE(8 * LEN(txt$), 16, 32)
    _DEST I&
    COLOR K, _RGBA32(0, 0, 0, 0)
    _PRINTSTRING (0, 0), txt$
    mult! = textHeight / 16
    xlen = LEN(txt$) * 8 * mult!
    _PUTIMAGE (x - .5 * xlen, y - .5 * textHeight)-STEP(xlen, textHeight), I&, cur&
    COLOR fg
    _FREEIMAGE I&
END SUB

FUNCTION rightOf$ (source$, of$)
    IF INSTR(source$, of$) > 0 THEN rightOf$ = MID$(source$, INSTR(source$, of$) + LEN(of$))
END FUNCTION

FUNCTION getChar$ (fromStr$)
    DIM OK AS INTEGER, k$
    WHILE OK = 0
        k$ = INKEY$
        IF LEN(k$) THEN
            IF INSTR(fromStr$, k$) <> 0 THEN OK = -1
        END IF
        _LIMIT 200
    WEND
    _KEYCLEAR
    getChar$ = k$
END SUB

'from Steve Gold standard
SUB fcirc (CX AS INTEGER, CY AS INTEGER, R AS INTEGER, C AS _UNSIGNED LONG)
    DIM Radius AS INTEGER, RadiusError AS INTEGER
    DIM X AS INTEGER, Y AS INTEGER
    Radius = ABS(R): RadiusError = -Radius: X = Radius: Y = 0
    IF Radius = 0 THEN PSET (CX, CY), C: EXIT SUB
    LINE (CX - X, CY)-(CX + X, CY), C, BF
    WHILE X > Y
        RadiusError = RadiusError + Y * 2 + 1
        IF RadiusError >= 0 THEN
            IF X <> Y + 1 THEN
                LINE (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                LINE (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            END IF
            X = X - 1
            RadiusError = RadiusError - X * 2
        END IF
        Y = Y + 1
        LINE (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        LINE (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    WEND
END SUB



