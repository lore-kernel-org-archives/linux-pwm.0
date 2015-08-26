From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm-backlight: Avoid backlight flicker when probed
 from DT
Date: Wed, 26 Aug 2015 12:58:56 +0100
Message-ID: <20150826115856.GY19409@x1>
References: <1438276973-20920-1-git-send-email-p.zabel@pengutronix.de>
 <1440580842.3190.26.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37343 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933097AbbHZL7D (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Aug 2015 07:59:03 -0400
Received: by widdq5 with SMTP id dq5so13061584wid.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Aug 2015 04:59:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440580842.3190.26.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de

On Wed, 26 Aug 2015, Philipp Zabel wrote:

> Hi Thierry, Jingoo, Lee,
>=20
> Am Donnerstag, den 30.07.2015, 19:22 +0200 schrieb Philipp Zabel:
> > If the driver is probed from the device tree, and there is a phandl=
e
> > property set on it, and the enable GPIO is already configured as ou=
tput,
> > and the backlight is currently disabled, keep it disabled.
> > If all these conditions are met, assume there will be some other dr=
iver
> > that can enable the backlight at the appropriate time.
>=20
> do you have any comments on this?
>=20
> This patch fixes premature backlight illumination issues for DT probe=
d
> devices with enable gpio or regulator without changing the behavior o=
f
> the non-DT case or DT cases where the enable gpio and regulator are k=
ept
> initially enabled or where no other device node points to the backlig=
ht
> via phandle.

I need Thierry's review to move forward on this.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
