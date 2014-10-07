From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 13:13:05 +0200
Message-ID: <20141007111304.GA1539@ulmo>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1>
 <20141007094727.GA12631@ulmo>
 <20141007095932.GY25331@lee--X1>
 <20141007100632.GA31575@ulmo>
 <20141007101743.GA25331@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49174 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbaJGLNJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 07:13:09 -0400
Content-Disposition: inline
In-Reply-To: <20141007101743.GA25331@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 11:17:43AM +0100, Lee Jones wrote:
> On Tue, 07 Oct 2014, Thierry Reding wrote:
>=20
> > On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
> > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > >=20
> > > > On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> > > > > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> > > > >=20
> > > > > > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at=
91sam9x5
> > > > > > family or sama5d3 family) exposes 2 subdevices:
> > > > > > - a display controller (controlled by a DRM driver)
> > > > > > - a PWM chip
> > > > > >=20
> > > > > > The MFD device provides a regmap and several clocks (those conn=
ected
> > > > > > to this hardware block) to its subdevices.
> > > > > >=20
> > > > > > This way concurrent accesses to the iomem range are handled by =
the regmap
> > > > > > framework, and each subdevice can safely access HLCDC registers.
> > > > > >=20
> > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.=
com>
> > > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > > > > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > > > ---
> > > > > >  drivers/mfd/Kconfig             |   6 ++
> > > > > >  drivers/mfd/Makefile            |   1 +
> > > > > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++=
++++
> > > > > >  4 files changed, 214 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > > > > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> > > > >=20
> > > > > Applied for v3.19.
> > > >=20
> > > > Will you provide a stable branch that I can pull into the PWM tree?
> > >=20
> > > I hadn't planned on it.  What do you need that for?
> >=20
> > Because the PWM driver depends on this series. But if you prefer you
> > could also take the PWM driver through your tree.
>=20
> Probably better to deal with that via Kconfig.

Do you have any suggestions? The PWM driver currently selects the
MFD_ATMEL_HLCDC symbol, which as I understand will cause a Kconfig error
if the latter isn't defined.

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM8rAAAoJEN0jrNd/PrOhQZkP/RXPwINHKWfSbPyP2G0p31KG
EWr7vk17bEjzBOm6UzeP5AVmi8p2wzBP+i7ggk9ZfEwPfS8fSwDJDrBS+haK4opI
dHRadkjcqQrIoGOHg69Zhz3EtINQspL1WLbZMRoG+zLXjBIynor7c3clgYUDE/NT
2qC7IYXKGIs+HonCpU5zfdFUiDA6I+Nd+9sQvqj2WICZecVEITYPTtCLOLOVQr5Y
2TLu8NJoalh/gFs0swySNa4sqC703qm7EdavjKiyOQ+gB8+mcQ6OABjYW63Hsf++
6xvo2kGxQweI0Wg9deCGVfdVht0FIWZE9vWgzkq5WlX+Xx9l3xqtiKQEgrxynIRO
SXoodQkhZZFEZQCXX15B3KA7eFSU037bWW2BtIEbiBSrFBZEApXIcKGWQNaLAnSn
HP0OTlRcSu5RsCeBHRy1mQesg+4irc8Q2Gb6LwEvg/Wzk1ymuF/8jt3E4pqleKH5
gWHGr/utP5w1dos453r0y2BCZaScTN14uLoAJMgUxn2F7+JROFXKcla/3JqZdTrb
QzYRYeifdziiW4LLzeFiAnBXwrTvGi/Kwx+ECNy0Gg1SDcCGTLuPF5eJ7goQ3z5J
yLoY3DIlKdgJYwcZatqFGUjUElbAZdWybjhH1AXnYRohr90ylcLwNkYVH0t2hc88
5orUuZPeHS5bpf3d/bUw
=lVbT
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
