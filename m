From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: lpss: split driver to core and probe drivers
Date: Thu, 21 Aug 2014 08:43:06 +0200
Message-ID: <20140821064305.GD4486@ulmo>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140820101248.GH15414@ulmo>
 <1408557479.3270.8.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:61881 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbaHUGnK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Aug 2014 02:43:10 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so8881937wgh.32
        for <linux-pwm@vger.kernel.org>; Wed, 20 Aug 2014 23:43:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408557479.3270.8.camel@acox1-desk.ger.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2014 at 06:57:59PM +0100, Alan Cox wrote:
> On Wed, 2014-08-20 at 12:12 +0200, Thierry Reding wrote:
> > On Tue, Aug 19, 2014 at 07:17:34PM +0300, Andy Shevchenko wrote:
> > > This small series makes the architecture of pwm-lpss driver cleaner.
> > >=20
> > > Since v3:
> > > - rebased on top of recent linux-next
> > > - rebased on top of Alan's patch for Braswell
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
> > >  drivers/pwm/pwm-lpss-pci.c      |  65 +++++++++++++++++++
> > >  drivers/pwm/pwm-lpss-platform.c |  69 ++++++++++++++++++++
> > >  drivers/pwm/pwm-lpss.c          | 136 +++---------------------------=
----------
> > >  drivers/pwm/pwm-lpss.h          |  32 ++++++++++
> > >  6 files changed, 198 insertions(+), 127 deletions(-)
> > >  create mode 100644 drivers/pwm/pwm-lpss-pci.c
> > >  create mode 100644 drivers/pwm/pwm-lpss-platform.c
> > >  create mode 100644 drivers/pwm/pwm-lpss.h
> >=20
> > Yea or nay, Alan?
>=20
> Context ?

Back when the LPSS PWM driver was first submitted I suggested that it
could be split up in this way (core + PCI and ACPI/platform drivers).
You had objections to doing that. Now Andy's doing exactly that, so I
would like your Acked-by (or NAK) on this change.

Thierry

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9ZT5AAoJEN0jrNd/PrOhUMQP/A/rTDkLughld94/0eIF8kK3
yU56WdKo/wXIn+KqMkZf47f1KWUQ4ILsIwAtsqKGt5XHQ+HQ8ULp6wJO/jly5Aub
ZmtReAEmy/PHxjj89C5lhiyBPpU+urjrsEz8yndq0t/j2P97vunIoIh3iHWmmV2L
KFyD3HQHie7DQy0MMSZOd0aOIL9YGZRX2prB5ObtyCSRLX6SLx4l+2vUH5Iqp8Fh
zMqu2qIYx4xDvr+gEFEcDLJG5+Ue1eu3WGfTunNjzErfh4B0/jMjNs8QA8Q/GJ2K
s9lI6/0Y8OQrZ8CaB9vCkAx+B5PanJ2vhY3JXYoPnXaLppU2tiGC+SqQtE/WH+ci
7eMTTRgiCtUVNYtVAp3dmWmL/jhtDcwvDFZTOWZA3HdheniSL3g07RX/YtqnfqfI
3KPkuEltv48o814BxkNdDV0Di84izh5PJBEcy0WBdx5ZZLLVDYc8ln7nUE3RLwn5
97s/VRwKDZrcRp5hpWQsTozNx3s2lyDKtwT1c5rjce8+574nB1Vu98kOzOjeXvvW
6A0F7Y1bL88VhGNq/MTMEu0hKPnNXwxLkcKtNzWG7BtvV16bU7q6kXB/I6eY+TV2
uHF7gEVu0uzdrDCK1qjf5OppGmmhrbIVIkG68c8Vr3kiRhdXODlrlPnXnqE4zI2H
K/ANhlmJEicXZwf+3bH+
=uePj
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
