From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm:lpss: update pwm setting for Broxton
Date: Thu, 12 Nov 2015 17:29:39 +0100
Message-ID: <20151112162939.GD3913@ulmo>
References: <1447345684-108039-1-git-send-email-qipeng.zha@intel.com>
 <20151112125236.GD31671@ulmo>
 <20151112145025.GP1509@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33185 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbbKLQ3m (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2015 11:29:42 -0500
Received: by wmec201 with SMTP id c201so41667600wme.0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2015 08:29:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151112145025.GP1509@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@intel.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 04:50:25PM +0200, Mika Westerberg wrote:
> On Thu, Nov 12, 2015 at 01:52:36PM +0100, Thierry Reding wrote:
> > On Fri, Nov 13, 2015 at 12:28:04AM +0800, Qipeng Zha wrote:
> > > For Broxton PWM controller, base unit is defined as 8bit integer
> > > and 14bit fraction, so need to update base unit setting to output
> > > wave with right frequency.
> > > a) add scaler for each board setting;
> > > b) remove validity check of base unit for special board, let pwm
> > > user to handle this;
> > >=20
> > > Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> > > ---
> > >  drivers/pwm/pwm-lpss.c | 20 +++++++++++---------
> > >  drivers/pwm/pwm-lpss.h |  1 +
> > >  2 files changed, 12 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> > > index 2504410..5a907db 100644
> > > --- a/drivers/pwm/pwm-lpss.c
> > > +++ b/drivers/pwm/pwm-lpss.c
> > > @@ -14,6 +14,7 @@
> > >   */
> > > =20
> > >  #include <linux/io.h>
> > > +#include <linux/time.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pm_runtime.h>
> > > @@ -24,11 +25,9 @@
> > >  #define PWM_ENABLE			BIT(31)
> > >  #define PWM_SW_UPDATE			BIT(30)
> > >  #define PWM_BASE_UNIT_SHIFT		8
> > > -#define PWM_BASE_UNIT_MASK		0x00ffff00
> > > +#define PWM_BASE_UNIT_MASK		0x3fffff00
> >=20
> > Isn't this going to potentially write reserved bits on non-Broxton
> > platforms? Previously the upper 8 bits were masked out, but now only the
> > upper 2 bits are masked out. What about the other 6?
> >=20
> > Perhaps it'd be better to parameterize the mask in a way similar to the
> > scaler value?
>=20
> Or call the field "base_unit_bits" which holds 16 for BSW/BYT and 22 for
> BXT, and calculate both scaler and mask from that in pwm_lpss_config()?

Yeah, that should work as well.

> Actually I think we should make the driver private structure look like
> this:
>=20
> struct pwm_lpss_chip {
>         struct pwm_chip chip;
>         void __iomem *regs;
>         const struct pwm_lpss_boardinfo *info;
> };
>=20
> and then set ->info to point to the platform data in probe().
>=20
> pwm_lpss_config() can then refer lpwm->info->base_unit_bits and
> lpwm->info->clk_rate.

Yeah, that thought had crossed my mind as well. I would've probably
waited until a third field was copied from info to chip before
requesting that change, but since you already brought it up, feel free
to send a patch.

> > Also it's unclear to me how critical this is. Initial patches for
> > Broxton support were merged into Linus' tree yesterday. Presumably they
> > had received some testing before, but nobody can't have noticed or this
> > bug wouldn't exist in the patches that were merged. Does this break any
> > existing setups and hence should go into v4.4 along with the initial
> > Broxton support?
>=20
> Nobody outside Intel should have Broxtons yet so it should not break any
> existing users.

Okay.

Thierry

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWRL5zAAoJEN0jrNd/PrOhmX8P/R0ObA+3C0BwEeooa8c7vgfW
pSv16uPWtrYlmYjru7dzRj8iHjUo/mTXKTCSnsruQMjgct3b/4GHoJLgPnxSrO8c
vawxV9rOPwE+AoqX7q/hfWbnzO8wbwvTOFZ+KPAYALEbLLsjQDtYmvJzMH0k3nEW
Tr3c0kOU85gkqrWbeecBfVlpONxsr0UTwWzKqMPZ4fB+0/85eKaSLhpK0b0Syomv
A6EjZQrp5cxa2/q2SpULVBZTK8wutcxDebhtl+dW31SqrDcw2iGrvhaW9FNkQl/M
s6xc4Q7ZbMrKJ7F8bFFC0AtvW/WuhLQz6SCN1OwCH2v8dJZ9/nDGbtqjFADCoZCR
SdhmA/te0N8ki5v4cbDbCYHQRN91eDFySB+bQXH7EY503SB3zJLpSUCtWbh7DrjR
zl1DykxGPAxFNepM7N6D810ceKrxDS+QbiV1C+OnmfKy/5a/l3nslfFIcXpc8rNl
ktuJz8IJMgpRcjD5gfHd5Y2v9fVrV7pB1N0Yizs4d/xXMcS84Atenikeu2jBIv+X
VU6xy73psOJjk0ALwlY+A0dG07B6yk9rKd1xQ9JD/d+L7P/EDpyQZRHtQpHYrAjU
mUVt5+ipn3IGa4uqF35qsPnhulNvUF+0SFf9Qc4S9MGk2qcDS5k9bH+6EzGVPkSj
88i2SlVLUkiOmexAahzI
=1Nk0
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
