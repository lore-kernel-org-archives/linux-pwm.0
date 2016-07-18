From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Mon, 18 Jul 2016 09:49:28 +0100
Message-ID: <20160718084928.GA17074@dell>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36286 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcGRIsU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jul 2016 04:48:20 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so93960315wma.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jul 2016 01:48:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Fri, 15 Jul 2016, Brian Norris wrote:
> This is the 4th (and final?) version of my series to support the new =
ChromeOS
> EC PWM API, so we can control, e.g., a PWM backlight when its PWM is =
attached
> to the EC. It uses Boris's latest "atomic" hooks for the PWM API (i.e=
=2E, the
> ->apply() callback), which were recently merged.
>=20
> Pulled and adapted the cros_ec_cmd_xfer_status() helper from this pat=
ch, with
> some minor modifications:
>=20
> https://lkml.org/lkml/2016/4/12/342
>=20
> Note that after some style bikeshedding, I proposed to put off rewrit=
ing the
> entire cros_ec_commands.h header at the moment, due to the shared nat=
ure of
> this file. Follow up here:
>=20
> https://bugs.chromium.org/p/chromium/issues/detail?id=3D621123
>=20
> As this touches MFD (sort of), drivers/platform/chrome/, and drivers/=
pwm/, I'm
> still not sure who it should all go through: Lee, Thierry, or Olof?

I usually take this type of submission through the MFD tree, although
it's too late in the day to make it into v4.8.

Which Acks are you missing?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
