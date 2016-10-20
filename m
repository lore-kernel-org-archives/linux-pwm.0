From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 23:50:11 +0200
Message-ID: <20161020215009.GA2185@mithrandir.ba.sec>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
 <20161020130117.GK24289@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35926 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754294AbcJTVuQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 17:50:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id b75so2556083lfg.3
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2016 14:50:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161020130117.GK24289@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 04:01:17PM +0300, Mika Westerberg wrote:
> On Thu, Oct 20, 2016 at 02:51:44PM +0200, Thierry Reding wrote:
> > On Thu, Oct 20, 2016 at 02:18:44PM +0300, Mika Westerberg wrote:
> > > On Thu, Oct 20, 2016 at 12:45:41PM +0200, Thierry Reding wrote:
> > > > On Wed, Oct 19, 2016 at 09:56:38PM +0300, Mika Westerberg wrote:
> > > > > On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> > > > > > The PCA9685 controller has full on/off bit for each PWM channel=
=2E Setting
> > > > > > this bit bypasses the PWM control and the line works just as it=
 would be a
> > > > > > GPIO. Furthermore in Intel Galileo it is actually used as GPIO =
output for
> > > > > > discreet muxes on the board.
> > > > > >=20
> > > > > > This patch adds GPIO output only support for the driver so that=
 we can
> > > > > > control the muxes on Galileo using standard GPIO interfaces ava=
ilable in
> > > > > > the kernel. GPIO and PWM functionality is exclusive so only one=
 can be
> > > > > > active at a time on a single PWM channel.
> > > > > >=20
> > > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > >=20
> > > > > Thierry,
> > > > >=20
> > > > > Any comments on this?
> > > >=20
> > > > It seems to me like maybe pinmux would be a better framework to han=
dle
> > > > this kind of use case. The full on/off bit sounds like it's a mux t=
hat
> > > > selects between GPIO and PWM functionality.
> > > >=20
> > > > Have you thought about supporting pinmux for this?
> > >=20
> > > Adding a full pinmux just for this sounds a bit overkill if you ask m=
e.
> > >=20
> > > How about adding that ->gpio_set() callback in pwm_ops and let the PWM
> > > core to export a GPIO chip in that case? That would support also other
> > > PWMs having similar full on/off capability without the need to add a =
new
> > > pinmux driver for each.
> >=20
> > I'm reluctant to add this to the PWM core because it's effectively
> > duplicating something for which a proper subsystem already exists.
>=20
> OK, I see.
>=20
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
> I would then go for keeping the code in this single driver for now and
> re-think this later if other drivers start to develop similar.

That's fine with me. I'll take a closer look at this patch and apply if
I don't find anything out of place.

Thierry

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCTwMAAoJEN0jrNd/PrOh5xUP/im2ohXnMSGYDDwTCMRYEYG6
eIQaFNc3zlDDudbbKM/AUZNrfYVxL3+gTxf5fJkgxa5/vzCleM7/pWsPAomqiFXu
OVJe8XEtsVI8NkwlmyxRj7A9MrbHZQVCg0YBxSqpH4FN4C/kwsAROLpHQvZOAoXt
BAGdfs2NtTD1GZMbft2R+fhbPxdvADDiV1Xue/H98QC3snhCagVxBE8tkQzRIoAn
8KDoRMDZCK/VJW8ghKi/5ZDqjko5bTnaRrjmUMJLdjUsZJksdPY9CJbSp5cGcylB
DaN5xfN2ZArA5eyUu9xxrgEqSY2Xk24NsmUvj/sktp/xiHQ4h+erTvCrqVVYg8z7
kcZefGTCk07HjhA6z7YH9yuPanJRxANooJKRE4d7cUiYUuihcvCjxyEQybHRDUZg
dtI8OHBMmOJNbSyCLKdPR1UBEBhFff+LXo0IYjruhLo0lkTtYvQKchU7C5bAQ9tR
4l2+L8d3GLPrU8hnzRfWb+0YFUEJ9LJ5s5q+g8MYaFWakDtEd/hq7Xuo3Ss8DWS6
jeDog8hI+IGz10Ot/eImYWPHGqx2jkDiasc8OI8lAfX/bFC5PY9GqRr/O4gX4sOe
Bh/0E5PcPcWg8V5I0oniDyn1+euVDKU0iVDOyosDvJrx7/h2xFOam5T1HS+ShfDN
K7/0vPwmUGrbT0uzAorq
=kcEJ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
