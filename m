From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Wed, 20 Dec 2017 11:15:02 +0000
Message-ID: <TY1PR06MB089500843CDCEE2D398C8540C00C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513690500-12165-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171220083137.63jj4rrkztguvvbm@verge.net.au>
 <TY1PR06MB08955E0D55B2712C6105A2F0C00C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20171220101223.kwnm7kpf7hssuxbc@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:54860 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754717AbdLTLPH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Dec 2017 06:15:07 -0500
In-Reply-To: <20171220101223.kwnm7kpf7hssuxbc@verge.net.au>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello Simon,

> Subject: Re: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] P=
WM bindings
>
> On Wed, Dec 20, 2017 at 09:54:14AM +0000, Fabrizio Castro wrote:
> > Hello Simon,
> >
> > > Subject: Re: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[3=
5] PWM bindings
> > >
> > > On Tue, Dec 19, 2017 at 01:34:57PM +0000, Fabrizio Castro wrote:
> > > > This patch adds compatible strings specific to r8a774[35], no drive=
r
> > > > change is needed as the fallback compatible string will activate th=
e
> > > > right code. Also, this patch replaces the example with a DT snippet=
 used
> > > > for adding PWM0 support to an r8a7743 based platform.
> > >
> > > What is the motivation for updating the example?
> >
> > I am sorry I forgot to copy the explanation across from the first versi=
on of the patch:
> > https://patchwork.kernel.org/patch/10111831/
> >
> > "the reason for replacing the example with one of a different SoC is th=
at
> > the new example refers to recent code from a real use case. I hope that=
's ok."
> >
> > Basically the r8a7743 will be the first platform with full upstream sup=
port, and I believe it is better to have up-to-date examples
> proven to work in the documentation.
>
> Thanks, that sounds reasonable.
>
> >
> > > Could it be stated here?
> >
> > Shall I send a new version for this?
>
> That would be best in my opinion.

Thank you for your feedback, I'll send a new version separately (not in the=
 context of this series anymore as the pending patches from this series are=
 dt-bindings related) to enhance the changelog.

Cheers,
Fab


[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
