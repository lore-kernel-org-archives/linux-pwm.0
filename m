From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 13:00:28 +0100
Message-ID: <20141007120028.GC3693@lee--X1>
References: <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1>
 <20141007094727.GA12631@ulmo>
 <20141007095932.GY25331@lee--X1>
 <20141007100632.GA31575@ulmo>
 <20141007101743.GA25331@lee--X1>
 <20141007111304.GA1539@ulmo>
 <20141007113814.GA3693@lee--X1>
 <20141007134112.40179e8a@bbrezillon>
 <20141007115928.GB3693@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:65223 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaJGMAg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 08:00:36 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so4029853igi.5
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 05:00:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141007115928.GB3693@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Tue, 07 Oct 2014, Lee Jones wrote:

> On Tue, 07 Oct 2014, Boris Brezillon wrote:
>=20
> > On Tue, 7 Oct 2014 12:38:14 +0100
> > Lee Jones <lee.jones@linaro.org> wrote:
> >=20
> > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > >=20
> > > > On Tue, Oct 07, 2014 at 11:17:43AM +0100, Lee Jones wrote:
> > > > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > > >=20
> > > > > > On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
> > > > > > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > > > > >=20
> > > > > > > > On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wro=
te:
> > > > > > > > > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> > > > > > > > >=20
> > > > > > > > > > The HLCDC IP available on some Atmel SoCs (i.e. at9=
1sam9n12, at91sam9x5
> > > > > > > > > > family or sama5d3 family) exposes 2 subdevices:
> > > > > > > > > > - a display controller (controlled by a DRM driver)
> > > > > > > > > > - a PWM chip
> > > > > > > > > >=20
> > > > > > > > > > The MFD device provides a regmap and several clocks=
 (those connected
> > > > > > > > > > to this hardware block) to its subdevices.
> > > > > > > > > >=20
> > > > > > > > > > This way concurrent accesses to the iomem range are=
 handled by the regmap
> > > > > > > > > > framework, and each subdevice can safely access HLC=
DC registers.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@fre=
e-electrons.com>
> > > > > > > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > > Tested-by: Anthony Harivel <anthony.harivel@emtrion=
=2Ede>
> > > > > > > > > > Tested-by: Ludovic Desroches <ludovic.desroches@atm=
el.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/mfd/Kconfig             |   6 ++
> > > > > > > > > >  drivers/mfd/Makefile            |   1 +
> > > > > > > > > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++=
++++++++++++++++++++++++++++
> > > > > > > > > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++=
++++++++++++++++
> > > > > > > > > >  4 files changed, 214 insertions(+)
> > > > > > > > > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > > > > > > > > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> > > > > > > > >=20
> > > > > > > > > Applied for v3.19.
> > > > > > > >=20
> > > > > > > > Will you provide a stable branch that I can pull into t=
he PWM tree?
> > > > > > >=20
> > > > > > > I hadn't planned on it.  What do you need that for?
> > > > > >=20
> > > > > > Because the PWM driver depends on this series. But if you p=
refer you
> > > > > > could also take the PWM driver through your tree.
> > > > >=20
> > > > > Probably better to deal with that via Kconfig.
> > > >=20
> > > > Do you have any suggestions? The PWM driver currently selects t=
he
> > > > MFD_ATMEL_HLCDC symbol, which as I understand will cause a Kcon=
fig error
> > > > if the latter isn't defined.
> > >=20
> > > s/select/depends on/ for the desired effect.
> > >=20
> >=20
> > Don't forget the atmel-hlcdc.h header file which is referenced by b=
oth
> > the DRM and the PWM drivers.

I should probably attempt to finish this sentence.

> If you use 'depends on' the DRM and PWM drivers won't even attempt to
> compile...

=2E.. if the MFD driver (and thus the header file) is not present.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
