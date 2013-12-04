From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/4] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Wed, 4 Dec 2013 10:50:38 +0000
Message-ID: <20131204105038.GB907@lee--X1>
References: <1380082975-6022-1-git-send-email-milo.kim@ti.com>
 <20131204103431.GC26589@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:59626 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab3LDKup (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 05:50:45 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so9646158yho.10
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2013 02:50:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131204103431.GC26589@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

> > LP3943 is an integrated device capable of driving 16 output channel=
s.
> > It can be used for GPIO expander and PWM generators.
> > LP3493 registers are controlled via the I2C interface.
> >=20
> > This patch-set consists of four parts - MFD, GPIO, PWM and document=
s.
> >=20
> > Update from v3 to v4:
> >   Move the driver description from the documentation to the MFD dri=
ver file.
> >=20
> > Milo Kim (4):
> >   mfd: add LP3943 MFD driver
> >   gpio: add LP3943 I2C GPIO expander driver
> >   pwm: add LP3943 PWM driver
> >   Documentation: add LP3943 DT bindings and document
>=20
> I suspect that given the build-time dependencies Lee may want to take
> all four patches through the MFD tree, so I've acked the PWM parts.

Thanks Thierry.

Milo, would you mind re-sending the patch-set complete with
Thierry's Acks please? Also, can you send [PATCH 1/X]..[PATCH X/X] as
replies to [PATCH 0/X], as it aids greatly with status tracking.

Please see git send-email options:
  `--[no-]thread` and `--[no-]chain-reply-to`

=46or shallow threading, which is what I believe you want, you need:
  `--thread --no-chain-reply-to`

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
