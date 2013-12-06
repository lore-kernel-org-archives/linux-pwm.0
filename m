From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/4] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Fri, 6 Dec 2013 16:24:32 +0000
Message-ID: <20131206162432.GA11060@lee--X1>
References: <1380082975-6022-1-git-send-email-milo.kim@ti.com>
 <20131204103431.GC26589@ulmo.nvidia.com>
 <20131205214341.GC29268@sirena.org.uk>
 <20131206132405.GC30960@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43843 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab3LFQYh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Dec 2013 11:24:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so1019768oag.19
        for <linux-pwm@vger.kernel.org>; Fri, 06 Dec 2013 08:24:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131206132405.GC30960@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Milo Kim <milo.kim@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Fri, 06 Dec 2013, Thierry Reding wrote:

> On Thu, Dec 05, 2013 at 09:43:41PM +0000, Mark Brown wrote:
> > On Wed, Dec 04, 2013 at 11:34:32AM +0100, Thierry Reding wrote:
> > > On Wed, Sep 25, 2013 at 01:22:55PM +0900, Milo Kim wrote:
> >=20
> > > >   mfd: add LP3943 MFD driver
> > > >   gpio: add LP3943 I2C GPIO expander driver
> > > >   pwm: add LP3943 PWM driver
> > > >   Documentation: add LP3943 DT bindings and document
> >=20
> > > I suspect that given the build-time dependencies Lee may want to =
take
> > > all four patches through the MFD tree, so I've acked the PWM part=
s.
> >=20
> > FWIW this isn't an issue with new MFDs - since the function drivers=
 will
> > depend on the core driver it's not possible to enable them in Kconf=
ig
> > until the core driver is also merged and you don't get bisect issue=
s.
>=20
> Right. I hadn't thought about that. Thanks for mentioning it.

I have applied them all with the relevant Acks in any case.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
