From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Wed, 18 Mar 2020 23:59:53 +0100
Message-ID: <20200318225953.GA2874972@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37657 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRW76 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 18:59:58 -0400
Content-Disposition: inline
In-Reply-To: <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nicolas Ferre <nicolas.f>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > Rename it to PWM_POLARITY_INVERTED.
> >=20
> > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > spellings are correct.
>=20
> Some time ago I stumbled about "inversed", too. My spell checker doesn't
> know it and I checked some dictionaries and none of them knew that word:
>=20
> https://www.lexico.com/search?utf8=3D%E2%9C%93&filter=3Ddictionary&dictio=
nary=3Den&query=3Dinversed
> https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> https://dictionary.cambridge.org/spellcheck/english-german/?q=3Dinversed
>=20
> https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a verb
> having "inversed" as past participle.

Here are the first three results from a Google query:

	https://www.yourdictionary.com/inversed
	https://www.dictionary.com/browse/inversed
	https://en.wiktionary.org/wiki/inversed

> Having said this I think (independent of the question if "inversed"
> exists) using two similar terms for the same thing just results in
> confusion. I hit that in the past already and I like it being addressed.

I don't know. It's pretty common to use different words for the same
thing. They're called synonyms.

> > And as you noted in the cover letter, there's a conflict between the
> > macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> > in the wrong order you'll get a compile error.
>=20
> There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> first to come to my mind). I'm not aware of any problems related to
> these. What am I missing?

There's currently no problem, obviously. But if for some reason the
include files end up being included in a different order (i.e. the
dt-bindings header is included before linux/pwm.h) then the macro will
be evaluated and result in something like:

	enum pwm_polarity {
		PWM_POLARITY_NORMAL,
		1,
	};

and that's not valid C, so will cause a build error.

> > The enum was named this way on purpose to make it separate from the
> > definition for the DT bindings.
>=20
> Then please let's make it different by picking a different prefix or
> something like that.

Again, seems to me like unnecessary churn. Feel free to propose
something, but I recall being in the same position at the time and this
was the best I could come up with.

> > Note that DT bindings are an ABI and can
> > never change, whereas the enum pwm_polarity is part of a Linux internal
> > API and doesn't have the same restrictions as an ABI.
>=20
> I thought only binary device trees (dtb) are supposed to be ABI.

Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
which basically makes it ABI as well. Yes, the symbol name may not be
part of the ABI, but changing the symbol becomes very inconvenient
because everyone that depends on it would have to change. Why bother?

My point is that enum pwm_polarity is an API in the kernel and hence its
easy to change or extend. But since that is not the same for the DTB, we
need to be careful what from the internal kernel API leaks into the DTB.
That's why they are different symbols, so that it is clear that what's
in dt-bindings/pwm/pwm.h is the ABI.

Thierry

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5yp+UACgkQ3SOs138+
s6FO/BAApA+hyvKBdtCzUbodbVNOnFlAivhVCo+N5zGSec6fjuALlAnGB/kYeWlt
XpSwooECx8G2j+mO9LmKjQi4ZmZxFGhO790xo3Q4CHNE+c/DNU0iP3cTXlJYhrAm
fBpMAsDBwuyrcJCuavVIDuM0okLAQ2XlmZFFT3WNCuC7NmmwkvVr0lJeg1/9lIsp
mivS6EuLEwXH0H03avpu3+o6+RAIKdO7jKegMHGQNWnBNg1bj+dCMvnKrxAKEjby
27HuFhm4cMsd5DQQE2RlB7iWZD1aLpk/S7n98LvGti8PiXAtfVzPjUhIXFrvJXi/
3A7ZwL7jHyaCmMMD3BJHa3/f3SlJMPU31ABixFS4R1t8LyLW4yw47jvZeznRqy8m
4EkQcdl5EQ4bdDyVOgyWTJTjuPLqahDFFjZGapLbvpM6nj9FTAX+PTDhAvi+QQ4F
XYkRpbO23Vw9bkE5hHNnD1lYMUgBE0WYTYZVgxEhVbV8Tte3qvnidjlEiNdVFznM
uYBZv0Ks0r5LAWq2EAwy6JlfzbfdP42dlj5ZRgqNqhTbybFhtwpZ1qhE/XfG0k4L
gfJt9ZXUHn81TWBrKoUC3YNbjJtTF2cl7l2JKft6+S3W93CV50lTzycJp/iy3srI
qigCThG2YlpsInS8ZEfww4p47i5+Uje0uHDaoT07uEukyjNAYkQ=
=Nsfz
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
