'> Merged with Zom-B's smart $include merger 0.51

' Best viewed with 120 or more columns

DEFDBL A-Z
OPTION BASE 1

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

CONST sqrt2 = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
CONST sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
CONST sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
CONST sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
CONST cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
CONST cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
CONST q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
CONST phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
CONST log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
CONST log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
CONST log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
CONST logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
CONST logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
CONST q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
CONST q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
CONST q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
CONST pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
CONST deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
CONST q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
CONST pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
CONST gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
CONST gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
CONST gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
CONST e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
CONST q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
CONST esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
CONST eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
CONST expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
CONST exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
CONST sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
CONST cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
CONST zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
CONST nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

CONST logr10 = 0.43429448190325182765112891891660508229439700580367
CONST logr2 = 1.44269504088896340735992468100189213742664595415299
CONST pi05 = 1.57079632679489661923132169163975144209858469968755
CONST pi2 = 6.28318530717958647692528676655900576839433879875021
CONST q05log10 = 0.21714724095162591382556445945830254114719850290183
CONST q05log2 = 0.72134752044448170367996234050094606871332297707649
CONST q05pi = 0.15915494309189533576888376337251436203445964574046
CONST q13 = 0.33333333333333333333333333333333333333333333333333
CONST q16 = 0.16666666666666666666666666666666666666666666666667
CONST q2pi = 0.63661977236758134307553505349005744813783858296183
CONST q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
CONST rad2deg = 57.2957795130823208767981548141051703324054724665643
CONST sqrt02 = 0.44721359549995793928183473374625524708812367192231
CONST sqrt05 = 0.70710678118654752440084436210484903928483593768847
CONST sqrt075 = 0.86602540378443864676372317075293618347140262690519
CONST y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Vector math library v0.1 (include part)
'# By Zom-B
'####################################################################################################################

TYPE VECTOR
    x AS DOUBLE
    y AS DOUBLE
    z AS DOUBLE
END TYPE

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,


'####################################################################################################################
'# Ray Tracer (Beta version)
'# By Zom-B
'####################################################################################################################

CONST Doantialias = -1
CONST Usegaussian = 0

CONST FLOOR = 1
CONST SPHERE = 2

TYPE TEXTURE
    image AS LONG
    w AS INTEGER
    h AS INTEGER
    scaleU AS SINGLE
    scaleV AS SINGLE
    offsetU AS SINGLE
    offsetV AS SINGLE
    bumpfactor AS SINGLE
END TYPE

DIM SHARED sizeX%, sizeY%
DIM SHARED maxX%, maxY%
DIM SHARED halfX%, halfY%

DIM SHARED texture&(4)

DIM SHARED camPos AS VECTOR
DIM SHARED camDir AS VECTOR
DIM SHARED camUp AS VECTOR
DIM SHARED camRight AS VECTOR

'Speed required with these variables, so not using TYPEs here
DIM SHARED objectType%(7) '                                 Object type
DIM SHARED positionX(7), positionY(7), positionZ(7) '       Object position
DIM SHARED size(7) '                                        Radius (in case of a sphere)
DIM SHARED colorR!(7), colorG!(7), colorB!(7), colorA!(7) ' RGBA color
DIM SHARED specular!(7), highlight!(7) '                    Phong parameters
DIM SHARED reflection!(7) '                                 Ray reflection amount
DIM SHARED textures(7) AS TEXTURE, bumpmap(7) AS TEXTURE '  image handle
DIM SHARED numObjects%

DIM SHARED lightX(4), lightY(4), lightZ(4) '                Light position
DIM SHARED lightR!(4), lightG!(4), lightB!(4) '             Light color
DIM SHARED numLights%

init
main

worldMap:
DATA "!~#!~#!~#!-#(.69AEGFC@5.224;DJMORQND:)(*$!:#'#$!e#+.+1WX\_`ab\MCOZ!/baaQ5&!)#'<;CB=,&!&#$06,8@6/$!%#&&##$8NL"
DATA ":1%!P#-=@@D25CGHIKJYZ]A)=^b`!0b]:!+#$0M?80!.#*-6.!&#%#%#/6?VR=6)!*#'%!B#,DDID?>>/LLPRINQE,!%#$#'F!.bZ0!;#=P="
DATA "-%$'$%)7GV^!)bA/)&6.##-BL/0+!,#/!'#$/80)&!'#$)5NA\]^]W3EQZ,[]baaN>0!&#J_!+bZ2!%#$$!+#$/3-!)#8V*##+R]PUV\!/ba"
DATA "bb8CBN[XRF26/!(#(=*##&B`!'b_YQPYaaVVMTVVX]YJY]YFMaZ_!%b9$##/Q!(b]TJ6$!-#%>V`ba`UJ<),2;<DCSTL[`O]!%ba!:baSTVT"
DATA "[XOOWT06OZ!.b_PNa!+b`WH._a]aOP%#&[!%baP@%##1@CF&!*#Dab\Mba\FFLQ`!*b\_!Gb##*--VS!1baa^ab_`abN0?E.=8GVT'!%#1_bb"
DATA "<!(#8=/##&!%#$9RbbN=Ya^aV\!,baY]`!@b^!%b]G##$#CUab`WXGKQ^!)b__a]!%abA!&#%ObZ3.,!&#-@I!0#&#/aa`b=6TLUQ[a!,b!%a"
DATA "!9ba^]Xa:)RNGF1!*#+AJ>!&#$@Y!+baZbb^=.##%Cbb^][)!4#2T+##9>Q^,3Q`!%b_!EbO*##$$1U\(!+#),3+!*#6Qa_a!&ba_abb`bbU"
DATA "G,Taab``U8!2#/LJK$#-ZO;>T!>babTa!'babbN1'!&#L`=#&!&#')'%&!-#$)L`baa!*b_!%bGa`baabaX-!1#;?KaGJ!@babbabZ\!-bT$"
DATA "!%#;6!&#&#'!4#*FYaa!)b`bQZ!'b[L7,PI%!2#9DZ!Rb[<*!%#'!=#+a!,bYPAU[!&b_@4(2)!2#%N!&b^!'bZMZWbbaW!@b^/5#'&!?#/a"
DATA "!-bYPQVXb_84-!4#)C@PbMEER=[bb`-$(.Sb`(T!*b`!4b\R.(Q;%!@#,a!-baa^`bY9%!6#-!%bA($:2N3aNWJW[KPbbG3!9b]``X)##08!C#"
DATA "N!1ba1!2#$!'#/[aP&*,3.;$B>D!%abbabM-!9b[7?U##)K2!C#)X!0bW&!9#4KJ`bbX!&#+('19!?bU&,Q.HQI$!E#K]!-bD!:#5a!(bQ:$"
DATA "HA/)/M!@b@$%J-$!G#*B^!&b`GJ<8Q/!7#$%(N!+b]!&b`a!&bL`!:bC##%!J#;=_!%bA!J5!7#+Z!2b=!&bW:KV!7bX&#'!L#:0]bb6!&#"
DATA "4BU,!6#I!3bLB!&b]\E(',\!2bU>3%!<#'*!3#Dbb@#-L)79Q4/!4#%a!4b5]!'b])##/V!&b_A?!&b`FL-#%!?#(!3#(H``HYX!%#/)E3,$"
DATA "!/#$##V!4bJ5!&b\2!&#(!%bU(##G!%bV1-##*6!R#';;^ZM8$!(#(!.#*#&_!5b?YbZ=!)#TbP'!%#0<!%bK!%#6;!U#&7\8##$4-$#%!1#"
DATA "a!6bJ3)'&!(#:bC!%#&'.PWbZ!%#)A5!V#5E31[^^QU:!1#2^!5b\[b+!*#ZF!%#$#,A)S-##&+9>!W#(0N!(b>0!0#8]!%bZX!1bJ!)#%#&"
DATA "E&!%#'$G-!    $3Q##$!V#F!*bQ!0#*;/0#&@W!.b[)!)#%%!(#&L?U$%%C_0!?#$!<#1a!+bG!6#J!)b`!%bS*!3#0[_,/Wb_/2*4!1#%!C#"
DATA "(!%#P!-bS4'!3#Q!(baB_bW&!5#=bR0`bK@<'*6F35$#%%!*#$!F#T!0bI+!1#)\!'b^bba-!6#$Da/05-=B%0+<Mb]C$,+!N#A!1bL!2#B!'b"
DATA "Xbba(!8#8EH:!&'$)/,\b\C.#0)!M#X!/ba7!2#3!'b`b^b3!;#&-5-6$(%%&U,?2%#'+!*#%!C#7!/bA!3#8!)bXb?$#;!<#'&U_K#R,##%"
DATA "!&#$!1#$!:#$Ia_!,b/!3#R!+b;)EY!;#1W`bbW4^T!)#.!%#)!,#$!=#1!-b)!3#Qa!(b]3#:bF!;#R!*b.!(#$$##0!I#`!+bJ!4#/a!(b"
DATA "F##@b2#%%!5#,M^!+b`:!?*!L#(!*bJ1$!5#X!(bE##A\!9#L!.bY*!Q#/!)bT!8#K!'bO!&#%!9#J!/bC!Q#=!)b:!8#(_!%ba0!>#/!/b"
DATA "C!Q#@!(bF!:#Hbb^6!@#]bbM=4I!'b^/!Q#R!&b^:!;#*3*$!@#$=0'!&#?[bb`D!)#/&!H#*a!%b]C!g#-NP@)!)#%Q1!G#/_b_K&!j#1:!*#"
DATA "=C##%!E#1^bZ*!k#'1!(#)K>!I#Cbb;!t#8;!J#Wb`3!Q#-!n#G_W##0*!P#$!l#%AO5$!*#'&!~#!H#(!~#!;#$##%!(#%!~#!8#)8;'!W#"
DATA "&!f#+>\O!G#&/EH3&!)#5?@:>[NLA7BD52;ONCDA92/!'#$$!F#$!'#.@>`bM%!5#+,)*+-41-'+8CD1GWa!(b_ZH8BY!9bTNOA8&!B#$6BA"
DATA "30.%#'4E`!%bM!0#.6DX^a!,babb`!,b^_!Cb^W7!0#'/37>DIQZVUPOIB>K!'b`X`!(bL*!,#)IT!@b]`!BbaK2&!%#21!%./7?JHTa!Bb_"
DATA "RG:7?;:GT`!db_;DDC?7!~b!=ba_!Uba!%baa!hbaabaa!%b`^!%bab]a`ba!?b_a!qba\_!~b!Ib"

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

SUB init ()
    WIDTH , 40
    COLOR 11: PRINT
    PRINT TAB(27); "Ray Tracer (Beta version)"
    COLOR 7
    PRINT TAB(36); "By Zom-B"

    scrn& = selectScreenMode&(4, 32)

    makeTextures
    'texture&(1) = _LOADIMAGE("d:\0synced\software\qb64\wTex.png", 32)
    'texture&(2) = _LOADIMAGE("d:\0synced\software\qb64\wBump.png", 32)
    'texture&(3) = _LOADIMAGE("d:\0synced\software\qb64\fTex.png", 32)
    'texture&(4) = _LOADIMAGE("d:\0synced\software\qb64\fBump.png", 32)

    makeScene

    SCREEN scrn&
    _DEST scrn&
    'SCREEN _NEWIMAGE(640, 480, 32)

    sizeX% = _WIDTH
    sizeY% = _HEIGHT
    maxX% = sizeX% - 1
    maxY% = sizeY% - 1
    halfX% = sizeX% \ 2
    halfY% = sizeY% \ 2

    cameraPrepare 150, -250, 200, 0, 0, 66, 0, 0, 1, 60, maxX% / maxY%
    'cameraPrepare 0, 0, 400, 0, 0, 132, 0, -1, 0, 45, maxX% / maxY%
END SUB

'####################################################################################################################

SUB main ()
    'FOR i% = 0 TO 360 STEP 30
    '  x = 100 * COS(i% * _deg2rad)
    '  y = 100 * SIN(i% * _deg2rad)
    '  cameraPrepare x, y, 400, 0, 0, 200, 0, 0, 1, 60, maxX% / maxY%

    renderProgressive 256, 4

    CIRCLE (maxX% \ 2, maxY% \ 2), 3, _RGB32(255, 255, 255), , , 1
    'NEXT
END SUB

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

SUB cameraPrepare (posX, posY, posZ, lookAtX, lookAtY, lookAtZ, upX, upY, upZ, fov, aspect)
    camPos.x = posX
    camPos.y = posY
    camPos.z = posZ

    camDir.x = lookAtX - posX
    camDir.y = lookAtY - posY
    camDir.z = lookAtZ - posZ
    vectorNormalize camDir
    'PRINT camDir.x, camDir.y, camDir.z

    camUp.x = upX
    camUp.y = upY
    camUp.z = upZ
    'vectorNormalize camUp
    'PRINT camUp.x, camUp.y, camUp.z

    'Right vec
    vectorCross camUp, camDir, camRight
    vectorNormalize camRight
    'PRINT camRight.x, camRight.y, camRight.z

    vectorCross camDir, camRight, camUp
    vectorNormalize camUp
    'PRINT camUp.x, camUp.y, camUp.z
    'END

    scaleY = TAN(fov * (_PI / 360)) * 0.75
    scaleX = scaleY * aspect

    vectorScale camRight, scaleX
    vectorScale camUp, scaleY

    'PRINT fov, scaleX, scaleY
    'END
END SUB

'####################################################################################################################

SUB renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    FOR y% = 0 TO maxY% STEP pixStep%
        FOR x% = 0 TO maxX% STEP pixStep%
            tracePoint x%, y%, r!, g!, b!
            LINE (x%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    WHILE pixStep% > 2
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        FOR y% = 0 TO maxY% STEP pixStep%
            y1% = y% + pixSize%
            FOR x% = 0 TO maxX% STEP pixStep%
                x1% = x% + pixSize%

                IF x1% < sizeX% THEN
                    tracePoint x1%, y%, r!, g!, b!
                    LINE (x1%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                END IF
                IF y1% < sizeY% THEN
                    tracePoint x%, y1%, r!, g!, b!
                    LINE (x%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                    IF x1% < sizeX% THEN
                        tracePoint x1%, y1%, r!, g!, b!
                        LINE (x1%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
        pixStep% = pixStep% \ 2
    WEND

    FOR y% = 0 TO maxY%
        y1% = y% + 1
        FOR x% = 0 TO maxX%
            x1% = x% + 1

            IF x1% < sizeX% THEN
                tracePoint x1%, y%, r!, g!, b!
                PSET (x1%, y%), _RGB(r! * 255, g! * 255, b! * 255)
            END IF
            IF y1% < sizeY% THEN
                tracePoint x%, y1%, r!, g!, b!
                PSET (x%, y1%), _RGB(r! * 255, g! * 255, b! * 255)
                IF x1% < sizeX% THEN
                    tracePoint x1%, y1%, r!, g!, b!
                    PSET (x1%, y1%), _RGB(r! * 255, g! * 255, b! * 255)
                END IF
            END IF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    IF NOT Doantialias THEN EXIT SUB

    factor! = 255 / (endSize% * endSize%)

    IF Usegaussian THEN
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                c& = POINT(x%, y%)
                r! = _RED(c&)
                g! = _GREEN(c&)
                b! = _BLUE(c&)
                FOR i% = 2 TO endArea%
                    DO 'Marsaglia polar method for random gaussian
                        u! = RND * 2 - 1
                        v! = RND * 2 - 1
                        s! = u! * u! + v! * v!
                    LOOP WHILE s! >= 1 OR s! = 0
                    s! = SQR(-2 * LOG(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    tracePoint x% + u!, y% + v!, r1!, g1!, b1!

                    r! = r! + r1!
                    g! = g! + g1!
                    b! = b! + b1!
                NEXT

                PSET (x%, y%), _RGB(r! * factor!, g! * factor!, b! * factor!)
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    ELSE
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                r! = 0
                g! = 0
                b! = 0
                FOR v% = 0 TO endSize% - 1
                    y1! = y% + v% / endSize%
                    FOR u% = 0 TO endSize% - 1
                        IF u% = 0 AND v& = 0 THEN
                            c& = POINT(x%, y%)
                        ELSE
                            x1! = x% + u% / endSize%
                            tracePoint x1!, y1!, r1!, g1!, b1!
                        END IF
                        r! = r! + r1!
                        g! = g! + g1!
                        b! = b! + b1!
                    NEXT
                NEXT

                PSET (x%, y%), _RGB(r! * factor!, g! * factor!, b! * factor!)
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    END IF
END SUB

'####################################################################################################################

SUB tracePoint (x!, y!, r!, g!, b!)
    x0! = (x! - halfX%) / halfX%
    y0! = (halfY% - y!) / halfY%

    rayX = camDir.x + x0! * camRight.x + y0! * camUp.x
    rayY = camDir.y + x0! * camRight.y + y0! * camUp.y
    rayZ = camDir.z + x0! * camRight.z + y0! * camUp.z

    'normalize to a vector length of 1
    d = 1 / SQR(rayX * rayX + rayY * rayY + rayZ * rayZ)
    traceRay camPos.x, camPos.y, camPos.z, rayX * d, rayY * d, rayZ * d, 3, -1, r!, g!, b!
END SUB

'####################################################################################################################

SUB traceRay (startX, startY, startZ, rayX, rayY, rayZ, depth%, lastObj%, lightR!, lightG!, lightB!)
    findMinObj startX, startY, startZ, rayX, rayY, rayZ, lastObj%, minobj%, minDepth

    IF minobj% = 0 THEN '                        Infinity
        lightR! = 0
        lightG! = 0
        lightB! = 0
    ELSE '                                       An object was found
        intersectX = startX + rayX * minDepth
        intersectY = startY + rayY * minDepth
        intersectZ = startZ + rayZ * minDepth

        'Calculate normal vector
        SELECT CASE objectType%(minobj%)
            CASE FLOOR:
                normalX = 0
                normalY = 0
                normalZ = 1
            CASE SPHERE:
                normalX = (intersectX - positionX(minobj%)) / size(minobj%)
                normalY = (intersectY - positionY(minobj%)) / size(minobj%)
                normalZ = (intersectZ - positionZ(minobj%)) / size(minobj%)
        END SELECT

        'Calculate UV coordinates
        IF textures(minobj%).image <> -1 OR bumpmap(minobj%).image <> -1 THEN
            SELECT CASE objectType%(minobj%)
                CASE FLOOR:
                    texcoordU! = intersectX
                    texcoordV! = intersectY
                CASE SPHERE:
                    IF normalX = 0 THEN
                        IF normalY <= 0 THEN texcoordU! = 0 ELSE texcoordU! = 0.5
                    ELSE
                        texcoordU! = atan2(normalX, normalY) / pi2 + 0.5
                    END IF

                    texcoordV! = acos(normalZ) / _PI
            END SELECT
        END IF

        'Bumpmapping
        IF bumpmap(minobj%).image <> -1 THEN
            IF minobj% < 3 THEN
                texdirxx = 1
                texdirxy = 0
                texdirxz = 0

                texdiryx = 0
                texdiryy = 1
                texdiryz = 0
            ELSE
                texdirxx = normalY
                texdirxy = -normalX
                texdirxz = 0

                texdiryx = normalZ * normalX
                texdiryy = normalZ * normalY
                texdiryz = -(normalX * normalX + normalY * normalY)
            END IF

            x! = texcoordU! * bumpmap(minobj%).scaleU - bumpmap(minobj%).offsetU
            y! = texcoordV! * bumpmap(minobj%).scaleV - bumpmap(minobj%).offsetV
            x1% = INT(x!)
            y1% = INT(y!)

            dx1! = x! - x1%
            dy1! = y! - y1%
            dx2! = 1 - dx1!
            dy2! = 1 - dy1!
            dx1dy1! = dx1! * dy1!
            dx1dy2! = dx1! * dy2!
            dx2dy1! = dx2! * dy1!
            dx2dy2! = dx2! * dy2!

            x0% = remainder%(x1%, bumpmap(minobj%).w)
            y0% = remainder%(y1%, bumpmap(minobj%).h)
            x1% = remainder%(x1% + 1, bumpmap(minobj%).w)
            y1% = remainder%(y1% + 1, bumpmap(minobj%).h)

            _SOURCE bumpmap(minobj%).image
            c0& = POINT(x0%, y0%)
            c1& = POINT(x1%, y0%)
            c2& = POINT(x0%, y1%)
            c3& = POINT(x1%, y1%)

            sx! = ((_RED(c0&) - 127) * dx2dy2! + (_RED(c1&) - 127) * dx1dy2! + (_RED(c2&) - 127) * dx2dy1! + (_RED(c3&) - 127) * dx1dy1!) * bumpmap(minobj%).bumpfactor / 127
            sy! = ((_GREEN(c0&) - 127) * dx2dy2! + (_GREEN(c1&) - 127) * dx1dy2! + (_GREEN(c2&) - 127) * dx2dy1! + (_GREEN(c3&) - 127) * dx1dy1!) * bumpmap(minobj%).bumpfactor / 127

            normalX = normalX - (texdirxx * sx! + texdiryx * sy)
            normalY = normalY - (texdirxy * sx! + texdiryy * sy)
            normalZ = normalZ - (texdirxz * sx! + texdiryz * sy)

            r = SQR(normalX * normalX + normalY * normalY + normalZ * normalZ)
            normalX = normalX / r
            normalY = normalY / r
            normalZ = normalZ / r
        END IF

        'lighting
        r = 2 * (rayX * normalX + rayY * normalY + rayZ * normalZ)
        rayX = rayX - normalX * r
        rayY = rayY - normalY * r
        rayZ = rayZ - normalZ * r

        diffuseR! = 0
        diffuseG! = 0
        diffuseB! = 0
        specularR! = 0
        specularG! = 0
        specularB! = 0

        FOR a% = numLights% TO 1 STEP -1
            dirX = lightX(a%) - intersectX
            dirY = lightY(a%) - intersectY
            dirZ = lightZ(a%) - intersectZ

            r = 1 / SQR(dirX * dirX + dirY * dirY + dirZ * dirZ)
            dirX = dirX * r
            dirY = dirY * r
            dirZ = dirZ * r

            'Shadows testing
            findShadow intersectX, intersectY, intersectZ, dirX, dirY, dirZ, minobj%, noShadows%

            IF noShadows% THEN
                'Diffuse lighting
                r = normalX * dirX + normalY * dirY + normalZ * dirZ
                IF r > 0 THEN
                    diffuseR! = diffuseR! + colorR!(minobj%) * lightR!(a%) * r
                    diffuseG! = diffuseG! + colorG!(minobj%) * lightG!(a%) * r
                    diffuseB! = diffuseB! + colorB!(minobj%) * lightB!(a%) * r
                END IF

                'Specular lighting
                r = rayX * dirX + rayY * dirY + rayZ * dirZ
                IF r > 0 THEN
                    c! = r ^ (1 / highlight!(minobj%)) * specular!(minobj%)

                    specularR! = specularR! + lightR!(a%) * c!
                    specularG! = specularG! + lightG!(a%) * c!
                    specularB! = specularB! + lightB!(a%) * c!
                END IF
            END IF
        NEXT

        lightR! = diffuseR! + specularR!
        lightG! = diffuseG! + specularG!
        lightB! = diffuseB! + specularB!

        'texturing
        IF textures(minobj%).image <> -1 THEN
            x! = texcoordU! * textures(minobj%).scaleU - textures(minobj%).offsetU
            y! = texcoordV! * textures(minobj%).scaleV - textures(minobj%).offsetV
            x0% = INT(x!)
            y0% = INT(y!)

            dx1! = x! - x0%
            dy1! = y! - y0%
            dx2! = 1 - dx1!
            dy2! = 1 - dy1!
            dx1dy1! = dx1! * dy1!
            dx1dy2! = dx1! * dy2!
            dx2dy1! = dx2! * dy1!
            dx2dy2! = dx2! * dy2!

            x1% = remainder%(x0% + 1, textures(minobj%).w) ' returns positive value only, in contrast to MOD
            y1% = remainder%(y0% + 1, textures(minobj%).h)
            x0% = remainder%(x0%, textures(minobj%).w)
            y0% = remainder%(y0%, textures(minobj%).h)

            _SOURCE textures(minobj%).image
            c0& = POINT(x0%, y0%)
            c1& = POINT(x1%, y0%)
            c2& = POINT(x0%, y1%)
            c3& = POINT(x1%, y1%)

            materialr! = _RED(c0&) * dx2dy2! + _RED(c1&) * dx1dy2! + _RED(c2&) * dx2dy1! + _RED(c3&) * dx1dy1!
            materialg! = _GREEN(c0&) * dx2dy2! + _GREEN(c1&) * dx1dy2! + _GREEN(c2&) * dx2dy1! + _GREEN(c3&) * dx1dy1!
            materialb! = _BLUE(c0&) * dx2dy2! + _BLUE(c1&) * dx1dy2! + _BLUE(c2&) * dx2dy1! + _BLUE(c3&) * dx1dy1!

            lightR! = lightR! * materialr! / 255F
            lightG! = lightG! * materialg! / 255F
            lightB! = lightB! * materialb! / 255F
        END IF

        'Reflection
        IF reflection!(minobj%) > 0 AND depth% > 0 THEN
            traceRay intersectX, intersectY, intersectZ, rayX, rayY, rayZ, depth% - 1, minobj%, reflectR!, reflectG!, reflectB!
            lightR! = lightR! + (reflectR! - lightR!) * reflection!(minobj%)
            lightG! = lightG! + (reflectG! - lightG!) * reflection!(minobj%)
            lightB! = lightB! + (reflectB! - lightB!) * reflection!(minobj%)
        END IF

        ' Global intensity
        r = EXP(-minDepth / 1000.0)

        lightR! = lightR! * r
        lightG! = lightG! * r
        lightB! = lightB! * r
    END IF
END FUNCTION

'####################################################################################################################

SUB findMinObj (startX, startY, startZ, rayX, rayY, rayZ, lastObj%, minObj%, minDepth)
    minObj% = 0
    minDepth = 1E+308
    FOR a% = numObjects% TO 1 STEP -1
        IF a% <> lastObj% THEN
            SELECT CASE objectType%(a%)
                CASE FLOOR:
                    depth = -startZ / rayZ
                CASE SPHERE:
                    posX = positionX(a%) - startX
                    posY = positionY(a%) - startY
                    posZ = positionZ(a%) - startZ

                    r = rayX * posX + rayY * posY + rayZ * posZ
                    d = r * r - posX * posX - posY * posY - posZ * posZ + size(a%) * size(a%)
                    IF d >= 0 THEN depth = r - SQR(d) ELSE depth = -1
            END SELECT

            IF depth >= 0 THEN
                IF minDepth > depth THEN minDepth = depth: minObj% = a%
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB findShadow (startX, startY, startZ, rayX, rayY, rayZ, lastObj%, noShadows%)
    noShadows% = -1
    FOR a% = numObjects% TO 1 STEP -1
        IF a% <> lastObj% THEN
            SELECT CASE objectType%(a%)
                CASE FLOOR:
                    depth = -startZ / rayZ
                CASE SPHERE:
                    posX = positionX(a%) - startX
                    posY = positionY(a%) - startY
                    posZ = positionZ(a%) - startZ

                    r = rayX * posX + rayY * posY + rayZ * posZ
                    d = r * r - posX * posX - posY * posY - posZ * posZ + size(a%) * size(a%)
                    IF d >= 0 THEN depth = r - SQR(d) ELSE depth = -1
            END SELECT

            IF depth >= 0 THEN
                noShadows% = 0
                EXIT SUB
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

SUB makeTextures
    PRINT "Generating textures. Press any key to see them generating."
    VIEW PRINT 2 TO 40
    showing = 0

    world& = _NEWIMAGE(128, 64, 32)
    texture&(1) = _NEWIMAGE(1024, 512, 32)
    texture&(2) = _NEWIMAGE(1024, 512, 32)
    texture&(3) = _NEWIMAGE(512, 512, 32)
    texture&(4) = _NEWIMAGE(512, 512, 32)

    IF showing THEN SCREEN world& ELSE _DEST 0: PRINT: PRINT "(1/5) Decompressing world template (RLE)";

    x% = 0: y% = 0
    FOR a% = 1 TO 25
        _DEST world&
        READ a$
        FOR b! = 1 TO LEN(a$)
            c% = (ASC(MID$(a$, b!, 1)) - 35) * 4
            IF c% < 0 THEN n% = ASC(MID$(a$, b! + 1, 1)) - 34: b! = b! + 2: c% = (ASC(MID$(a$, b!, 1)) - 35) * 4 ELSE n% = 1
            FOR n% = n% TO 1 STEP -1
                PSET (x%, y%), _RGB(c%, c%, c%)
                x% = x% + 1: IF x% = 128 THEN x% = 0: y% = y% + 1
            NEXT
        NEXT
        IF LEN(INKEY$) THEN showing = -1: SCREEN world& ELSE IF NOT showing THEN _DEST 0: PRINT ".";
    NEXT

    IF showing THEN SCREEN texture&(1) ELSE _DEST 0: PRINT: PRINT "(2/5) World bump map";

    FOR y% = 0 TO 511
        _SOURCE world&
        _DEST texture&(1)
        FOR x% = 0 TO 1023
            getWorldBump x% / 3000, y% / 2000, a!
            a! = (a! - 0.387) / 0.502: a! = a! * a!
            getWorldPixel x% / 8 - 0.5, y% / 8 - 0.50, c!
            c! = c! / 255: IF c! > 1 THEN c! = 1

            r! = 11 + (24 + 231 * a! - 11) * c!
            g! = 10 + (49 + 198 * a! - 10) * c!
            b! = 50 + (8 + 181 * a! - 50) * c!

            PSET (x%, y%), _RGB32(r!, g!, b!)
        NEXT
        IF LEN(INKEY$) THEN showing = -1: SCREEN texture&(1) ELSE IF NOT showing THEN _DEST 0: PRINT ".";
    NEXT

    IF showing THEN SCREEN texture&(2) ELSE _DEST 0: PRINT: PRINT "(3/5) World bump map";

    FOR y% = 0 TO 511
        _SOURCE world&
        _DEST texture&(2)
        FOR x% = 0 TO 1023
            getWorldPixel x% / 8 - 0.46, y% / 8 - 0.50, c0!: getWorldBump x% / 300 + 0.001, y% / 300, a0!: a0! = a0! * c0!
            getWorldPixel x% / 8 - 0.54, y% / 8 - 0.50, c1!: getWorldBump x% / 300 - 0.001, y% / 300, a1!: a1! = a1! * c1!
            getWorldPixel x% / 8 - 0.50, y% / 8 - 0.46, c2!: getWorldBump x% / 300, y% / 300 + 0.001, a2!: a2! = a2! * c2!
            getWorldPixel x% / 8 - 0.50, y% / 8 - 0.54, c3!: getWorldBump x% / 300, y% / 300 - 0.001, a3!: a3! = a3! * c3!

            r! = (a1! - a0!) * 7
            g! = (a2! - a3!) * 7
            PSET (x%, y%), _RGB32(r! + 127, g! + 127, 127)
        NEXT
        IF LEN(INKEY$) THEN showing = -1: SCREEN texture&(2) ELSE IF NOT showing THEN _DEST 0: PRINT ".";
    NEXT

    IF showing THEN SCREEN texture&(3) ELSE _DEST 0: PRINT: PRINT "(4/5) Floor texture";

    FOR y% = 0 TO 511
        _DEST texture&(3)
        FOR x% = 0 TO 511
            getFloorTexture x% / 256, y% / 256, r!, g!, b!
            PSET (x%, y%), _RGB32(r! * 255, g! * 255, b! * 255)
        NEXT
        IF LEN(INKEY$) THEN showing = -1: SCREEN texture&(2) ELSE IF NOT showing THEN _DEST 0: PRINT ".";
    NEXT

    IF showing THEN SCREEN texture&(4) ELSE _DEST 0: PRINT: PRINT "(5/5) Floor bump map";

    FOR y% = 0 TO 511
        _DEST texture&(4)
        FOR x% = 0 TO 511
            getFloorBump x% / 256 - 0.002, y% / 256, a0!
            getFloorBump x% / 256 + 0.002, y% / 256, a1!
            getFloorBump x% / 256, y% / 256 + 0.002, a2!
            getFloorBump x% / 256, y% / 256 - 0.002, a3!

            r! = (a1! - a0!) * 1400
            g! = (a2! - a3!) * 1400

            PSET (x%, y%), _RGB32(r! + 127, g! + 127, 127)
        NEXT
        IF LEN(INKEY$) THEN showing = -1: SCREEN texture&(4) ELSE IF NOT showing THEN _DEST 0: PRINT ".";
    NEXT
END SUB

'####################################################################################################################

SUB getWorldPixel (x!, y!, c0!)
    x% = INT(x!) AND &H7F
    y% = INT(y!) AND &H3F
    dx! = x! - x%: IF dx! < 0 THEN dx! = dx! + 128
    dy! = y! - y%


    c0! = POINT(x%, y%) AND &HFF
    c1! = POINT((x% + 1) AND &H7F, y%) AND &HFF
    c2! = POINT(x%, y% + 1) AND &HFF
    c3! = POINT((x% + 1) AND &H7F, y% + 1) AND &HFF

    c0! = c0! + (c1! - c0!) * dx!
    c2! = c2! + (c3! - c2!) * dx!
    c0! = c0! + (c2! - c0!) * dy!

    c0! = c0! - 72: IF c0! < 0 THEN c0! = 0
END SUB


SUB getWorldBump (u!, v!, a!)
    l! = 0
    fbm u!, v!, 1, l!
    a! = 0.3 * l! + 0.2
END SUB


SUB getFloorTexture (u!, v!, r!, g!, b!)
    v1% = v! - INT(v!) < 0.5: u1% = u! - INT(u!) < 0.5

    IF u1% = v1% THEN
        l! = 0
        fbm u!, v!, 3, l!
        l! = l! * 0.7
        fbm u!, v!, 2, l!
        r! = 0.054 * l! + 0.61
        g! = 0.054 * l! + 0.42
        b! = 0.054 * l! + 0.25
    ELSE
        l! = 0
        fbm u!, v!, 1, l!
        l! = l! * 0.6
        fbm u!, v!, 0, l!
        r! = 0.10 * l! + 0.05
        g! = 0.08 * l! - 0.04
        b! = 0.07 * l! - 0.06
    END IF
END SUB


SUB getFloorBump (u!, v!, a!)
    v1% = v! - INT(v!) < 0.5: u1% = u! - INT(u!) < 0.5
    v2! = v! * 2 - INT(v! * 2): v2! = 1 - v2! * (1 - v2!) * 4: v2! = v2! * v2!: v2! = 1 - v2! * v2!
    u2! = u! * 2 - INT(u! * 2): u2! = 1 - u2! * (1 - u2!) * 4: u2! = u2! * u2!: u2! = 1 - u2! * u2!

    IF u1% = v1% THEN
        l! = 0
        fbm u!, v!, 3, l!
        l! = l! * 0.7
        fbm u!, v!, 2, l!
        a! = 0.02 * l! + 0.7
    ELSE
        l! = 0
        fbm u!, v!, 1, l!
        l! = l! * 0.6
        fbm u!, v!, 0, l!
        a! = 0.05 * l! + 0.6
    END IF

    a! = a! * u2! * v2!

    'a! = a! + (u2! * v2! - 1) ' * 0.88
    'IF a! < 0.06 THEN a = RND * 0.02
END SUB

'####################################################################################################################

SUB fbm (x!, y!, a%, o!)
    SELECT CASE a%
        CASE 0:
            zx! = x! * 40 - y! * 2
            zy! = y!
            i% = -5
        CASE 1:
            zx! = x! * 50
            zy! = y! * 50
            i% = -2
        CASE 2:
            zx! = x! * 80
            zy! = y! * 80
            i% = -2
        CASE 3:
            zx! = x! * 30 + y! * 0.5
            zy! = y! * 2
            i% = -2
    END SELECT

    scale! = 1
    FOR i% = i% TO 0
        zcx! = zx!: zx! = zcx! * 0.6 - zy! * 0.8: zy! = zcx! * 0.8 + zy! * 0.6
        zcx! = CINT(zx! / scale!) * scale!: zcy! = CINT(zy! / scale!) * scale!

        rx1! = zcx! + 0.5 * scale! + 14: ry1! = zcy! + 0.5 * scale!: r! = 123094 / (rx1! * rx1! + ry1! * ry1!)
        rx1! = rx1! * r!: ry1! = ry1! * r!: rx1! = rx1! - INT(rx1!): ry1! = ry1! - INT(ry1!)
        rx2! = zcx! - 0.5 * scale! + 14: ry2! = zcy! + 0.5 * scale!: r! = 123094 / (rx2! * rx2! + ry2! * ry2!)
        rx2! = rx2! * r!: ry2! = ry2! * r!: rx2! = rx2! - INT(rx2!): ry2! = ry2! - INT(ry2!)
        rx3! = zcx! + 0.5 * scale! + 14: ry3! = zcy! - 0.5 * scale!: r! = 123094 / (rx3! * rx3! + ry3! * ry3!)
        rx3! = rx3! * r!: ry3! = ry3! * r!: rx3! = rx3! - INT(rx3!): ry3! = ry3! - INT(ry3!)
        rx4! = zcx! - 0.5 * scale! + 14: ry4! = zcy! - 0.5 * scale!: r! = 123094 / (rx4! * rx4! + ry4! * ry4!)
        rx4! = rx4! * r!: ry4! = ry4! * r!: rx4! = rx4! - INT(rx4!): ry4! = ry4! - INT(ry4!)
        x0! = (zx! - zcx!) / scale! + 0.5: x0! = (3 - 2 * x0!) * x0! * x0!: x1! = 1 - x0!
        y0! = (zy! - zcy!) / scale! + 0.5: y0! = (3 - 2 * y0!) * y0! * y0!: y1! = 1 - y0!
        pixcompx! = rx1! * x0! * y0! + rx3! * x0! * y1! + rx2! * x1! * y0! + rx4! * x1! * y1!
        pixcompy! = ry1! * x0! * y0! + ry3! * x0! * y1! + ry2! * x1! * y0! + ry4! * x1! * y1!
        o! = o! + SQR(pixcompx! * pixcompx! + pixcompy! * pixcompy!) * scale! * scale!: scale! = scale! * 0.8
    NEXT
END FUNCTION

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

SUB makeScene
    objectType%(1) = FLOOR
    colorR!(1) = 1
    colorG!(1) = 1
    colorB!(1) = 1
    colorA!(1) = 1
    specular!(1) = 2
    highlight!(1) = 0.002
    reflection!(1) = 0.5
    texturePrepare textures(1), texture&(3), .005, .005, 0, 0, 0
    texturePrepare bumpmap(1), texture&(4), .005, .005, 0, 0, 1

    objectType%(2) = SPHERE
    positionX(2) = 0
    positionY(2) = 57.735
    positionZ(2) = 50
    size(2) = 50
    colorR!(2) = 1
    colorG!(2) = 0
    colorB!(2) = 0
    colorA!(2) = 1
    specular!(2) = 1
    highlight!(2) = 0.1
    reflection!(2) = 0.1
    texturePrepare textures(2), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(2), -1, 1, 1, 0, 0, 1

    objectType%(3) = SPHERE
    positionX(3) = -50
    positionY(3) = -28.8675
    positionZ(3) = 50
    size(3) = 50
    colorR!(3) = 0
    colorG!(3) = 0
    colorB!(3) = 1
    colorA!(3) = 1
    specular!(3) = 1
    highlight!(3) = 0.04
    reflection!(3) = 0.4
    texturePrepare textures(3), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(3), -1, 1, 1, 0, 0, 1

    objectType%(4) = SPHERE
    positionX(4) = 50
    positionY(4) = -28.8675
    positionZ(4) = 50
    size(4) = 50
    colorR!(4) = 0
    colorG!(4) = 1
    colorB!(4) = 0
    colorA!(4) = 1
    specular!(4) = 10
    highlight!(4) = 0.01
    reflection!(4) = 0.2
    texturePrepare textures(4), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(4), -1, 1, 1, 0, 0, 1

    objectType%(5) = SPHERE
    positionX(5) = 0
    positionY(5) = 0
    positionZ(5) = 132
    size(5) = 50
    colorR!(5) = 1
    colorG!(5) = 1
    colorB!(5) = 1
    colorA!(5) = 1
    specular!(5) = 5
    highlight!(5) = 0.002
    reflection!(5) = 0.15
    texturePrepare textures(5), texture&(1), 1, 1, 0.35, 0, 0
    texturePrepare bumpmap(5), texture&(2), 1, 1, 0.35, 0, 1

    numObjects% = 5

    lightX(1) = 460
    lightY(1) = -460
    lightZ(1) = 460
    lightR!(1) = 1
    lightG!(1) = 0.25
    lightB!(1) = 0.25

    lightX(2) = -640
    lightY(2) = -180
    lightZ(2) = 460
    lightR!(2) = 0.25
    lightG!(2) = 1
    lightB!(2) = 0.25

    lightX(3) = 80
    lightY(3) = 260
    lightZ(3) = 760
    lightR!(3) = 0.25
    lightG!(3) = 0.25
    lightB!(3) = 1

    lightX(4) = 0
    lightY(4) = 0
    lightZ(4) = 400
    lightR!(4) = 1
    lightG!(4) = 1
    lightB!(4) = 1

    numLights% = 4
END SUB

'####################################################################################################################

SUB texturePrepare (tex AS TEXTURE, handle&, sU!, sV!, oU!, oV!, bumpfactor!)
    tex.image = handle&
    IF handle& <> -1 THEN
        tex.w = _WIDTH(tex.image)
        tex.h = _HEIGHT(tex.image)
        tex.scaleU = sU! * tex.w
        tex.scaleV = sV! * tex.h
        tex.offsetU = oU! * tex.w
        tex.offsetV = oV! * tex.h
        tex.bumpfactor = bumpfactor!
    END IF
END SUB

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

FUNCTION remainder% (a%, b%)
    remainder% = a% - INT(a% / b%) * b%
END FUNCTION

'> merger: Skipping unused FUNCTION fRemainder (a, b)

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

'> merger: Skipping unused FUNCTION asin (y)

FUNCTION acos (y)
    IF y <= -0.99999999999999# THEN acos = _PI: EXIT FUNCTION
    IF y >= 0.99999999999999# THEN acos = 0: EXIT FUNCTION
    acos = pi05 - ATN(y / SQR(1 - y * y))
END FUNCTION

'> merger: Skipping unused FUNCTION safeAcos (y)

FUNCTION atan2 (y, x)
    IF x > 0 THEN
        atan2 = ATN(y / x)
    ELSEIF x < 0 THEN
        IF y > 0 THEN
            atan2 = ATN(y / x) + _PI
        ELSE
            atan2 = ATN(y / x) - _PI
        END IF
    ELSEIF y > 0 THEN
        atan2 = _PI / 2
    ELSE
        atan2 = -_PI / 2
    END IF
END FUNCTION

'####################################################################################################################
'# Vector math library v0.1 (module part)
'# By Zom-B
'####################################################################################################################

SUB vectorScale (a AS VECTOR, scale)
    a.x = a.x * scale
    a.y = a.y * scale
    a.z = a.z * scale
END SUB

SUB vectorNormalize (a AS VECTOR)
    r = 1 / SQR(a.x * a.x + a.y * a.y + a.z * a.z)
    a.x = a.x * r
    a.y = a.y * r
    a.z = a.z * r
END SUB

'####################################################################################################################

SUB vectorCross (a AS VECTOR, b AS VECTOR, o AS VECTOR)
    o.x = a.y * b.z - a.z * b.y
    o.y = a.z * b.x - a.x * b.z
    o.z = a.x * b.y - a.y * b.x
END SUB

'####################################################################################################################
'# Screen mode selector v1.1 (routines)
'# By Zom-B
'####################################################################################################################

FUNCTION selectScreenMode& (yOffset%, colors%)
    DIM aspectName$(0 TO 9), aspectCol%(0 TO 9)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(1 TO 100), vidY%(1 TO 100), vidA%(1 TO 100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF (vidX%(y%) <= 0) THEN numModes% = y% - 1: EXIT FOR
    NEXT

    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    DEF SEG = &HB800
    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click "
    POKE yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    DO
        IF INKEY$ = CHR$(27) THEN CLS: SYSTEM
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1
                COLOR 7, 0
                PRINT USING "##:"; x%;
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
            PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF
        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN EXIT DO
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = 1
                    END IF
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    selectScreenMode& = _NEWIMAGE(vidX%(y%), vidY%(y%), colors%)

    COLOR 7
    CLS
END FUNCTION


