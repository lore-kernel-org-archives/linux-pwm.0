From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/4] pwm: lpss: Do not export board infos for
 different PWM types
Date: Fri, 20 Jan 2017 12:18:45 +0100
Message-ID: <20170120111845.GA20470@ulmo.ba.sec>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
 <20170118111109.GO18989@ulmo.ba.sec>
 <20170118130138.GO2023@lahna.fi.intel.com>
 <20170120110051.GJ3824@ulmo.ba.sec>
 <20170120111529.GH17297@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33141 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdATLTH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2017 06:19:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so5962287wme.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2017 03:18:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170120111529.GH17297@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 01:15:29PM +0200, Mika Westerberg wrote:
> On Fri, Jan 20, 2017 at 12:00:51PM +0100, Thierry Reding wrote:
> > On Wed, Jan 18, 2017 at 03:01:38PM +0200, Mika Westerberg wrote:
> > > On Wed, Jan 18, 2017 at 12:11:09PM +0100, Thierry Reding wrote:
> > > > On Mon, Jan 02, 2017 at 11:16:46AM +0200, Andy Shevchenko wrote:
> > > > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > >=20
> > > > > The PWM LPSS probe drivers just pass a pointer to the exported bo=
ard info
> > > > > structures to pwm_lpss_probe() based on device PCI or ACPI ID. Si=
nce the
> > > > > core driver knows everything else except mapping between device I=
D and the
> > > > > type, just pass the type with pwm_lpss_probe() and stop exporting=
 the board
> > > > > info structures.
> > > > >=20
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
> > > > >  drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
> > > > >  drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++-----=
--------------
> > > > >  drivers/pwm/pwm-lpss.h          | 14 +++++-------
> > > > >  4 files changed, 44 insertions(+), 49 deletions(-)
> > > >=20
> > > > Is there anything in particular that you think will need this chang=
e? It
> > > > looks to me more like churn than anything else. Moving away from th=
e per
> > > > device struct to describe the particular instance seems to me like
> > > > removing flexibility that we might want at some point rather than a=
ny
> > > > real gain.
> > >=20
> > > It simplifies the probe drivers for one. Since the core driver already
> > > handles details of the specific SoC family, I don't think we need the
> > > flexibility to be able to pass arbitrary platform data anyway.
> > >=20
> > > No strong feelings, though. I'm fine either way :)
> >=20
> > The current driver uses a strange inversion of the abstraction layer.
> > For one we have a "board info" structure that is supposed to describe
> > the variants of the hardware that exist. That data is in the core
> > driver, for reasons that I no longer remember, and then the PCI and
> > ACPI drivers reference those info structures depending on the type of
> > hardware they bind to. And worse, we now have to export symbols to
> > the PCI and ACPI drivers to make use of them.
> >=20
> > I think this is the wrong way around. The core would ideally be unaware
> > of any particular variants and use only the struct pwm_lpss_boardinfo.
> > It would then be up to the ACPI and PCI drivers to provide the variants
> > they need.
> >=20
> > Perhaps the only reason why the board info structures are in the core
> > driver is because the same variant exists as PCI and ACPI devices, so
> > putting them in the core removes potential duplication.
>=20
> Yes, I think that was the reason.
>=20
> > What I'm saying is that its wrong to have board specific bits in the
> > core driver. Duplicating the board info isn't a very attractive
> > alternative either, though, so it's not going to be elegant either way.
>=20
> Agreed.
>=20
> I think we can drop this patch then and make another that moves the
> exported information to both ACPI and PCI drivers (instead of exporting
> it from the core driver). That adds some duplication but then keeps the
> core driver clean from SoC specific quirks.
>=20
> Does that work for you?

Yeah, that works for me. It's not ideal, but I think it's the lesser of
two evils.

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB8hIACgkQ3SOs138+
s6EiiRAAwDwFVsHB4c43cTonw4mqVjewHRUGHnZP5IvC+UHoN3Ccy56U6G6qc77Z
nv4PwjKs5IXIIgIMfEGS5u1o/PrdFqZj76i/5drhyT4OZzpj+h9QQYLi1u7JIIqJ
niZMvD3RgKhHkcOL2JdjSj7ALWvh/HuGD41bztg2g5i+WEMquO4/urYADn5wCmbh
SPWwoNDJKCef9bDzpviIxfwpeKwcuL6gzVizbwWxV5YD8bGAm0n0f0dUq/O/Vi9a
al0fk0XLQweZalHLLYtGV7CU9ZqpMoAvZKLFFufOgBLIMVHm95zY8ISsTih5P0Y7
P2ou+rp9JBBNloMCCQcIj3HQ7XAk6aJkqU3b55VqngKnE48h1YjBxe1Z3KRBuD10
5C5tr7jSv1IfQHAwGOuS+9qSwjL8MTSscatGBtp4gbg/99z9+9iKYSH1gkZ9PY00
/JrlfEpw+lYYdYFFAogCp3Hjlb8kQw2PhW/l7/rf8/QrDpfjReKM/HWFDUeprOtQ
1zrHz0uEEUyLNdk0OqCYNR/0AErMTy337brBBYtX0go6N+kAZnvpR7OF0Xto8O9w
iCAqcX8eoX+cIz5aJLzxOrRw8B76bW94X4A1hP/o7OCQZ5AO0YAdn+rl7TWKoXQ3
17ed3C6/0RkYUDFp/2YWtAnvDqeiBW4ckXz/ZeW8otyyLS7sPEI=
=Cqpm
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
