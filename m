From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 11:47:28 +0200
Message-ID: <20141007094727.GA12631@ulmo>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50331 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbaJGJrc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:47:32 -0400
Content-Disposition: inline
In-Reply-To: <20141007094427.GW25331@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> On Mon, 06 Oct 2014, Boris Brezillon wrote:
>=20
> > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
> > family or sama5d3 family) exposes 2 subdevices:
> > - a display controller (controlled by a DRM driver)
> > - a PWM chip
> >=20
> > The MFD device provides a regmap and several clocks (those connected
> > to this hardware block) to its subdevices.
> >=20
> > This way concurrent accesses to the iomem range are handled by the regm=
ap
> > framework, and each subdevice can safely access HLCDC registers.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/mfd/Kconfig             |   6 ++
> >  drivers/mfd/Makefile            |   1 +
> >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++++
> >  4 files changed, 214 insertions(+)
> >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
>=20
> Applied for v3.19.

Will you provide a stable branch that I can pull into the PWM tree?

Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM7avAAoJEN0jrNd/PrOhEqkQAIXdUJhVuKHDPwRfaEwUP1nk
M4LkzZO/Hv0uiFqnYSd7Ep2vmdAA8eh+MPw4dgv34V0Fe0jt9FPKRgeAGiMSZCnr
E+ix4XzOle4tTHVonfGA2qM8aVaqx7cSWOJXASIQow+6KCofa8zdqdg98EnuiW3f
wOO9bWUzup0o2yf/o9mzw5VFljqDnazUWdVPbDqY/QDNloo/617ctsrZyw175Pf0
FJ04FRNOIH5Ml9JzHffpbJ215703fUdlxz8sMpz1q3Wf4HZebIMM2V2AjLC65T15
2xxKjDi/etKmza6pmB3Ud9WAvP9dbmPrcGeGiKY6XCBemVMDcorVmxvJ0zUxm7OI
sleaYQ9O1Scp53c11BGGnRyJRak0XA0NLnS+44MocmV/ZxzxZJp9Ks2glnUu8Lqn
2bj3C57xfijVJ+xX3TDMN7YI672bCiG4qvYi1O1zSWEiAAzJRD7JHaGJvInVY/lU
maViMJP/qt4jKljFp3DKjCZiD1scrqhiQ1cpQReO0zIvrvcNBNTlil0NHyWZn2w/
jqRHkOhKOlAi7vmjmohVJu58FU8QmEti/jWZTtGvLKKTUbpDhbIewaujXrQjx3cz
4uxyNZ10kiU3ADMFO+ZxCLCVZvJ1eM4tKA8fvENsBnaPpgt9vXA+Li7Af69XhtiW
jz8zTjsIhIGyQdmJvozV
=0tDY
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
