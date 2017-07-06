From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us
 property
Date: Thu, 6 Jul 2017 11:55:01 +0200
Message-ID: <20170706095501.GA8690@amd>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
 <20170706080132.GL16144@ulmo.fritz.box>
 <20170706091231.GA6741@amd>
 <ac8bd991-be3c-c090-8e71-8f901b0a45a7@linaro.org>
 <20170706092448.GQ16144@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706092448.GQ16144@ulmo.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu 2017-07-06 11:24:48, Thierry Reding wrote:
> On Thu, Jul 06, 2017 at 10:17:18AM +0100, Daniel Thompson wrote:
> > On 06/07/17 10:12, Pavel Machek wrote:
> > > On Thu 2017-07-06 10:01:32, Thierry Reding wrote:
> > > > On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wr=
ote:
> > > > > From: huang lin <hl@rock-chips.com>
> > > > >=20
> > > > > Some panels (i.e. N116BGE-L41), in their power sequence specifica=
tions,
> > > > > request a delay between set the PWM signal and enable the backlig=
ht and
> > > > > between clear the PWM signal and disable the backlight. Add suppo=
rt for
> > > > > the new pwm-delay-us property to meet the timing.
> > > > >=20
> > > > > Note that this patch inverts current sequence. Before this patch =
the
> > > > > enable signal was set before the PWM signal and vice-versa on pow=
er off.
> > > > >=20
> > > > > I assumed that this sequence was wrong, at least it is on differe=
nt panel
> > > > > datasheets that I checked, so I inverted the sequence to follow:
> > > > >=20
> > > > >    On power on, set the PWM signal, wait, and set the LED_EN sign=
al.
> > > > >    On power off, clear the LED_EN signal, wait, and stop the PWM =
signal.
> > > >=20
> > > > I think this should be two separate patches to make it easier to re=
vert
> > > > the inverted sequence should it prove to regress on other panels.
> > >=20
> > > Don't make this overly complex. This is trivial. No need to split it
> > > into more patches.
> >=20
> > Agree. IMHO getting the code that reads the (optional) new parameter co=
rrect
> > is the best way to manage risk of regression since in most cases the de=
lay
> > will be skipped anyway.
>=20
> The potential regression that I'm referring to would be caused by
> inversing the sequence (GPIO enable -> PWM enable). That's completely
> unrelated to the delays introduced by this patch. Many boards use this
> driver and they've been running with the old sequence for many years.
> Granted, it's fairly unlikely to regress, but it's still a
> possibility.
>=20
> Given that both changes are logically separate, I think separate patches
> are totally appropriate. I also don't think that this would overly
> complicate things.

Ah, yes, you are right; should be two patches.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlleCPUACgkQMOfwapXb+vKMQQCgoxZkgvVQdmYUuMs+3XKcnbOL
hTEAn3kRTtDk0Kcyd7EUAOqFiaGxUeb+
=w4Mb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
