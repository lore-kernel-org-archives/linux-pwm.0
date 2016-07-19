From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Tue, 19 Jul 2016 08:37:17 +0100
Message-ID: <20160719073717.GE17074@dell>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
 <20160718084928.GA17074@dell>
 <20160718091029.GA32259@ulmo.ba.sec>
 <20160718132426.GB17074@dell>
 <20160718140400.GA22297@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36958 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcGSHgJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jul 2016 03:36:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so15288128wmg.0
        for <linux-pwm@vger.kernel.org>; Tue, 19 Jul 2016 00:36:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160718140400.GA22297@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Mon, 18 Jul 2016, Thierry Reding wrote:

> On Mon, Jul 18, 2016 at 02:24:26PM +0100, Lee Jones wrote:
> > On Mon, 18 Jul 2016, Thierry Reding wrote:
> >=20
> > > On Mon, Jul 18, 2016 at 09:49:28AM +0100, Lee Jones wrote:
> > > > On Fri, 15 Jul 2016, Brian Norris wrote:
> > > > > This is the 4th (and final?) version of my series to support =
the new ChromeOS
> > > > > EC PWM API, so we can control, e.g., a PWM backlight when its=
 PWM is attached
> > > > > to the EC. It uses Boris's latest "atomic" hooks for the PWM =
API (i.e., the
> > > > > ->apply() callback), which were recently merged.
> > > > >=20
> > > > > Pulled and adapted the cros_ec_cmd_xfer_status() helper from =
this patch, with
> > > > > some minor modifications:
> > > > >=20
> > > > > https://lkml.org/lkml/2016/4/12/342
> > > > >=20
> > > > > Note that after some style bikeshedding, I proposed to put of=
f rewriting the
> > > > > entire cros_ec_commands.h header at the moment, due to the sh=
ared nature of
> > > > > this file. Follow up here:
> > > > >=20
> > > > > https://bugs.chromium.org/p/chromium/issues/detail?id=3D62112=
3
> > > > >=20
> > > > > As this touches MFD (sort of), drivers/platform/chrome/, and =
drivers/pwm/, I'm
> > > > > still not sure who it should all go through: Lee, Thierry, or=
 Olof?
> > > >=20
> > > > I usually take this type of submission through the MFD tree, al=
though
> > > > it's too late in the day to make it into v4.8.
> > > >=20
> > > > Which Acks are you missing?
> > >=20
> > > I'm willing to take this through the PWM tree if you're okay with=
 the
> > > MFD changes. I can put the MFD changes into a separate branch and=
 you
> > > could pull that in if you needed to resolve any dependencies, whi=
ch I
> > > think would be quite unlikely if you've already closed your tree.
> >=20
> > Are you saying that you're willing to take these straight into the
> > merge-window, with no soak in -next?
>=20
> There's still a bit of time to let it soak in -next, but I'm not over=
ly
> concerned given that this is purely additions of code, so there can't=
 be
> any regressions.

No problem my side then.  Apply away.

Before doing so, can you see if there are any clashes with my
mfd-for-next branch?  If conflicts occur, please construct an
immutable tag I can pull from.  That way, I can base my branch on it
and deal with the fallout myself.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
