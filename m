From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 23:52:01 +0200
Message-ID: <20161020215200.GB2185@mithrandir.ba.sec>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
 <20161020130853.GA1785@archie.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32954 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756245AbcJTVwF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 17:52:05 -0400
Received: by mail-lf0-f51.google.com with SMTP id x79so112004035lff.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2016 14:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161020130853.GA1785@archie.localdomain>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 03:08:53PM +0200, Clemens Gruber wrote:
> On Thu, Oct 20, 2016 at 02:51:44PM +0200, Thierry Reding wrote:
> > I'm reluctant to add this to the PWM core because it's effectively
> > duplicating something for which a proper subsystem already exists.
> >=20
> > If adding pinmux is considered overkill, maybe doing so needs to be
> > simplified. Surely if this is applicable to more than one PWM controller
> > some helpers could be extracted to make it easier to add.
> >=20
> > But if it isn't generally useful I don't think it makes sense to add it
> > to the PWM core either. So I think our choices here are to register via
> > pinmux and in the process add helpers to make that easier (remove the
> > overkill) or to keep this to the driver until we start seeing a pattern
> > emerge.
>=20
> But the fact that this one pwm chip bypasses PWM control and acts as a
> GPO is an implementation detail of the chip, this feature is helpful for
> other PWM chips too, as long as they don't toggle.
> Would this really be a good fit in the pinmux subsystem?
>=20
> I really like the idea of Mika to add a gpio_set callback in pwm_ops and
> let the pwm core export a GPIO chip. For now we could add this callback
> only to the pwm-pca9685 driver but others could opt-in if needed.

I don't think it's as simple as that. There could be chips where only a
subset of PWM channels could act as a GPIO, or there could be any other
amount of quirks. A single callback is unlikely to cut it, so I think a
better alternative is to keep this in drivers until some patterns start
to emerge.

Thierry

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIbBAABCAAGBQJYCTx/AAoJEN0jrNd/PrOhb1YP90FNmSwM0PzWPOlR+ADXWxvK
pSTsNdXglSkcIOr7piRGs64FTh/UfZ005zPVervnLn/8r4C/gA66kDlw9bEJGoIC
lXoZyZsNwo1Ksj1XXDqhLulw0RnmAOQvTufwU9zfenNwZj/NxaptksdQHLilgULR
N2u25haJDk7LGwMBeVkkRDd4ubXAjah9yYmDsd9E4wchuSK9y6Do2GEdjNlK0GMu
X2WPBBNW4k3Fj+pcalldnGsQAVCNklNocJ9uPa93XAGY4sVjpwnt80L7qUIskemY
aEAqnrdAFxYgpBebklacVp0xHu+fm7T4B0PmmQO/TmM5CXwkzeE9qga479t70ZmB
zkPxJGVXa6n5fjMKElNHomuMMILQlzDn6Tq23geto+izPqlP3airEhZjp7PhOR/O
MOlPNunOiS/An5kCITvicXxWTPRPG9l25Daq/1kxdjBodaGNyK1HO816J4iKlwoT
7SC+rfaY94WdDFw9ZNby+IUc2K89gMsDvxG64mFLLZbKWrOQCawPPt71oW9Oz7X6
8I9jfq9q8khsJ5UOFhXYlbJk5sIM0nPFZVd8CDTb6GAaOMLPzAZo4mQcz8e4P+rp
NmUA0qo7o228t6aoMXiLckV4XshyWWet4T1vlnzqhxcUXMSXNig7dh4IusoWTUHn
xlZOoLYlE++qrym/Orc=
=B1Od
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
