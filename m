Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:63288
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfHGC4W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 22:56:22 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 7 Aug 2019 02:56:19 +0000
Message-ID: <OSBPR01MB4536907871FEDA8C89271360D8D40@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
 <20190806160007.mqwzixddhzejbmcb@pengutronix.de>
In-Reply-To: <20190806160007.mqwzixddhzejbmcb@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hello,

> From: Uwe Kleine-K=F6nig, Sent: Wednesday, August 7, 2019 1:00 AM
>=20
> Hello,
>=20
> On Tue, Aug 06, 2019 at 11:05:30AM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Since the rcar_pwm_apply() has already check whehter state->enabled
> > > is not set or not, this patch removes a redundant condition.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > This is completely independent from the rest of the series, and can be =
applied
> > immediately, right?
>=20
> The original patch didn't make it into my mailbox. I only see a few
> replies. Is it only me?
> https://patchwork.ozlabs.org/project/linux-pwm/list/ doesn't seem to
> have it either.

I don't know why but, linux-renesas-soc ML only got the patch series.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D14312=
9


JFYI, but I submitted another patch yesterday, and it seemed to be archived=
 on all MLs:
https://www.spinics.net/lists/stable/msg322085.html
https://lkml.org/lkml/2019/8/6/274
https://patchwork.kernel.org/patch/11078469/

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
