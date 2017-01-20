From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/4] pwm: lpss: Do not export board infos for
 different PWM types
Date: Fri, 20 Jan 2017 12:00:51 +0100
Message-ID: <20170120110051.GJ3824@ulmo.ba.sec>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
 <20170118111109.GO18989@ulmo.ba.sec>
 <20170118130138.GO2023@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34286 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdATLHG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2017 06:07:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so5849273wmi.1
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2017 03:07:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170118130138.GO2023@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 03:01:38PM +0200, Mika Westerberg wrote:
> On Wed, Jan 18, 2017 at 12:11:09PM +0100, Thierry Reding wrote:
> > On Mon, Jan 02, 2017 at 11:16:46AM +0200, Andy Shevchenko wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >=20
> > > The PWM LPSS probe drivers just pass a pointer to the exported board =
info
> > > structures to pwm_lpss_probe() based on device PCI or ACPI ID. Since =
the
> > > core driver knows everything else except mapping between device ID an=
d the
> > > type, just pass the type with pwm_lpss_probe() and stop exporting the=
 board
> > > info structures.
> > >=20
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
> > >  drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
> > >  drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++---------=
----------
> > >  drivers/pwm/pwm-lpss.h          | 14 +++++-------
> > >  4 files changed, 44 insertions(+), 49 deletions(-)
> >=20
> > Is there anything in particular that you think will need this change? It
> > looks to me more like churn than anything else. Moving away from the per
> > device struct to describe the particular instance seems to me like
> > removing flexibility that we might want at some point rather than any
> > real gain.
>=20
> It simplifies the probe drivers for one. Since the core driver already
> handles details of the specific SoC family, I don't think we need the
> flexibility to be able to pass arbitrary platform data anyway.
>=20
> No strong feelings, though. I'm fine either way :)

The current driver uses a strange inversion of the abstraction layer.
For one we have a "board info" structure that is supposed to describe
the variants of the hardware that exist. That data is in the core
driver, for reasons that I no longer remember, and then the PCI and
ACPI drivers reference those info structures depending on the type of
hardware they bind to. And worse, we now have to export symbols to
the PCI and ACPI drivers to make use of them.

I think this is the wrong way around. The core would ideally be unaware
of any particular variants and use only the struct pwm_lpss_boardinfo.
It would then be up to the ACPI and PCI drivers to provide the variants
they need.

Perhaps the only reason why the board info structures are in the core
driver is because the same variant exists as PCI and ACPI devices, so
putting them in the core removes potential duplication.

What I'm saying is that its wrong to have board specific bits in the
core driver. Duplicating the board info isn't a very attractive
alternative either, though, so it's not going to be elegant either way.

Thierry

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB7eAACgkQ3SOs138+
s6F3qxAAnxrqH2xdrjuHdYh0+J47nsXPe1md7pHSHwxMgkoVAU8KBApoGlki2+1y
WSqXXt1mjVw7U+GDbBFzgb7c0B9ENmX2Pfo/fRfp+lf+7tMg83FuNvlcUXLkm1l/
N2QPPTC6hISf1hzZQIzb2s3LM/Zct4UMFTzYGXb3q6CzBFZXuBpEyNqPzpdPibUM
PCkHTD1NGZc29Tplvbb0G/+yZdXMJtrZsxiKwfTywDWNHJ5KRY7lbgaq/dwp/gaL
rE6KyFM/cb6TIf1f452lcuhtbgncUn0R9cWYK85k4pYAwuBltvkAmrEGf47ImWIo
1XxBzLcyoekMuv/ewiJdD2BqUX/GXlbznWi/7qwBW4tbdsdC93I2/KHapiWTxJsv
tNLWRD6dV2cRWO5E/QMNtpHntcmfTRzFzvDv1R3cosmdO8TiFGgiDcFoYaJUvoMN
xCTKyQaSn4FAsv+pnArHa8BJotdq1vGcZRvcZYqkOez2vn/3uMeDlyoKNe4ktKje
wQHusYkEcH0hMgU5Qy48oD7g3Owv/L8FInOGyxUR4n7Sl6nfB5ns8S8vZ603HEjB
fA9A8zbyxaur8y1BjqULPE2PvlmUvBypkqBAGuHod8FtR5qyYh2ODQWjpb5xy1DI
DFeRNdctEfW1u48XeDR9/f7gEMyZ//YzL+okMaClO5+dMKsDF4w=
=2GPJ
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
