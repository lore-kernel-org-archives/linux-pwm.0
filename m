From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 14:51:44 +0200
Message-ID: <20161020125144.GA24653@ulmo.ba.sec>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35242 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbcJTMvt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 08:51:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so5540682pfj.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2016 05:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161020111844.GB24289@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 02:18:44PM +0300, Mika Westerberg wrote:
> On Thu, Oct 20, 2016 at 12:45:41PM +0200, Thierry Reding wrote:
> > On Wed, Oct 19, 2016 at 09:56:38PM +0300, Mika Westerberg wrote:
> > > On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> > > > The PCA9685 controller has full on/off bit for each PWM channel. Se=
tting
> > > > this bit bypasses the PWM control and the line works just as it wou=
ld be a
> > > > GPIO. Furthermore in Intel Galileo it is actually used as GPIO outp=
ut for
> > > > discreet muxes on the board.
> > > >=20
> > > > This patch adds GPIO output only support for the driver so that we =
can
> > > > control the muxes on Galileo using standard GPIO interfaces availab=
le in
> > > > the kernel. GPIO and PWM functionality is exclusive so only one can=
 be
> > > > active at a time on a single PWM channel.
> > > >=20
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >=20
> > > Thierry,
> > >=20
> > > Any comments on this?
> >=20
> > It seems to me like maybe pinmux would be a better framework to handle
> > this kind of use case. The full on/off bit sounds like it's a mux that
> > selects between GPIO and PWM functionality.
> >=20
> > Have you thought about supporting pinmux for this?
>=20
> Adding a full pinmux just for this sounds a bit overkill if you ask me.
>=20
> How about adding that ->gpio_set() callback in pwm_ops and let the PWM
> core to export a GPIO chip in that case? That would support also other
> PWMs having similar full on/off capability without the need to add a new
> pinmux driver for each.

I'm reluctant to add this to the PWM core because it's effectively
duplicating something for which a proper subsystem already exists.

If adding pinmux is considered overkill, maybe doing so needs to be
simplified. Surely if this is applicable to more than one PWM controller
some helpers could be extracted to make it easier to add.

But if it isn't generally useful I don't think it makes sense to add it
to the PWM core either. So I think our choices here are to register via
pinmux and in the process add helpers to make that easier (remove the
overkill) or to keep this to the driver until we start seeing a pattern
emerge.

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCL3eAAoJEN0jrNd/PrOhIjgP/2gJ7+u5yWlR/OBAN6LaST/d
ThSeQ4/OC2DpKKcLwJJBrdTTRvFlppbLM5vm66CHKHtvi7qDz/RL2JIYRQ02NzCZ
iRPEw+ai1J/u4OCahbccgJIVh7GVhowUMm6H8U4HpzhGsRZPSVI6N/Unp2Kkk18O
5NLuh6t4SUEmsBRMQCz46rAaHfov0RORDMxCoGJsxU0CcLgbY6Z/6e6aUkegGyMC
Q9K92JjqtnY6VDq+IaUyifp2m+YZcZpgat0/t5o7ejy//a7iwf06wBDODyp4CNAv
QyWr8rFmay2S9frHq1852IpLSgC8TkhVRv79baECHu2RIxaYSXLEcwMYm5dXVztV
1fqkcCgxCPlIasU7zCjtnf/J9HM5JAlqJlgtuQMcIbYRJPZKMfR8ciytIcYwKpEi
V+gn/KXh5SocM39JBfAc+UXevBF/9cBk877BhpTZkdWQsADOxB5EOs49uoAo1fIS
1FRUcxKq5a12nPhzB6P9XjsLNFCJ16RXXXyfZwLBn9+M1fsEIP8YrGvkqrmdRx+e
k8kZr4DeOAkHm4F6PODPngxUX7UYtviw+/RxQrl/jznqOHoUYBrI2UxPwT7GRH8u
w8XKiU51zR2em/0/Sb7ydv1701y6sxDxpydh9s5N81oX/n+XeieytfQseHv7h5eN
CpguZuEYONQZcevi1TNS
=IVLw
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
