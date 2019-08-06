Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfHFQAR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 12:00:17 -0400
Date: Tue, 6 Aug 2019 18:00:07 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190806160007.mqwzixddhzejbmcb@pengutronix.de>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hello,

On Tue, Aug 06, 2019 at 11:05:30AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Since the rcar_pwm_apply() has already check whehter state->enabled
> > is not set or not, this patch removes a redundant condition.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> This is completely independent from the rest of the series, and can be ap=
plied
> immediately, right?

The original patch didn't make it into my mailbox. I only see a few
replies. Is it only me?
https://patchwork.ozlabs.org/project/linux-pwm/list/ doesn't seem to
have it either.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
