From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/2] pwm: lpss: split driver to core and probe drivers
Date: Tue, 29 Jul 2014 12:10:24 +0200
Message-ID: <20140729101022.GA21182@ulmo.nvidia.com>
References: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140728152954.GA10126@ulmo.nvidia.com>
 <1406624231.8530.55.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49409 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbaG2KKa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jul 2014 06:10:30 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so11447399pdj.14
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2014 03:10:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406624231.8530.55.camel@smile.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2014 at 11:57:11AM +0300, Andy Shevchenko wrote:
> On Mon, 2014-07-28 at 17:29 +0200, Thierry Reding wrote:
> > On Mon, Jul 28, 2014 at 06:03:10PM +0300, Andy Shevchenko wrote:
> > > This small series makes the architecture of pwm-lpss driver cleaner.
> > >=20
> > > Since v2:
> > > - fix one more typo in Kconfig (tested with one line removed in my co=
nfig now)
> > >=20
> > > Since v1:
> > > - hide struct definition in the core part
> > > - rename pwm-lpss-plat to pwm-lpss-platform
> > > - fix Kconfig dependencies and other typos
> > > - add Mika's Reviewed-by tag
> > > - fix spelling in the commit messages
> > >=20
> > > Andy Shevchenko (2):
> > >   pwm: lpss: properly split driver to parts
> > >   pwm: lpss: pci: move to use pcim_enable_device()
> > >=20
> > >  drivers/pwm/Kconfig             |  21 ++++++-
> > >  drivers/pwm/Makefile            |   2 +
> > >  drivers/pwm/pwm-lpss-pci.c      |  68 ++++++++++++++++++++++
> > >  drivers/pwm/pwm-lpss-platform.c |  61 ++++++++++++++++++++
> > >  drivers/pwm/pwm-lpss.c          | 125 ++----------------------------=
----------
> > >  drivers/pwm/pwm-lpss.h          |  29 ++++++++++
> > >  6 files changed, 186 insertions(+), 120 deletions(-)
> > >  create mode 100644 drivers/pwm/pwm-lpss-pci.c
> > >  create mode 100644 drivers/pwm/pwm-lpss-platform.c
> > >  create mode 100644 drivers/pwm/pwm-lpss.h
> >=20
> > I'd like an Acked-by from Alan on this since he had strong objections
> > when I requested exactly this a while back.
>=20
> Meanwhile he is in Cc list, could you share the link to the previous
> discussion?

See: http://patchwork.ozlabs.org/patch/339493/

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT13MOAAoJEN0jrNd/PrOhPA8P/0lw2E5bLOdYUQrkWgjrFuTU
AnC7CsmGgVbyRvXj7oII4VCqVUBmUoZK1pE/iNDV49Nycn/3wEPPb8GEgaEqIQjo
qxvdOi7GfgscOJ/pL/Uq9qEMgfz4hQvSICJIkPLVJwzm7E78SzHgQFaqdmWambPl
pUefteWQWEykZmDOXsdTMdEU7+xlY8dWvgNkK7jdXGRsg9jPF65FJOztoKAnLCB2
qOZ55SyrucybUZArHXXOl0W1GjqvgOyb4Q3w/BZh3xU9TrDXSaUPTe0G8UocN3i0
zt27dLXH3y/8HNhX4AtGG7FFx3GB+ikSmYB7309g1MEfn6fn+RgKBC8cQ8WalZIF
bsoNUllUrekQlM7asyWt7KkmRdGcSotEPOgD9DlB1mwdlK/8Buku0zKq1wiGwenD
l1k6ZdV5BmpG8eWf6ig2NvqDWsYGUJjX573fuYgTzp/h/XASyG2+scLhcyjrW7EI
dkrfMBhZ2EXOTFCnueVEDPcaMoKJoD62GZZsWTCvMDH7VhvaKXvU79Kt1/9oKHbj
u//TVNiuHzj7T+gRpgw6zAcIGCwJdbKMCI+GwuZCBOHL3ZZeUN/qk8ID5VJpcp8q
jiv9OXABQtm+7swCJj68wsF7R3ugl4m09NbKvPQ2BKhZ7gHWVdTgbn5TJss8yHWx
TJ2C87ghYikrh8V/uPFX
=H0ZR
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
