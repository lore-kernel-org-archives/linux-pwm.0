From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Mon, 30 Mar 2020 16:14:36 +0200
Message-ID: <20200330141436.GG2431644@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200312064042.p7himm3odxjyzroi@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-pwm@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > Only the Timer control register(TCLR) cannot be updated when the timer
> > is running. Registers like Counter register(TCRR), loader register(TLDR=
),
> > match register(TMAR) can be updated when the counter is running. Since
> > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > timer for period/duty_cycle update.
>=20
> I'm not sure what is sensible here. Stopping the PWM for a short period
> is bad, but maybe emitting a wrong period isn't better. You can however
> optimise it if only one of period or duty_cycle changes.
>=20
> @Thierry, what is your position here? I tend to say a short stop is
> preferable.

It's not clear to me from the above description how exactly the device
behaves, but I suspect that it may latch the values in those registers
and only update the actual signal output once a period has finished. I
know of a couple of other devices that do that, so it wouldn't be
surprising.

Even if that was not the case, I think this is just the kind of thing
that we have to live with. Sometimes it just isn't possible to have all
supported devices adhere strictly to an API. So I think the best we can
do is have an API that loosely defines what's supposed to happen and
make a best effort to implement those semantics. If a device deviates
slightly from those expectations, we can always cross fingers and hope
that things still work. And it looks like they are.

So I think if Lokesh and Tony agree that this is the right thing to do
and have verified that things still work after this, that's about as
good as it's going to get.

I know this is perhaps cheating a little, or turning a blind eye, but I
don't know what the alternative would be. Do we want to tell people that
a given PWM controller can't be used if it doesn't work according to our
expectations? That's hard to argue if that controller works just fine
for all known use-cases.

Thierry

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B/soACgkQ3SOs138+
s6F2WxAAp3bIGtRCKqt67F7d3JG708w1+creHUOXONHOapSQCaWuU1SSJgI73p2P
AHdNHXR/YURCBKVTVrLizfkqAR6rQ1EE3ovlSuu5ZkaCMx1brw92l6MoVIHxlLQ1
XchiOycQgdI4BM03ENpihJi73/HHm30/SeAJ/pTgFMr3S0pr7iNvxI+AzLfiD0c/
7Y8tNjcDtMOesdLym/jMNelCxYovlQyB1gDYGPm65xrFb4cqWHuzuro1s71OqJzX
l3J9qYjcKF7XPNHze3Q75BP/wZc0+aztBja4N6ZqoR1nvkKLPAAuDBDPI87RD5LR
j4xBM/J7QSUhlh/anUfdbPxOx9YJswvfCswcifzIEwmzb7EOwpq2Yqh3BVyp4DoS
4027Z5g3sRwdR4OiNkTYHezpwp/qz1Wxrh9LWP8wqpoounrCYqTX5QDhiHSu9cr+
jfAaQGi0EgILeQjsAv3BqjoHnVjgMSVAtNV720U40J0MxkZKSf73Ak2/Jduk1dQv
j1jTJL+WYGZtFBBojS73HOkSHRk4sFNvab5iotVYaro8JaCTYGNWLohJvhG+bw5X
AfLthkohTXarCOkcHET4YI6PcDtzhU++HiCSfRZ+TBAiE5W2ZF5rKjFYCcBQuPCo
dnAbijxeDHJ33fRP905WbK6B+GhvcgyWIDI9mJxm3FhZf+1onT0=
=T9wd
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
