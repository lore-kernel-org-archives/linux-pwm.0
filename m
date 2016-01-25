From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 25 Jan 2016 18:08:55 +0100
Message-ID: <20160125170855.GA10182@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
 <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBKNNTG2QKGQEGWV542Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@lists>
List-Id: linux-pwm@vger.kernel.org

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 08:28:31AM -0800, Doug Anderson wrote:
> Thierry and Boris,
>=20
> On Tue, Nov 10, 2015 at 9:34 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St=C3=BCbner wrote:
> >> Hi Thierry,
> >>
> >> Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> >> > Hello,
> >> >
> >> > This series adds support for atomic PWM update, or IOW, the capabili=
ty
> >> > to update all the parameters of a PWM device (enabled/disabled, peri=
od,
> >> > duty and polarity) in one go.
> >>
> >> is anything more blocking this series? It's now sitting on the lists f=
or
> >> nearly a month and everybody seems happy with it, so it would be reall=
y nice
> >> to have in mainline :-) .
> >>
> >> Especially as this also makes it possible for Rockchip Chromebooks to =
actually
> >> control the logic-regulator that is implemented as pwm-regulator there=
.
> >
> > Last time I tried to put this into linux-next I got immediately
> > bombarded by a number of build failures, so I backed things out. The
> > current plan is to give this another try after v4.4-rc1.
>=20
> We're now into the 4.5 timeframe.  Does anyone have a concrete set of
> things that need to happen before this patch series makes it into
> mainline?

I think the current status is that we're more or less blocked on the
decision on what the reset state of the PWM should be. The question is
what to do if the PWM hardware readout differs from the settings found
in DT.

> From searching I see that the latest version of this series is v4 and
> there are a smattering of comments on the 24-patch series.  Presumably
> a v5 needs to be posted to address those things.
>=20
> ...but it looks like the big sticking point is that Boris is waiting
> for a response to his questions in
> <https://patchwork.kernel.org/patch/7622881/>.  Thierry: can you give
> Boris some direction for what else he needs to do?  We need to come up
> with _some_ solution since this series gets us much better support for
> PWM regulators.  Without this series or some other solution, PWM
> regulators aren't usable in mainline on any system that uses them for
> system-critical rails.  Nearly all Rockchip reference boards and
> shipping devices uses a PWM regulator for the system-critidal "logic"
> rail.  That means any patches which need to change this rail in Linux
> are blocked.

I really don't understand this design decision. I presume that the PWM
controlling this system-critical logic is driven by the SoC? So if the
regulator is system-critical, doesn't that make it a chicken and egg
problem? How can the SoC turn the PWM on if it doesn't have power? But
perhaps I'm completely misunderstanding what you're saying. Perhaps if
somebody could summarize how exactly this works, it would help better
understand the requirements or what's the correct thing to do.

> If there's already been off-list discussion and Boris already knows
> what the next steps are then my apologies and I'll wait patiently for
> the next series.  ;)

I don't think we reached a conclusion on this. And to be honest, I'm not
sure what the right way forward is in this situation. So in order to
make some forward progress I suggest we start a discussion, hopefully
that will clarify the situation and help lead to the conclusion. Let me
recap where we are:

Boris' series has two goals: 1) allow seamless hand-off from firmware to
kernel of a PWM channel and 2) apply changes to a regulator in a single
atomic operation. To achieve this the concept of PWM state is introduced
which encapsulates the settings of a PWM channel. On driver probe the
current state will be read from hardware and when one or more parameters
are to be changed, the current state is duplicated, the new values set
in the state and the new state applied.

The problem that we've encountered is that since the PWM parameters are
specified in DT (or board files), there is the possibility of the PWM
hardware state and the board parameters disagreeing. To resolve such
situations there must be a point in time where both hardware state and
software state must be synchronized. Now the most straightforward way to
do that would be to simply apply the software state and be done with it.
However the software state initially lacks the duty cycle because it is
a parameter that usually depends on the use-case (for backlight for
instance it controls the brightness, for regulators it controls the
output voltage, ...).

Applying the software state as-is also means that there's no reason at
all to read out the hardware state in the first place, because it will
simply be discarded.

An alternative would be to discard the software state and trust the
hardware to be configured correctly. That's somewhat risky because we
don't know if the hardware is properly configured. Or Linux might have
different requirements from the firmware and hence needs to configure
the PWM differently.

Neither of the above are very attractive options. The best I've been
able to come up with so far is to completely remove this decision from
the PWM subsystem and let users handle this. That is, a PWM regulator
driver would have to have all the knowledge about how to configure the
PWM for its needs. So upon probe, the PWM regulator driver would inspect
the current state of the PWM and adjust if necessary, then apply again.
Ideally of course it wouldn't have to do anything because the hardware
PWM state would match the software configuration. The idea here is that
the PWM regulator driver knows exactly what duty cycle to configure to
obtain the desired output voltage.

That doesn't really get us closer, though. There is still the issue of
the user having to deal with two states: the current hardware state and
the software state as configured in DT or board files.

Like I said, I'm on the fence about this, so I'd appreciate any comments
and perhaps insight from user subsystem maintainers on how they'd like
this to look, or how this has been done with other resources (GPIOs,
...?)

Thierry

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWplajAAoJEN0jrNd/PrOhkdgQALXCnonwPjaHE7DOwDyNqWxo
yfWUp5ZNEJqRHqRzllNVh86bKlgCsyPDCvkmiZ+05pICxgvpeuyUAyP9TCpdb/iN
uXrbksTckTeE+IdKXGm4bbfNjj8z5NLeUdr/mP8S6fW35jiPZoThNQsZblHJSYdL
cMEb806nqeEMaixnxaNskOIQKQwf6mpIzCS4teKoxHBnCRZyromiPV0mfITKpya2
KRw/aKHx1sHu5mpDlGe4Hak+0EztdCpBe7OzfDEbj9JJY7HMQZr231yuj8NCyMFX
izFUB2wpFArzEt6fq1e6ntwp2qWUUcEW/Pn30gTe8vifa/0p3IQ7vRTvOot9xnRh
pY5achQTm6P6PX6udw4WuNd4ZmxorXQqrRZzmbfGYX7sX8dAib9uv+31iF5sRtlz
9IXsDJNnfY24vw4d4y15WzDqLKuNr1RRvsUu8yH8tdhJotqdT4Urhz9/CRTpeT9f
VUcZFVjBkwc1iudUnIkSDaxJAhEhsHru1oPJ5ze3fcAq5vEhbFXolMLwBTucBEEb
l8N3SQngoH1mzK19+NdO2VoMSxX/Tkim4cfQSGhpq4DDJld9bR8Sh10Yg4bBh/wC
MTxBvpiJJ4Q0Gt/IfsFJ0Iq6gK7oDsu2WyNXxQ/HcW6da+MkaQtff2PQeHz/hzT5
jPcMFc92PitQYcg8USve
=v8tN
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
