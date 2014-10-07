From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 10:59:32 +0100
Message-ID: <20141007095932.GY25331@lee--X1>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1>
 <20141007094727.GA12631@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35239 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbaJGJ7j (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:59:39 -0400
Received: by mail-ig0-f178.google.com with SMTP id l13so4376416iga.11
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 02:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141007094727.GA12631@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Tue, 07 Oct 2014, Thierry Reding wrote:

> On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> >=20
> > > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91=
sam9x5
> > > family or sama5d3 family) exposes 2 subdevices:
> > > - a display controller (controlled by a DRM driver)
> > > - a PWM chip
> > >=20
> > > The MFD device provides a regmap and several clocks (those connec=
ted
> > > to this hardware block) to its subdevices.
> > >=20
> > > This way concurrent accesses to the iomem range are handled by th=
e regmap
> > > framework, and each subdevice can safely access HLCDC registers.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.co=
m>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > ---
> > >  drivers/mfd/Kconfig             |   6 ++
> > >  drivers/mfd/Makefile            |   1 +
> > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++=
++++++++++++++
> > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++=
++
> > >  4 files changed, 214 insertions(+)
> > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> >=20
> > Applied for v3.19.
>=20
> Will you provide a stable branch that I can pull into the PWM tree?

I hadn't planned on it.  What do you need that for?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
