'$EXEICON:'sanctum.ico'
'REM $include:'Color32.BI'

CONST Aquamarine = _RGB32(127, 255, 212)
CONST Blue = _RGB32(0, 0, 255)
CONST BlueViolet = _RGB32(138, 43, 226)
CONST Chocolate = _RGB32(210, 105, 30)
CONST Cyan = _RGB32(0, 255, 255)
CONST DarkBlue = _RGB32(0, 0, 139)
CONST DarkGoldenRod = _RGB32(184, 134, 11)
CONST DarkGray = _RGB32(169, 169, 169)
CONST DarkKhaki = _RGB32(189, 183, 107)
CONST DeepPink = _RGB32(255, 20, 147)
CONST DodgerBlue = _RGB32(30, 144, 255)
CONST ForestGreen = _RGB32(34, 139, 34)
CONST Gray = _RGB32(128, 128, 128)
CONST Green = _RGB32(0, 128, 0)
CONST Indigo = _RGB32(75, 0, 130)
CONST Ivory = _RGB32(255, 255, 240)
CONST LightSeaGreen = _RGB32(32, 178, 170)
CONST Lime = _RGB32(0, 255, 0)
CONST LimeGreen = _RGB32(50, 205, 50)
CONST Magenta = _RGB32(255, 0, 255)
CONST PaleGoldenRod = _RGB32(238, 232, 170)
CONST Purple = _RGB32(128, 0, 128)
CONST Red = _RGB32(255, 0, 0)
CONST RoyalBlue = _RGB32(65, 105, 225)
CONST SaddleBrown = _RGB32(139, 69, 19)
CONST Sienna = _RGB32(160, 82, 45)
CONST SlateGray = _RGB32(112, 128, 144)
CONST Snow = _RGB32(255, 250, 250)
CONST Sunglow = _RGB32(255, 207, 72)
CONST SunsetOrange = _RGB32(253, 94, 83)
CONST Teal = _RGB32(0, 128, 128)
CONST White = _RGB32(255, 255, 255)
CONST Yellow = _RGB32(255, 255, 0)

' Constants.
pi = 3.1415926536
ee = 2.7182818285

' Scale.
DIM bignumber AS LONG
bignumber = 3000000

' Video.
'SCREEN _NEWIMAGE(640, 480, 32)
SCREEN _NEWIMAGE(800, 600, 32)
'SCREEN _NEWIMAGE(1024, 768, 32)
_FULLSCREEN
_MOUSEHIDE
screenwidth = _WIDTH
screenheight = _HEIGHT

' Camera orientation vectors.
DIM uhat(3), vhat(3), nhat(3)

' Basis vectors defined in three-space.
DIM xhat(3), yhat(3), zhat(3)
xhat(1) = 1: xhat(2) = 0: xhat(3) = 0
yhat(1) = 0: yhat(2) = 1: yhat(3) = 0
zhat(1) = 0: zhat(2) = 0: zhat(3) = 1

' Group structure.
TYPE VectorGroupElement
    Identity AS LONG
    Pointer AS LONG
    Lagger AS LONG
    FirstVector AS LONG
    LastVector AS LONG
    GroupName AS STRING * 50
    Visible AS INTEGER
    ForceAnimate AS INTEGER
    COMFixed AS INTEGER
    COMx AS SINGLE ' Center of mass
    COMy AS SINGLE
    COMz AS SINGLE
    ROTx AS SINGLE ' Center of rotation
    ROTy AS SINGLE
    ROTz AS SINGLE
    REVx AS SINGLE ' Revolution speed
    REVy AS SINGLE
    REVz AS SINGLE
    DIMx AS SINGLE ' Maximum volume
    DIMy AS SINGLE
    DIMz AS SINGLE
END TYPE
DIM VectorGroup(bignumber) AS VectorGroupElement

' World vectors.
DIM vec(bignumber, 3) ' Relative Position
DIM vec3Dpos(bignumber, 3) ' Position
DIM vec3Dvel(bignumber, 3) ' Linear velocity
DIM vec3Dacc(bignumber, 3) ' Linear acceleration
DIM vec3Danv(bignumber, 3) ' Angular velocity
DIM vec3Dvis(bignumber) ' Visible toggle
DIM vec2D(bignumber, 2) ' Projection onto 2D plane
DIM vec3Dcolor(bignumber) AS LONG ' Original color
DIM vec2Dcolor(bignumber) AS LONG ' Projected color

' Clipping planes.
DIM nearplane(4), farplane(4), rightplane(4), leftplane(4), topplane(4), bottomplane(4)

' State.
RANDOMIZE TIMER
nearplane(4) = 1
farplane(4) = -100
rightplane(4) = 0 '*' fovd * (nhat(1) * rightplane(1) + nhat(2) * rightplane(2) + nhat(3) * rightplane(3))
leftplane(4) = 0
topplane(4) = 0
bottomplane(4) = 0
midscreenx = screenwidth / 2
midscreeny = screenheight / 2
fovd = -256
numgroupvisible = 0
numvectorvisible = 0
groupidticker = 0
vecgroupid = 0
vectorindex = 0
rotspeed = 1 / 33
linspeed = 3 / 2
timestep = .001
camx = -40
camy = 30
camz = 40
uhat(1) = -.2078192: uhat(2) = -.9781672: uhat(3) = 0
vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
toggletimeanimate = 1
toggleinvertmouse = -1
togglehud = 1

' Prime main loop.
GOSUB initialize.objects
GOSUB redraw

' Begin main loop.
fpstimer = INT(TIMER)
fps = 0
DO
    GOSUB redraw
    GOSUB mouseprocess
    GOSUB keyprocess

    fps = fps + 1
    tt = INT(TIMER)
    IF tt = fpstimer + 1 THEN
        fpstimer = tt
        fpsreport = fps
        fps = 0
    END IF

    _DISPLAY
    _KEYCLEAR
    _LIMIT 30
LOOP

SYSTEM

' Gosubs.

redraw:
GOSUB normalize.screen.vectors
GOSUB calculate.clippingplanes
GOSUB compute.visible.groups
GOSUB plot.visible.vectors
RETURN

mouseprocess:
'mx = 0
'my = 0
'DO WHILE _MOUSEINPUT
'    mx = mx + _MOUSEMOVEMENTX
'    my = my + _MOUSEMOVEMENTY
'    IF _MOUSEWHEEL > 0 THEN GOSUB rotate.clockwise
'    IF _MOUSEWHEEL < 0 THEN GOSUB rotate.counterclockwise
'    IF mx > 0 THEN
'        GOSUB rotate.uhat.plus: GOSUB normalize.screen.vectors
'    END IF
'    IF mx < 0 THEN
'        GOSUB rotate.uhat.minus: GOSUB normalize.screen.vectors
'    END IF
'    IF my > 0 THEN
'        IF toggleinvertmouse = -1 THEN
'            GOSUB rotate.vhat.plus: GOSUB normalize.screen.vectors
'        ELSE
'            GOSUB rotate.vhat.minus: GOSUB normalize.screen.vectors
'        END IF
'    END IF
'    IF my < 0 THEN
'        IF toggleinvertmouse = -1 THEN
'            GOSUB rotate.vhat.minus: GOSUB normalize.screen.vectors
'        ELSE
'            GOSUB rotate.vhat.plus: GOSUB normalize.screen.vectors
'        END IF
'    END IF
'    mx = 0
'    my = 0
'LOOP
RETURN

keyprocess:
IF _KEYDOWN(119) = -1 OR _KEYDOWN(18432) = -1 THEN GOSUB strafe.camera.nhat.minus ' w or uparrow
IF _KEYDOWN(115) = -1 OR _KEYDOWN(20480) = -1 THEN GOSUB strafe.camera.nhat.plus ' s or downarrow
IF _KEYDOWN(97) = -1 THEN GOSUB strafe.camera.uhat.minus ' a
IF _KEYDOWN(100) = -1 THEN GOSUB strafe.camera.uhat.plus ' d
IF _KEYDOWN(56) = -1 THEN GOSUB rotate.vhat.plus: GOSUB normalize.screen.vectors ' 8
IF _KEYDOWN(50) = -1 THEN GOSUB rotate.vhat.minus: GOSUB normalize.screen.vectors ' 2
IF _KEYDOWN(19200) = -1 OR _KEYDOWN(52) = -1 THEN GOSUB rotate.uhat.minus: GOSUB normalize.screen.vectors ' 4
IF _KEYDOWN(19712) = -1 OR _KEYDOWN(54) = -1 THEN GOSUB rotate.uhat.plus: GOSUB normalize.screen.vectors ' 6
IF _KEYDOWN(55) = -1 THEN GOSUB rotate.clockwise ' 7
IF _KEYDOWN(57) = -1 THEN GOSUB rotate.counterclockwise ' 9
IF _KEYDOWN(49) = -1 THEN GOSUB rotate.uhat.minus: GOSUB normalize.screen.vectors: GOSUB rotate.clockwise ' 1
IF _KEYDOWN(51) = -1 THEN GOSUB rotate.uhat.plus: GOSUB normalize.screen.vectors: GOSUB rotate.counterclockwise ' 3
IF _KEYDOWN(113) = -1 THEN GOSUB strafe.camera.vhat.minus ' q
IF _KEYDOWN(101) = -1 THEN GOSUB strafe.camera.vhat.plus ' e

key$ = INKEY$
IF (key$ <> "") THEN
    SELECT CASE key$
        CASE "x"
            uhat(1) = 0: uhat(2) = 1: uhat(3) = 0
            vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
        CASE "X"
            uhat(1) = 0: uhat(2) = -1: uhat(3) = 0
            vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
        CASE "y"
            uhat(1) = -1: uhat(2) = 0: uhat(3) = 0
            vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
        CASE "Y"
            uhat(1) = 1: uhat(2) = 0: uhat(3) = 0
            vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
        CASE "z"
            uhat(1) = 1: uhat(2) = 0: uhat(3) = 0
            vhat(1) = 0: vhat(2) = 1: vhat(3) = 0
            GOSUB normalize.screen.vectors
        CASE "Z"
            uhat(1) = 0: uhat(2) = 1: uhat(3) = 0
            vhat(1) = 1: vhat(2) = 0: vhat(3) = 0
        CASE "]"
            farplane(4) = farplane(4) - 1
        CASE "["
            farplane(4) = farplane(4) + 1
        CASE " "
            togglehud = -togglehud
        CASE "t"
            toggletimeanimate = -toggletimeanimate
        CASE "i"
            toggleinvertmouse = -toggleinvertmouse
        CASE "v"
            OPEN "snapshot-camera.txt" FOR OUTPUT AS #1
            PRINT #1, camx, camy, camz
            PRINT #1, uhat(1), uhat(2), uhat(3)
            PRINT #1, vhat(1), vhat(2), vhat(3)
            CLOSE #1
        CASE CHR$(27)
            SYSTEM
        CASE "n"
            VectorGroup(closestgroup).COMFixed = 1
            FOR vectorindex = VectorGroup(closestgroup).FirstVector TO VectorGroup(closestgroup).LastVector
                vec3Dvel(vectorindex, 1) = (RND - .5) * 200
                vec3Dvel(vectorindex, 2) = (RND - .5) * 200
                vec3Dvel(vectorindex, 3) = (RND - .5) * 200
            NEXT
        CASE "k"
            p = VectorGroup(closestgroup).Pointer
            l = VectorGroup(closestgroup).Lagger
            VectorGroup(l).Pointer = p
            IF (p <> -999) THEN
                VectorGroup(p).Lagger = l
            END IF
        CASE "b"
            tilesize = 5
            ' Determine last object id.
            p = 1
            DO
                k = VectorGroup(p).Identity
                p = VectorGroup(k).Pointer
                IF (p = -999) THEN EXIT DO
            LOOP
            lastobjectid = k
            vectorindex = VectorGroup(lastobjectid).LastVector
            ' Create new group.
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = -999
            VectorGroup(vecgroupid).Lagger = lastobjectid
            VectorGroup(vecgroupid).GroupName = "Block"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = tilesize / 2
            VectorGroup(vecgroupid).DIMy = tilesize / 2
            VectorGroup(vecgroupid).DIMz = tilesize / 2
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR r = 1 TO 400
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = camx + -20 * nhat(1) + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 2) = camy + -20 * nhat(2) + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 3) = camz + -20 * nhat(3) + (RND - .5) * tilesize
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = Lime
                ELSE
                    vec3Dcolor(vectorindex) = Purple
                END IF
                GOSUB integratecom
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
            VectorGroup(lastobjectid).Pointer = vecgroupid
    END SELECT
END IF
RETURN

convert:
' Convert graphics from uv-cartesian coordinates to monitor coordinates.
x0 = x: y0 = y
x = x0 + midscreenx
y = -y0 + midscreeny
RETURN

rotate.uhat.plus:
uhat(1) = uhat(1) + nhat(1) * rotspeed
uhat(2) = uhat(2) + nhat(2) * rotspeed
uhat(3) = uhat(3) + nhat(3) * rotspeed
RETURN

rotate.uhat.minus:
uhat(1) = uhat(1) - nhat(1) * rotspeed
uhat(2) = uhat(2) - nhat(2) * rotspeed
uhat(3) = uhat(3) - nhat(3) * rotspeed
RETURN

rotate.vhat.plus:
vhat(1) = vhat(1) + nhat(1) * rotspeed
vhat(2) = vhat(2) + nhat(2) * rotspeed
vhat(3) = vhat(3) + nhat(3) * rotspeed
RETURN

rotate.vhat.minus:
vhat(1) = vhat(1) - nhat(1) * rotspeed
vhat(2) = vhat(2) - nhat(2) * rotspeed
vhat(3) = vhat(3) - nhat(3) * rotspeed
RETURN

rotate.counterclockwise:
v1 = vhat(1)
v2 = vhat(2)
v3 = vhat(3)
vhat(1) = vhat(1) + uhat(1) * rotspeed
vhat(2) = vhat(2) + uhat(2) * rotspeed
vhat(3) = vhat(3) + uhat(3) * rotspeed
uhat(1) = uhat(1) - v1 * rotspeed
uhat(2) = uhat(2) - v2 * rotspeed
uhat(3) = uhat(3) - v3 * rotspeed
RETURN

rotate.clockwise:
v1 = vhat(1)
v2 = vhat(2)
v3 = vhat(3)
vhat(1) = vhat(1) - uhat(1) * rotspeed
vhat(2) = vhat(2) - uhat(2) * rotspeed
vhat(3) = vhat(3) - uhat(3) * rotspeed
uhat(1) = uhat(1) + v1 * rotspeed
uhat(2) = uhat(2) + v2 * rotspeed
uhat(3) = uhat(3) + v3 * rotspeed
RETURN

strafe.camera.uhat.plus:
camx = camx + uhat(1) * linspeed
camy = camy + uhat(2) * linspeed
camz = camz + uhat(3) * linspeed
RETURN

strafe.camera.uhat.minus:
camx = camx - uhat(1) * linspeed
camy = camy - uhat(2) * linspeed
camz = camz - uhat(3) * linspeed
RETURN

strafe.camera.vhat.plus:
camx = camx + vhat(1) * linspeed
camy = camy + vhat(2) * linspeed
camz = camz + vhat(3) * linspeed
RETURN

strafe.camera.vhat.minus:
camx = camx - vhat(1) * linspeed
camy = camy - vhat(2) * linspeed
camz = camz - vhat(3) * linspeed
RETURN

strafe.camera.nhat.plus:
camx = camx + nhat(1) * linspeed
camy = camy + nhat(2) * linspeed
camz = camz + nhat(3) * linspeed
RETURN

strafe.camera.nhat.minus:
camx = camx - nhat(1) * linspeed
camy = camy - nhat(2) * linspeed
camz = camz - nhat(3) * linspeed
RETURN

normalize.screen.vectors:
uhatmag = SQR(uhat(1) * uhat(1) + uhat(2) * uhat(2) + uhat(3) * uhat(3))
uhat(1) = uhat(1) / uhatmag: uhat(2) = uhat(2) / uhatmag: uhat(3) = uhat(3) / uhatmag
vhatmag = SQR(vhat(1) * vhat(1) + vhat(2) * vhat(2) + vhat(3) * vhat(3))
vhat(1) = vhat(1) / vhatmag: vhat(2) = vhat(2) / vhatmag: vhat(3) = vhat(3) / vhatmag
uhatdotvhat = uhat(1) * vhat(1) + uhat(2) * vhat(2) + uhat(3) * vhat(3)
' The normal vector points toward the eye.
nhat(1) = uhat(2) * vhat(3) - uhat(3) * vhat(2)
nhat(2) = uhat(3) * vhat(1) - uhat(1) * vhat(3)
nhat(3) = uhat(1) * vhat(2) - uhat(2) * vhat(1)
nhatmag = SQR(nhat(1) * nhat(1) + nhat(2) * nhat(2) + nhat(3) * nhat(3))
nhat(1) = nhat(1) / nhatmag: nhat(2) = nhat(2) / nhatmag: nhat(3) = nhat(3) / nhatmag
RETURN

calculate.clippingplanes:
' Calculate normal vectors to all clipping planes.
h2 = screenheight / 2
w2 = screenwidth / 2
nearplane(1) = -nhat(1)
nearplane(2) = -nhat(2)
nearplane(3) = -nhat(3)
farplane(1) = nhat(1)
farplane(2) = nhat(2)
farplane(3) = nhat(3)
rightplane(1) = h2 * fovd * uhat(1) - h2 * w2 * nhat(1)
rightplane(2) = h2 * fovd * uhat(2) - h2 * w2 * nhat(2)
rightplane(3) = h2 * fovd * uhat(3) - h2 * w2 * nhat(3)
mag = SQR(rightplane(1) * rightplane(1) + rightplane(2) * rightplane(2) + rightplane(3) * rightplane(3))
rightplane(1) = rightplane(1) / mag
rightplane(2) = rightplane(2) / mag
rightplane(3) = rightplane(3) / mag
leftplane(1) = -h2 * fovd * uhat(1) - h2 * w2 * nhat(1)
leftplane(2) = -h2 * fovd * uhat(2) - h2 * w2 * nhat(2)
leftplane(3) = -h2 * fovd * uhat(3) - h2 * w2 * nhat(3)
mag = SQR(leftplane(1) * leftplane(1) + leftplane(2) * leftplane(2) + leftplane(3) * leftplane(3))
leftplane(1) = leftplane(1) / mag
leftplane(2) = leftplane(2) / mag
leftplane(3) = leftplane(3) / mag
topplane(1) = w2 * fovd * vhat(1) - h2 * w2 * nhat(1)
topplane(2) = w2 * fovd * vhat(2) - h2 * w2 * nhat(2)
topplane(3) = w2 * fovd * vhat(3) - h2 * w2 * nhat(3)
mag = SQR(topplane(1) * topplane(1) + topplane(2) * topplane(2) + topplane(3) * topplane(3))
topplane(1) = topplane(1) / mag
topplane(2) = topplane(2) / mag
topplane(3) = topplane(3) / mag
bottomplane(1) = -w2 * fovd * vhat(1) - h2 * w2 * nhat(1)
bottomplane(2) = -w2 * fovd * vhat(2) - h2 * w2 * nhat(2)
bottomplane(3) = -w2 * fovd * vhat(3) - h2 * w2 * nhat(3)
mag = SQR(bottomplane(1) * bottomplane(1) + bottomplane(2) * bottomplane(2) + bottomplane(3) * bottomplane(3))
bottomplane(1) = bottomplane(1) / mag
bottomplane(2) = bottomplane(2) / mag
bottomplane(3) = bottomplane(3) / mag
RETURN

compute.visible.groups:
closestdist2 = 10000000
closestgroup = 1
fp42 = farplane(4) * farplane(4)

k = 1
k = VectorGroup(k).Identity
DO ' iterates k

    VectorGroup(k).Visible = 0

    dx = VectorGroup(k).COMx - camx
    dy = VectorGroup(k).COMy - camy
    dz = VectorGroup(k).COMz - camz

    dist2 = dx * dx + dy * dy + dz * dz

    IF dist2 < fp42 THEN

        groupinview = 1
        IF dx * nearplane(1) + dy * nearplane(2) + dz * nearplane(3) - nearplane(4) < 0 THEN groupinview = 0
        'IF dx * farplane(1) + dy * farplane(2) + dz * farplane(3) - farplane(4) < 0 THEN groupinview = 0
        IF dx * rightplane(1) + dy * rightplane(2) + dz * rightplane(3) - rightplane(4) < 0 THEN groupinview = 0
        IF dx * leftplane(1) + dy * leftplane(2) + dz * leftplane(3) - leftplane(4) < 0 THEN groupinview = 0
        IF dx * topplane(1) + dy * topplane(2) + dz * topplane(3) - topplane(4) < 0 THEN groupinview = 0
        IF dx * bottomplane(1) + dy * bottomplane(2) + dz * bottomplane(3) - bottomplane(4) < 0 THEN groupinview = 0
        IF groupinview = 1 THEN

            IF (dist2 < closestdist2) THEN
                closestdist2 = dist2
                closestgroup = k
            END IF

            VectorGroup(k).Visible = 1

            IF (toggletimeanimate = 1) THEN
                vecgroupid = k
                GOSUB timeanimate
            END IF

            FOR i = VectorGroup(k).FirstVector TO VectorGroup(k).LastVector
                GOSUB clip.project.vectors
            NEXT

        ELSE
            ' Force animation regardless of clipping.
            IF (VectorGroup(k).ForceAnimate = 1) THEN
                vecgroupid = k
                GOSUB timeanimate
            END IF
        END IF
    ELSE
        ' Force animation regardless of distance from camera.
        IF (VectorGroup(k).ForceAnimate = 1) THEN
            vecgroupid = k
            GOSUB timeanimate
        END IF
    END IF
    k = VectorGroup(k).Pointer
    IF k = -999 THEN EXIT DO
    k = VectorGroup(k).Identity
LOOP
RETURN

clip.project.vectors: ' requires i
vec(i, 1) = vec3Dpos(i, 1) - camx
vec(i, 2) = vec3Dpos(i, 2) - camy
vec(i, 3) = vec3Dpos(i, 3) - camz
fogswitch = -1
vec3Dvis(i) = 0
vectorinview = 1
' Perform view plane clipping.
IF vec(i, 1) * nearplane(1) + vec(i, 2) * nearplane(2) + vec(i, 3) * nearplane(3) - nearplane(4) < 0 THEN vectorinview = 0
IF vec(i, 1) * farplane(1) + vec(i, 2) * farplane(2) + vec(i, 3) * farplane(3) - farplane(4) < 0 THEN vectorinview = 0
IF vec(i, 1) * farplane(1) + vec(i, 2) * farplane(2) + vec(i, 3) * farplane(3) - farplane(4) * .85 < 0 THEN fogswitch = 1
IF vec(i, 1) * rightplane(1) + vec(i, 2) * rightplane(2) + vec(i, 3) * rightplane(3) - rightplane(4) < 0 THEN vectorinview = 0
IF vec(i, 1) * leftplane(1) + vec(i, 2) * leftplane(2) + vec(i, 3) * leftplane(3) - leftplane(4) < 0 THEN vectorinview = 0
IF vec(i, 1) * topplane(1) + vec(i, 2) * topplane(2) + vec(i, 3) * topplane(3) - topplane(4) < 0 THEN vectorinview = 0
IF vec(i, 1) * bottomplane(1) + vec(i, 2) * bottomplane(2) + vec(i, 3) * bottomplane(3) - bottomplane(4) < 0 THEN vectorinview = 0
IF vectorinview = 1 THEN
    vec3Dvis(i) = 1
    ' Project vectors onto the screen plane.
    vec3Ddotnhat = vec(i, 1) * nhat(1) + vec(i, 2) * nhat(2) + vec(i, 3) * nhat(3)
    vec2D(i, 1) = (vec(i, 1) * uhat(1) + vec(i, 2) * uhat(2) + vec(i, 3) * uhat(3)) * fovd / vec3Ddotnhat
    vec2D(i, 2) = (vec(i, 1) * vhat(1) + vec(i, 2) * vhat(2) + vec(i, 3) * vhat(3)) * fovd / vec3Ddotnhat
    IF fogswitch = 1 THEN vec2Dcolor(i) = Gray ELSE vec2Dcolor(i) = vec3Dcolor(i)
END IF
RETURN

timeanimate: ' requires vecgroupid
dt = timestep

xcom = VectorGroup(vecgroupid).COMx
ycom = VectorGroup(vecgroupid).COMy
zcom = VectorGroup(vecgroupid).COMz
xrot = VectorGroup(vecgroupid).ROTx
yrot = VectorGroup(vecgroupid).ROTy
zrot = VectorGroup(vecgroupid).ROTz
xrev = VectorGroup(vecgroupid).ROTx
yrev = VectorGroup(vecgroupid).ROTy
zrev = VectorGroup(vecgroupid).ROTz
xdim = VectorGroup(vecgroupid).DIMx
ydim = VectorGroup(vecgroupid).DIMy
zdim = VectorGroup(vecgroupid).DIMz

IF (VectorGroup(vecgroupid).COMFixed = 0) THEN GOSUB resetcom

FOR vectorindex = VectorGroup(vecgroupid).FirstVector TO VectorGroup(vecgroupid).LastVector

    ' Linear velocity update
    ax = vec3Dacc(vectorindex, 1)
    ay = vec3Dacc(vectorindex, 2)
    az = vec3Dacc(vectorindex, 3)
    IF (ax <> 0) THEN vec3Dvel(vectorindex, 1) = vec3Dvel(vectorindex, 1) + ax * dt
    IF (ay <> 0) THEN vec3Dvel(vectorindex, 2) = vec3Dvel(vectorindex, 2) + ay * dt
    IF (az <> 0) THEN vec3Dvel(vectorindex, 3) = vec3Dvel(vectorindex, 3) + az * dt

    ' Linear position update with periodic boundaries inside group dimension
    vx = vec3Dvel(vectorindex, 1)
    vy = vec3Dvel(vectorindex, 2)
    vz = vec3Dvel(vectorindex, 3)
    IF (vx <> 0) THEN
        px = vec3Dpos(vectorindex, 1) + vx * dt
        IF ABS(px - xcom) > xdim THEN
            IF (px > xcom) THEN
                px = xcom - xdim
            ELSE
                px = xcom + xdim
            END IF
        END IF
        vec3Dpos(vectorindex, 1) = px
    END IF
    IF (vy <> 0) THEN
        py = vec3Dpos(vectorindex, 2) + vy * dt
        IF ABS(py - ycom) > ydim THEN
            IF (py > ycom) THEN
                py = ycom - ydim
            ELSE
                py = ycom + ydim
            END IF
        END IF
        vec3Dpos(vectorindex, 2) = py
    END IF
    IF (vz <> 0) THEN
        pz = vec3Dpos(vectorindex, 3) + vz * dt
        IF ABS(pz - zcom) > zdim THEN
            IF (pz > zcom) THEN
                pz = zcom - zdim
            ELSE
                pz = zcom + zdim
            END IF
        END IF
        vec3Dpos(vectorindex, 3) = pz
    END IF

    ' Rotation update
    IF (xrot <> 0) THEN
        anv = vec3Danv(vectorindex, 1)
        yy = vec3Dpos(vectorindex, 2) - yrot
        zz = vec3Dpos(vectorindex, 3) - zrot
        y = yy * COS(timestep * anv) - zz * SIN(timestep * anv)
        z = yy * SIN(timestep * anv) + zz * COS(timestep * anv)
        vec3Dpos(vectorindex, 2) = y + yrot
        vec3Dpos(vectorindex, 3) = z + zrot
    END IF
    IF (yrot <> 0) THEN
        anv = vec3Danv(vectorindex, 2)
        xx = vec3Dpos(vectorindex, 1) - xrot
        zz = vec3Dpos(vectorindex, 3) - zrot
        x = xx * COS(timestep * anv) + zz * SIN(timestep * anv)
        z = -xx * SIN(timestep * anv) + zz * COS(timestep * anv)
        vec3Dpos(vectorindex, 1) = x + xrot
        vec3Dpos(vectorindex, 3) = z + zrot
    END IF
    IF (zrot <> 0) THEN
        anv = vec3Danv(vectorindex, 3)
        xx = vec3Dpos(vectorindex, 1) - xrot
        yy = vec3Dpos(vectorindex, 2) - yrot
        x = xx * COS(timestep * anv) - yy * SIN(timestep * anv)
        y = xx * SIN(timestep * anv) + yy * COS(timestep * anv)
        vec3Dpos(vectorindex, 1) = x + xrot
        vec3Dpos(vectorindex, 2) = y + yrot
    END IF

    ' Revolution update
    IF (xrev <> 0) THEN
        anv = xrev
        yy = vec3Dpos(vectorindex, 2) - ycom
        zz = vec3Dpos(vectorindex, 3) - zcom
        y = yy * COS(timestep * anv) - zz * SIN(timestep * anv)
        z = yy * SIN(timestep * anv) + zz * COS(timestep * anv)
        vec3Dpos(vectorindex, 2) = y + ycom
        vec3Dpos(vectorindex, 3) = z + zcom
    END IF
    IF (yrev <> 0) THEN
        anv = yrev
        xx = vec3Dpos(vectorindex, 1) - xcom
        zz = vec3Dpos(vectorindex, 3) - zcom
        x = xx * COS(timestep * anv) + zz * SIN(timestep * anv)
        z = -xx * SIN(timestep * anv) + zz * COS(timestep * anv)
        vec3Dpos(vectorindex, 1) = x + xcom
        vec3Dpos(vectorindex, 3) = z + zcom
    END IF
    IF (zrev <> 0) THEN
        anv = zrev
        xx = vec3Dpos(vectorindex, 1) - xcom
        yy = vec3Dpos(vectorindex, 2) - ycom
        x = xx * COS(timestep * anv) - yy * SIN(timestep * anv)
        y = xx * SIN(timestep * anv) + yy * COS(timestep * anv)
        vec3Dpos(vectorindex, 1) = x + xcom
        vec3Dpos(vectorindex, 2) = y + ycom
    END IF

    IF (VectorGroup(vecgroupid).COMFixed = 0) THEN GOSUB integratecom
NEXT
IF (VectorGroup(vecgroupid).COMFixed = 0) THEN GOSUB calculatecom
RETURN

integratecom: ' requires vecgroupid
VectorGroup(vecgroupid).COMx = vec3Dpos(vectorindex, 1) + VectorGroup(vecgroupid).COMx
VectorGroup(vecgroupid).COMy = vec3Dpos(vectorindex, 2) + VectorGroup(vecgroupid).COMy
VectorGroup(vecgroupid).COMz = vec3Dpos(vectorindex, 3) + VectorGroup(vecgroupid).COMz
RETURN

calculatecom: ' requires vecgroupid
f = 1 + VectorGroup(vecgroupid).LastVector - VectorGroup(vecgroupid).FirstVector
VectorGroup(vecgroupid).COMx = VectorGroup(vecgroupid).COMx / f
VectorGroup(vecgroupid).COMy = VectorGroup(vecgroupid).COMy / f
VectorGroup(vecgroupid).COMz = VectorGroup(vecgroupid).COMz / f
RETURN

resetcom: ' requires vecgroupid
VectorGroup(vecgroupid).COMx = 0
VectorGroup(vecgroupid).COMy = 0
VectorGroup(vecgroupid).COMz = 0
RETURN

plot.visible.vectors:
GOSUB plot.vectors
GOSUB plot.hud
RETURN

plot.vectors:
CLS
numgroupvisible = 0
numvectorvisible = 0
k = 1
k = VectorGroup(k).Identity
DO
    IF (VectorGroup(k).Visible = 1) THEN
        numgroupvisible = numgroupvisible + 1
        FOR i = VectorGroup(k).FirstVector TO VectorGroup(k).LastVector - 1
            IF (vec3Dvis(i) = 1) THEN
                numvectorvisible = numvectorvisible + 1
                IF k = closestgroup THEN col = Yellow ELSE col = vec2Dcolor(i)
                x = vec2D(i, 1): y = vec2D(i, 2): GOSUB convert: x1 = x: y1 = y
                x = vec2D(i + 1, 1): y = vec2D(i + 1, 2): GOSUB convert: x2 = x: y2 = y
                IF ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)) < 225 THEN
                    LINE (x1, y1)-(x2, y2), col
                ELSE
                    CIRCLE (x1, y1), 1, col
                END IF
            END IF
        NEXT
    END IF
    k = VectorGroup(k).Pointer
    IF k = -999 THEN EXIT DO
    k = VectorGroup(k).Identity
LOOP
RETURN

plot.hud:
' Redraw compass.
x = 30 * (xhat(1) * uhat(1) + xhat(2) * uhat(2) + xhat(3) * uhat(3)): y = 30 * (xhat(1) * vhat(1) + xhat(2) * vhat(2) + xhat(3) * vhat(3)): GOSUB convert
LINE (midscreenx, midscreeny)-(x, y), Red
x = 30 * (yhat(1) * uhat(1) + yhat(2) * uhat(2) + yhat(3) * uhat(3)): y = 30 * (yhat(1) * vhat(1) + yhat(2) * vhat(2) + yhat(3) * vhat(3)): GOSUB convert
LINE (midscreenx, midscreeny)-(x, y), Green
x = 30 * (zhat(1) * uhat(1) + zhat(2) * uhat(2) + zhat(3) * uhat(3)): y = 30 * (zhat(1) * vhat(1) + zhat(2) * vhat(2) + zhat(3) * vhat(3)): GOSUB convert
LINE (midscreenx, midscreeny)-(x, y), Blue
IF togglehud = 1 THEN
    COLOR LimeGreen
    LOCATE 2, 2: PRINT "- View Info -"
    COLOR DarkKhaki
    LOCATE 3, 2: PRINT "FPS:"; fpsreport
    LOCATE 4, 2: PRINT "Vectors:"; numvectorvisible
    LOCATE 5, 2: PRINT "Groups:"; numgroupvisible
    LOCATE 6, 2: PRINT "Depth:"; -farplane(4)
    LOCATE 7, 2: PRINT "Adjust via [ ]"
    COLOR LimeGreen
    LOCATE 9, 2: PRINT "- Camera -"
    COLOR DarkKhaki
    LOCATE 10, 2: PRINT INT(camx); INT(camy); INT(camz)
    COLOR LimeGreen
    LOCATE 12, 2: PRINT "- Closest: -"
    COLOR DarkKhaki
    LOCATE 13, 2: PRINT LTRIM$(RTRIM$(VectorGroup(closestgroup).GroupName))
    COLOR LimeGreen
    a$ = "MOVE - ALIGN": LOCATE 2, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR DarkKhaki
    a$ = "q w e - x y z": LOCATE 3, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "a s d - X Y Z": LOCATE 4, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "i = invert ms": LOCATE 5, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR LimeGreen
    a$ = "- ROTATE -": LOCATE 7, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR DarkKhaki
    a$ = "7 8 9 Mouse": LOCATE 8, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "4 5 6   +  ": LOCATE 9, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "1 2 3 Wheel": LOCATE 10, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR LimeGreen
    a$ = "- CONTROL -": LOCATE 12, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR DarkKhaki
    a$ = "t = Stop time": LOCATE 13, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "b = Create": LOCATE 14, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "n = Destroy": LOCATE 15, screenwidth / 8 - LEN(a$): PRINT a$
    a$ = "k = Delete": LOCATE 16, screenwidth / 8 - LEN(a$): PRINT a$
    COLOR LimeGreen
    a$ = "SPACE = Hide Info": LOCATE (screenheight / 16) - 3, (screenwidth / 8) / 2 - LEN(a$) / 2: PRINT a$
ELSE
    COLOR LimeGreen
    a$ = "You See: " + LTRIM$(RTRIM$(VectorGroup(closestgroup).GroupName)): LOCATE (screenheight / 16) - 3, (screenwidth / 8) / 2 - LEN(a$) / 2: PRINT a$
END IF
RETURN

'groupidfromname: ' requires n$, returns k
'k = 1
'k = VectorGroup(k).Identity
'DO ' iterates k
'    IF n$ = LTRIM$(RTRIM$(VectorGroup(k).GroupName)) THEN EXIT DO
'    k = VectorGroup(k).Pointer
'    IF k = -999 THEN EXIT DO
'    k = VectorGroup(k).Identity
'LOOP
'RETURN

' Data.

initialize.objects:
vectorindex = 0
groupidticker = 0
gridsize = 550
tilesize = 15

'__AAA
groupidticker = groupidticker + 1
vecgroupid = groupidticker
VectorGroup(vecgroupid).Identity = vecgroupid
VectorGroup(vecgroupid).Pointer = vecgroupid + 1
VectorGroup(vecgroupid).Lagger = vecgroupid - 1 ' Fancy way to say 0.
VectorGroup(vecgroupid).GroupName = "__AAA"
VectorGroup(vecgroupid).Visible = 0
VectorGroup(vecgroupid).COMFixed = 1
VectorGroup(vecgroupid).DIMx = 5
VectorGroup(vecgroupid).DIMy = 5
VectorGroup(vecgroupid).DIMz = 5
VectorGroup(vecgroupid).FirstVector = vectorindex + 1
FOR r = 1 TO 1
    vectorindex = vectorindex + 1
    vec3Dpos(vectorindex, 1) = 0
    vec3Dpos(vectorindex, 2) = 0
    vec3Dpos(vectorindex, 3) = -1000
    vec3Dcolor(vectorindex) = White
    GOSUB integratecom
NEXT
VectorGroup(vecgroupid).LastVector = vectorindex
GOSUB calculatecom

'Dirt
h = 5
FOR w = 1 TO 5
    FOR u = -gridsize TO gridsize STEP tilesize
        FOR v = -gridsize TO gridsize STEP tilesize
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Dirt"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = 35
            VectorGroup(vecgroupid).DIMy = 35
            VectorGroup(vecgroupid).DIMz = 35
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR i = u TO u + tilesize STEP h
                FOR j = v TO v + tilesize STEP h
                    IF RND > 1 - w / 5 THEN
                        vectorindex = vectorindex + 1
                        vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                        vec3Dpos(vectorindex, 2) = j + RND * h - RND * h
                        vec3Dpos(vectorindex, 3) = -(w - 1) * 70 - RND * 70
                        vec3Dvis(vectorindex) = 0
                        IF RND > .5 THEN
                            vec3Dcolor(vectorindex) = DarkGoldenRod
                        ELSE
                            IF RND > .5 THEN
                                vec3Dcolor(vectorindex) = SaddleBrown
                            ELSE
                                vec3Dcolor(vectorindex) = Sienna
                            END IF
                        END IF
                        GOSUB integratecom
                    END IF
                NEXT
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
    NEXT
NEXT

'Grass and Puddles
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Grass and Puddles"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = 3
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 2) = j + RND * h - RND * h
                vec3Dpos(vectorindex, 3) = .5 + 1 * COS((i - 15) * .08) - 1 * COS((j - 6) * .12)
                vec3Dvis(vectorindex) = 0
                IF vec3Dpos(vectorindex, 3) > 0 THEN
                    IF RND > .5 THEN
                        vec3Dcolor(vectorindex) = Green
                    ELSE
                        vec3Dcolor(vectorindex) = ForestGreen
                    END IF
                ELSE
                    vec3Dvel(vectorindex, 1) = (RND - .5) * 20
                    vec3Dvel(vectorindex, 2) = (RND - .5) * 20
                    vec3Dvel(vectorindex, 3) = (RND - .5) * 20
                    IF RND > .2 THEN
                        vec3Dcolor(vectorindex) = LightSeaGreen
                    ELSE
                        vec3Dcolor(vectorindex) = Blue
                    END IF
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Grave
thickness = 2.5
span = 20
height = 30
crux = 22
FOR xloc = -90 TO -290 STEP -60
    FOR yloc = 0 TO 180 STEP 45
        FOR k = 0 TO height
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Grave"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = thickness
            VectorGroup(vecgroupid).DIMy = thickness
            VectorGroup(vecgroupid).DIMz = thickness
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR i = -thickness TO thickness STEP thickness / 2
                FOR j = -thickness TO thickness STEP thickness / 2
                    vectorindex = vectorindex + 1
                    vec3Dpos(vectorindex, 1) = xloc + i + (RND - .5) * 2
                    vec3Dpos(vectorindex, 2) = yloc + j + (RND - .5) * 2
                    vec3Dpos(vectorindex, 3) = k + (RND - .5) * 2
                    vec3Dvis(vectorindex) = 0
                    IF RND > .5 THEN
                        vec3Dcolor(vectorindex) = SlateGray
                    ELSE
                        vec3Dcolor(vectorindex) = DarkGray
                    END IF
                    GOSUB integratecom
                NEXT
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
        FOR j = -span / 2 TO -thickness
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Grave"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = thickness
            VectorGroup(vecgroupid).DIMy = thickness
            VectorGroup(vecgroupid).DIMz = thickness
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR k = -thickness TO thickness STEP thickness / 2
                FOR i = -thickness TO thickness STEP thickness / 2
                    vectorindex = vectorindex + 1
                    vec3Dpos(vectorindex, 1) = xloc + i + (RND - .5) * 2
                    vec3Dpos(vectorindex, 2) = yloc + j + (RND - .5) * 2
                    vec3Dpos(vectorindex, 3) = crux + k + (RND - .5) * 2
                    vec3Dvis(vectorindex) = 0
                    IF RND > .5 THEN
                        vec3Dcolor(vectorindex) = SlateGray
                    ELSE
                        vec3Dcolor(vectorindex) = DarkGray
                    END IF
                    GOSUB integratecom
                NEXT
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
        FOR j = thickness TO span / 2
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Grave"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = thickness
            VectorGroup(vecgroupid).DIMy = thickness
            VectorGroup(vecgroupid).DIMz = thickness
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR k = -thickness TO thickness STEP thickness / 2
                FOR i = -thickness TO thickness STEP thickness / 2
                    vectorindex = vectorindex + 1
                    vec3Dpos(vectorindex, 1) = xloc + i + (RND - .5) * 2
                    vec3Dpos(vectorindex, 2) = yloc + j + (RND - .5) * 2
                    vec3Dpos(vectorindex, 3) = crux + k + (RND - .5) * 2
                    vec3Dvis(vectorindex) = 0
                    IF RND > .5 THEN
                        vec3Dcolor(vectorindex) = SlateGray
                    ELSE
                        vec3Dcolor(vectorindex) = DarkGray
                    END IF
                    GOSUB integratecom
                NEXT
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
    NEXT
NEXT

'Heaven's Bottom Layer
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Heaven's Bottom Layer"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = 3
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 2) = j + RND * h - RND * h
                vec3Dpos(vectorindex, 3) = 420 - RND
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = BlueViolet
                ELSE
                    vec3Dcolor(vectorindex) = Cyan
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Hell Spawn
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Hell Spawn"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = 35
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP tilesize / 5
            FOR j = v TO v + tilesize STEP tilesize / 5
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 2) = j + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 3) = -350 - RND * 70
                vec3Dvel(vectorindex, 1) = 0
                vec3Dvel(vectorindex, 2) = 0
                vec3Dvel(vectorindex, 3) = 400 * RND
                vec3Dvis(vectorindex) = 0
                IF RND > .2 THEN
                    vec3Dcolor(vectorindex) = Red
                ELSE
                    vec3Dcolor(vectorindex) = DarkGoldenRod
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
        VectorGroup(vecgroupid).COMz = -350 - 35
    NEXT
NEXT

'Icewall East
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = 0 TO 70 STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Icewall East"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = tilesize / 2
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = gridsize + tilesize / 2
                vec3Dpos(vectorindex, 2) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 3) = j + RND * h - RND * h
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = White
                ELSE
                    vec3Dcolor(vectorindex) = Ivory
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Icewall South
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = 0 TO 70 STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Icewall South"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = tilesize / 2
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = -gridsize
                vec3Dpos(vectorindex, 2) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 3) = j + RND * h - RND * h
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = White
                ELSE
                    vec3Dcolor(vectorindex) = Ivory
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Icewall North
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = 0 TO 70 STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Icewall North"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = tilesize / 2
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 2) = gridsize + tilesize / 2
                vec3Dpos(vectorindex, 3) = j + RND * h - RND * h
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = White
                ELSE
                    vec3Dcolor(vectorindex) = Ivory
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Icewall West
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = 0 TO 70 STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Icewall West"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = tilesize / 2
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 2) = -gridsize
                vec3Dpos(vectorindex, 3) = j + RND * h - RND * h
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = White
                ELSE
                    vec3Dcolor(vectorindex) = Ivory
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Lake of Fire
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Lake of Fire"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = tilesize / 2
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                vec3Dpos(vectorindex, 2) = j + RND * h - RND * h
                vec3Dpos(vectorindex, 3) = -350 - 70 - RND
                vec3Dvis(vectorindex) = 0
                IF RND > .2 THEN
                    vec3Dcolor(vectorindex) = Red
                ELSE
                    vec3Dcolor(vectorindex) = Indigo
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Megalith
ctrx = -90
ctry = -320
ctrz = 4
w = 8
h = 256
dens = 100
FOR k = 1 TO h STEP w
    FOR i = -h / 20 + k / 20 TO h / 20 - k / 20 STEP w
        FOR j = -h / 20 + k / 20 TO h / 20 - k / 20 STEP w
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Megalith"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = w / 2
            VectorGroup(vecgroupid).DIMy = w / 2
            VectorGroup(vecgroupid).DIMz = w / 2
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR q = 1 TO dens
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = ctrx + i + (RND - .5) * w
                vec3Dpos(vectorindex, 2) = ctry + j + (RND - .5) * w
                vec3Dpos(vectorindex, 3) = ctrz + k + (RND - .5) * w
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = Cyan
                ELSE
                    vec3Dcolor(vectorindex) = Teal
                END IF
                GOSUB integratecom
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
    NEXT
NEXT

'Pyramid
ctrx = -90
ctry = -120
ctrz = 4
w = 8
h = 56
dens = 50
FOR k = 1 TO h STEP w
    FOR i = -h / 2 + k / 2 TO h / 2 - k / 2 STEP w
        FOR j = -h / 2 + k / 2 TO h / 2 - k / 2 STEP w
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Pyramid"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = tilesize / 2
            VectorGroup(vecgroupid).DIMy = tilesize / 2
            VectorGroup(vecgroupid).DIMz = tilesize / 2
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR q = 1 TO dens
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = ctrx + i + (RND - .5) * w
                vec3Dpos(vectorindex, 2) = ctry + j + (RND - .5) * w
                vec3Dpos(vectorindex, 3) = ctrz + k + (RND - .5) * w
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = DarkGoldenRod
                ELSE
                    vec3Dcolor(vectorindex) = GoldenRod
                END IF
                GOSUB integratecom
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
    NEXT
NEXT

'Rain
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Rain"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = 35
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP tilesize '/ 3
            FOR j = v TO v + tilesize STEP tilesize '/ 3
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 2) = j + (RND - .5) * tilesize
                vec3Dpos(vectorindex, 3) = RND * 70
                vec3Dvel(vectorindex, 1) = 0
                vec3Dvel(vectorindex, 2) = 0
                vec3Dvel(vectorindex, 3) = -400 * RND
                vec3Dvis(vectorindex) = 0
                IF RND > 5 THEN
                    vec3Dcolor(vectorindex) = Aquamarine
                ELSE
                    vec3Dcolor(vectorindex) = DodgerBlue
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
        VectorGroup(vecgroupid).COMz = 35
    NEXT
NEXT

'Sky
h = 2
FOR u = -gridsize TO gridsize STEP tilesize
    FOR v = -gridsize TO gridsize STEP tilesize
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Sky"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = tilesize / 2
        VectorGroup(vecgroupid).DIMy = tilesize / 2
        VectorGroup(vecgroupid).DIMz = 3
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR i = u TO u + tilesize STEP h
            FOR j = v TO v + tilesize STEP h
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = i + (RND - RND) * h
                vec3Dpos(vectorindex, 2) = j + (RND - RND) * h
                vec3Dpos(vectorindex, 3) = 70 + (RND - RND) * h
                vec3Dvel(vectorindex, 1) = (RND - RND) * 2
                vec3Dvel(vectorindex, 2) = (RND - RND) * 2
                vec3Dvel(vectorindex, 3) = (RND - RND) * 2
                vec3Danv(vectorindex, 1) = 0
                vec3Danv(vectorindex, 2) = 0
                vec3Danv(vectorindex, 3) = 0
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = Snow
                ELSE
                    vec3Dcolor(vectorindex) = RoyalBlue
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Stars
h = 5
FOR w = 1 TO 5
    FOR u = -gridsize TO gridsize STEP tilesize
        FOR v = -gridsize TO gridsize STEP tilesize
            groupidticker = groupidticker + 1
            vecgroupid = groupidticker
            VectorGroup(vecgroupid).Identity = vecgroupid
            VectorGroup(vecgroupid).Pointer = vecgroupid + 1
            VectorGroup(vecgroupid).Lagger = vecgroupid - 1
            VectorGroup(vecgroupid).GroupName = "Stars"
            VectorGroup(vecgroupid).Visible = 0
            VectorGroup(vecgroupid).COMFixed = 1
            VectorGroup(vecgroupid).DIMx = tilesize / 2
            VectorGroup(vecgroupid).DIMy = tilesize / 2
            VectorGroup(vecgroupid).DIMz = tilesize / 2
            VectorGroup(vecgroupid).FirstVector = vectorindex + 1
            FOR i = u TO u + tilesize STEP h
                FOR j = v TO v + tilesize STEP h
                    IF RND > 1 - w / 5 THEN
                        vectorindex = vectorindex + 1
                        vec3Dpos(vectorindex, 1) = i + RND * h - RND * h
                        vec3Dpos(vectorindex, 2) = j + RND * h - RND * h
                        vec3Dpos(vectorindex, 3) = w * 70 + RND * 70
                        vec3Dvis(vectorindex) = 0
                        IF RND > .5 THEN
                            vec3Dcolor(vectorindex) = GhostWhite
                        ELSE
                            IF RND > .5 THEN
                                vec3Dcolor(vectorindex) = White
                            ELSE
                                vec3Dcolor(vectorindex) = DarkGray
                            END IF
                        END IF
                        GOSUB integratecom
                    END IF
                NEXT
            NEXT
            VectorGroup(vecgroupid).LastVector = vectorindex
            GOSUB calculatecom
        NEXT
    NEXT
NEXT

'Sun
radius = 10
dx = .0628
dy = .0628
xl = 0: xr = 2 * pi
yl = 0: yr = pi
xrange = 1 + INT((-xl + xr) / dx)
yrange = 1 + INT((-yl + yr) / dy)
FOR i = 1 TO xrange STEP 10
    FOR j = 1 TO yrange STEP 10
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Sun"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = radius
        VectorGroup(vecgroupid).DIMy = radius
        VectorGroup(vecgroupid).DIMz = radius
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR u = i TO i + 10 STEP 1
            FOR v = j TO j + 10 STEP 1
                vectorindex = vectorindex + 1
                theta = u * dx - dx
                phi = v * dy - dy
                vec3Dpos(vectorindex, 1) = radius * SIN(phi) * COS(theta)
                vec3Dpos(vectorindex, 2) = radius * SIN(phi) * SIN(theta)
                vec3Dpos(vectorindex, 3) = 90 + radius * COS(phi)
                vec3Dvis(vectorindex) = 0
                IF RND > .5 THEN
                    vec3Dcolor(vectorindex) = Sunglow
                ELSE
                    vec3Dcolor(vectorindex) = SunsetOrange
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        GOSUB integratecom
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Moon
radius = 4
au = 60
dx = (2 * pi / radius) * .05
dy = (2 * pi / radius) * .05
xl = 0: xr = 2 * pi
yl = 0: yr = pi
xrange = 1 + INT((-xl + xr) / dx)
yrange = 1 + INT((-yl + yr) / dy)
groupidticker = groupidticker + 1
vecgroupid = groupidticker
VectorGroup(vecgroupid).Identity = vecgroupid
VectorGroup(vecgroupid).Pointer = vecgroupid + 1
VectorGroup(vecgroupid).Lagger = vecgroupid - 1
VectorGroup(vecgroupid).GroupName = "Moon"
VectorGroup(vecgroupid).Visible = 0
VectorGroup(vecgroupid).ForceAnimate = 1
VectorGroup(vecgroupid).COMFixed = 0
VectorGroup(vecgroupid).ROTx = 0
VectorGroup(vecgroupid).ROTy = 0
VectorGroup(vecgroupid).ROTz = 90
VectorGroup(vecgroupid).REVx = 1.5
VectorGroup(vecgroupid).REVy = 0
VectorGroup(vecgroupid).REVz = 0
VectorGroup(vecgroupid).DIMx = 2 * radius + 1
VectorGroup(vecgroupid).DIMy = 2 * radius + 1
VectorGroup(vecgroupid).DIMz = 2 * radius + 1
VectorGroup(vecgroupid).FirstVector = vectorindex + 1
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        vectorindex = vectorindex + 1
        theta = i * dx - dx
        phi = j * dy - dy
        vec3Dpos(vectorindex, 1) = au + radius * SIN(phi) * COS(theta)
        vec3Dpos(vectorindex, 2) = radius * SIN(phi) * SIN(theta)
        vec3Dpos(vectorindex, 3) = 90 + radius * COS(phi)
        vec3Danv(vectorindex, 1) = 0
        vec3Danv(vectorindex, 2) = 0
        vec3Danv(vectorindex, 3) = 1.5
        vec3Dvis(vectorindex) = 0
        IF RND > .5 THEN
            vec3Dcolor(vectorindex) = Gray
        ELSE
            vec3Dcolor(vectorindex) = PaleGoldenRod
        END IF
        GOSUB integratecom
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Waves or Particles? (1)
FOR i = 1 TO 5 STEP 1
    FOR k = 1 TO 5 STEP 1
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Waves or Particles?"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = 4
        VectorGroup(vecgroupid).DIMy = 1
        VectorGroup(vecgroupid).DIMz = 4
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR u = i TO i + 1 STEP .05
            FOR v = k TO k + 1 STEP .05
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = 70 + 7 * u
                vec3Dpos(vectorindex, 2) = 80 + 1 * COS((u ^ 2 - v ^ 2))
                vec3Dpos(vectorindex, 3) = 10 + 7 * v
                vec3Dvis(vectorindex) = 0
                IF vec3Dpos(vectorindex, 2) < 80 THEN
                    vec3Dcolor(vectorindex) = DarkBlue
                ELSE
                    vec3Dcolor(vectorindex) = DeepPink
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'Waves or Particles? (2)
FOR i = 1 TO 5 STEP 1
    FOR k = 1 TO 5 STEP 1
        groupidticker = groupidticker + 1
        vecgroupid = groupidticker
        VectorGroup(vecgroupid).Identity = vecgroupid
        VectorGroup(vecgroupid).Pointer = vecgroupid + 1
        VectorGroup(vecgroupid).Lagger = vecgroupid - 1
        VectorGroup(vecgroupid).GroupName = "Particles or Waves?"
        VectorGroup(vecgroupid).Visible = 0
        VectorGroup(vecgroupid).COMFixed = 1
        VectorGroup(vecgroupid).DIMx = 4
        VectorGroup(vecgroupid).DIMy = 1
        VectorGroup(vecgroupid).DIMz = 4
        VectorGroup(vecgroupid).FirstVector = vectorindex + 1
        FOR u = i TO i + 1 STEP .05
            FOR v = k TO k + 1 STEP .05
                vectorindex = vectorindex + 1
                vec3Dpos(vectorindex, 1) = -7 * u
                vec3Dpos(vectorindex, 2) = 80 + 1 * COS(2 * ((u - 7) ^ 2 - (v - 5) ^ 2))
                vec3Dpos(vectorindex, 3) = 10 + 7 * v
                vec3Dvis(vectorindex) = 0
                IF vec3Dpos(vectorindex, 2) < 80 THEN
                    vec3Dcolor(vectorindex) = Magenta
                ELSE
                    vec3Dcolor(vectorindex) = Chocolate
                END IF
                GOSUB integratecom
            NEXT
        NEXT
        VectorGroup(vecgroupid).LastVector = vectorindex
        GOSUB calculatecom
    NEXT
NEXT

'__ZZZ
groupidticker = groupidticker + 1
vecgroupid = groupidticker
VectorGroup(vecgroupid).Identity = vecgroupid
VectorGroup(vecgroupid).Pointer = -999
VectorGroup(vecgroupid).Lagger = vecgroupid - 1
VectorGroup(vecgroupid).GroupName = "__ZZZ"
VectorGroup(vecgroupid).COMFixed = 1
VectorGroup(vecgroupid).FirstVector = vectorindex + 1
FOR r = 1 TO 1
    vectorindex = vectorindex + 1
    vec3Dpos(vectorindex, 1) = 0
    vec3Dpos(vectorindex, 2) = 0
    vec3Dpos(vectorindex, 3) = -1000
    vec3Dcolor(vectorindex) = White
    GOSUB integratecom
NEXT
VectorGroup(vecgroupid).LastVector = vectorindex
GOSUB calculatecom
RETURN


