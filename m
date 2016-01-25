From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 25 Jan 2016 18:55:19 +0100
Message-ID: <20160125185519.436339fc@bbrezillon>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20160125170855.GA10182@ulmo>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Doug Anderson <dianders@google.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, 25 Jan 2016 18:08:55 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Jan 25, 2016 at 08:28:31AM -0800, Doug Anderson wrote:
> > Thierry and Boris,
> >=20
> > On Tue, Nov 10, 2015 at 9:34 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St=C3=BCbner wrot=
e:
> > >> Hi Thierry,
> > >>
> > >> Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> > >> > Hello,
> > >> >
> > >> > This series adds support for atomic PWM update, or IOW, the ca=
pability
> > >> > to update all the parameters of a PWM device (enabled/disabled=
, period,
> > >> > duty and polarity) in one go.
> > >>
> > >> is anything more blocking this series? It's now sitting on the l=
ists for
> > >> nearly a month and everybody seems happy with it, so it would be=
 really nice
> > >> to have in mainline :-) .
> > >>
> > >> Especially as this also makes it possible for Rockchip Chromeboo=
ks to actually
> > >> control the logic-regulator that is implemented as pwm-regulator=
 there.
> > >
> > > Last time I tried to put this into linux-next I got immediately
> > > bombarded by a number of build failures, so I backed things out. =
The
> > > current plan is to give this another try after v4.4-rc1.
> >=20
> > We're now into the 4.5 timeframe.  Does anyone have a concrete set =
of
> > things that need to happen before this patch series makes it into
> > mainline?
>=20
> I think the current status is that we're more or less blocked on the
> decision on what the reset state of the PWM should be. The question i=
s
> what to do if the PWM hardware readout differs from the settings foun=
d
> in DT.

I think I already explained my PoV regarding the default/reference
setting (or what you later call the software state).
To me, this has never matched the state of the PWM device, it's just a
reference duty-cycle and polarity configuration that PWM users can
decide to apply or not. Currently, there's no mechanism to apply the
reference PWM config when a user request a PWM (which is the only
moment we could be able to apply this config, since reference configs
are per users and not attached to the PWM device itself).

All I'm trying to do in this series is teach some PWM users to make use
of hardware read-out state instead of blindly applying a default config
that can generate glitches in the PWM signal.

>=20
> > From searching I see that the latest version of this series is v4 a=
nd
> > there are a smattering of comments on the 24-patch series.  Presuma=
bly
> > a v5 needs to be posted to address those things.
> >=20
> > ...but it looks like the big sticking point is that Boris is waitin=
g
> > for a response to his questions in
> > <https://patchwork.kernel.org/patch/7622881/>.  Thierry: can you gi=
ve
> > Boris some direction for what else he needs to do?  We need to come=
 up
> > with _some_ solution since this series gets us much better support =
for
> > PWM regulators.  Without this series or some other solution, PWM
> > regulators aren't usable in mainline on any system that uses them f=
or
> > system-critical rails.  Nearly all Rockchip reference boards and
> > shipping devices uses a PWM regulator for the system-critidal "logi=
c"
> > rail.  That means any patches which need to change this rail in Lin=
ux
> > are blocked.
>=20
> I really don't understand this design decision. I presume that the PW=
M
> controlling this system-critical logic is driven by the SoC? So if th=
e
> regulator is system-critical, doesn't that make it a chicken and egg
> problem? How can the SoC turn the PWM on if it doesn't have power? Bu=
t
> perhaps I'm completely misunderstanding what you're saying. Perhaps i=
f
> somebody could summarize how exactly this works, it would help better
> understand the requirements or what's the correct thing to do.
>=20
> > If there's already been off-list discussion and Boris already knows
> > what the next steps are then my apologies and I'll wait patiently f=
or
> > the next series.  ;)
>=20
> I don't think we reached a conclusion on this. And to be honest, I'm =
not
> sure what the right way forward is in this situation. So in order to
> make some forward progress I suggest we start a discussion, hopefully
> that will clarify the situation and help lead to the conclusion. Let =
me
> recap where we are:
>=20
> Boris' series has two goals: 1) allow seamless hand-off from firmware=
 to
> kernel of a PWM channel and 2) apply changes to a regulator in a sing=
le
> atomic operation. To achieve this the concept of PWM state is introdu=
ced
> which encapsulates the settings of a PWM channel. On driver probe the
> current state will be read from hardware and when one or more paramet=
ers
> are to be changed, the current state is duplicated, the new values se=
t
> in the state and the new state applied.
>=20
> The problem that we've encountered is that since the PWM parameters a=
re
> specified in DT (or board files), there is the possibility of the PWM
> hardware state and the board parameters disagreeing. To resolve such
> situations there must be a point in time where both hardware state an=
d
> software state must be synchronized.

Maybe we're just hunting ghosts here. There's only one valid state, and
this is the 'hardware state'. I reused the pwm_state struct to store th=
e
reference config (what you call software state), but actually that's
not a state, that's a configuration template, it will only become the
PWM state after being applied.
Maybe I should use another struct to clarify that.

> Now the most straightforward way to
> do that would be to simply apply the software state and be done with =
it.

Why that? I mean what's the problem of having a reference/template
config that PWM users can rely on if they want to, and still keep
the real state retrieved from hardware read-out? This way PWM users can
decide which one they want to use.

> However the software state initially lacks the duty cycle because it =
is
> a parameter that usually depends on the use-case (for backlight for
> instance it controls the brightness, for regulators it controls the
> output voltage, ...).

Yes, and I perfectly understand that, we don't want to encode the
default duty cycle in the DT.

>=20
> Applying the software state as-is also means that there's no reason a=
t
> all to read out the hardware state in the first place, because it wil=
l
> simply be discarded.

Yes, but as stated above, this can be a source of glitches, which is
exactly what we're trying to avoid.

>=20
> An alternative would be to discard the software state and trust the
> hardware to be configured correctly. That's somewhat risky because we
> don't know if the hardware is properly configured. Or Linux might hav=
e
> different requirements from the firmware and hence needs to configure
> the PWM differently.

Yep, I agree on that too.

>=20
> Neither of the above are very attractive options. The best I've been
> able to come up with so far is to completely remove this decision fro=
m
> the PWM subsystem and let users handle this. That is, a PWM regulator
> driver would have to have all the knowledge about how to configure th=
e
> PWM for its needs. So upon probe, the PWM regulator driver would insp=
ect
> the current state of the PWM and adjust if necessary, then apply agai=
n.
> Ideally of course it wouldn't have to do anything because the hardwar=
e
> PWM state would match the software configuration. The idea here is th=
at
> the PWM regulator driver knows exactly what duty cycle to configure t=
o
> obtain the desired output voltage.

That complicates a lot of things. I also suggested another approach:
provide an API to express the duty-cycle value relatively to the period
value (I actually sent a proposal for that, but you didn't comment on
it).
This would keep the PWM user implementations simple, and let the PWM
core switch from the bootloader/firmware period/polarity config to the
DT/PWM-lookup-table one on the first pwm_set_rel_duty_cycle() call.

>=20
> That doesn't really get us closer, though. There is still the issue o=
f
> the user having to deal with two states: the current hardware state a=
nd
> the software state as configured in DT or board files.

At the risk of repeating myself, I don't think we ever had a software
state, and existing PWM users are just assuming that the PWM devices
they are requesting were not used before. IOW, yes, patching PWM users
to support smoother transitions on the PWM devices require some changes=
,
but in the other hand, that's not like they were doing any better
before that series. And they still have the choice to completely ignore
the current PWM state and blindly apply their own config (extracted
from the reference PWM config)

Best Regards,

Boris

>=20
> Like I said, I'm on the fence about this, so I'd appreciate any comme=
nts
> and perhaps insight from user subsystem maintainers on how they'd lik=
e
> this to look, or how this has been done with other resources (GPIOs,
> ...?)
>=20
> Thierry



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
