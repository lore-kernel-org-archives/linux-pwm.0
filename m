Return-Path: <thierry.reding@gmail.com>
Date: Fri, 20 Sep 2013 09:58:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] PWM: PXA: add device tree support to PWM driver
Message-ID: <20130920075819.GC8575@ulmo>
References: <1379519982-7618-1-git-send-email-mikedunn@newsguy.com>
 <20130919122807.GH10852@ulmo>
 <523B2C0B.4050204@newsguy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <523B2C0B.4050204@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2013 at 09:53:31AM -0700, Mike Dunn wrote:
> On 09/19/2013 05:28 AM, Thierry Reding wrote:
> > On Wed, Sep 18, 2013 at 08:59:42AM -0700, Mike Dunn wrote:
> > [...]
> >> Only an OF match table is added;
> > [...]
> >=20
> > That's no longer true. You also add a custom .of_xlate() function.
>=20
>=20
> Is it acceptable to re-word the commit message in susbequent versions?

Yes, of course. The commit message should be an accurate description of
the patch. If as a result of review the patch changes in ways that make
the commit message wrong, then it must be updated as well.

> >> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.=
dtsi
> >=20
> > I think this belongs in a separate patch so it can go through the
> > arm-soc tree.
>=20
>=20
> Is there anyone else or another list that should be CC'd in this case?  T=
hanks.

Well, the PXA maintainers would be the most likely to take the dtsi
change through their tree. Usually the mach trees are merged into
arm-soc, which then goes into Linus' tree.

> >> +{
> >> +	struct pwm_device *pwm;
> >> +
> >=20
> > You probably want to check that pc->of_pwm_n_cells at least 1 here.
>=20
>=20
> Well OK, but I didn't bother because it's explicitly set to one elsewhere=
 in
> this source file.

Okay, nevermind. It's probably fine as is.

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPAAbAAoJEN0jrNd/PrOhAqIQAJ4D+83aWBs7hzIHEvrBBV5b
QdBw0wWlT53bEbieV7+9TbHdd8V0m3eX2xGKR5YLIj7Un+Huq00NzQG95TNeeuv5
an0hCPrxScVtZsYL1R+ZTb1qj5VwqF2SXEzqNWo3iJXvNTbzyclp1MRhJy85oq8Z
GzHgeTqjAMTsFaehq/V3KnoNHadgSyJteMiMzF/jipjfMmGVIjnW0RPKgLE0Cq0n
HkLEn/t2rhDY+8e/Ko9lc0TJ4eC8FIooujtLwyHJDGdCR0wzSSkBjP9VQbB2+r9+
vXUQMYyBr3k37ZMeX/BVtyF1dcGJNw+DnxKvJEFRPeqsAuTxHT2fRM829uI5Hqco
HG4yYHoSgaz1WCo1nBW2B2UlE04djObgEQZvappwHQtlsU7YYvhLm9dwEZPc8WAY
57Oqk8xGu2VeLsK6etKaFb+btogSU+fYsfOcXIv3x4acZpXKypOrPECLcC/PxgXk
LMeCyXUWX9flmGhM9ifblvNxMKrp05EvUb5m+XRKCGE7iKkNpoHt7dwbvI1vBfSM
4CeQUvWlPbknylFcYgCW1QjxxfM2b6fL0mKn8X2wxbxqVLuQZqcksoj06Z3yGZjq
P7Zu42/ptp/I/sEzxWPRzGVWsEwfDRHKlPEnZGmVaRlm4CyXoDywCiW4kTjkM0nk
3wneaCtaHEVZOJJWCPGz
=MRM1
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
