Return-path: <kernel-bounces@pengutronix.de>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 12 Dec 2018 10:49:32 +0000
Message-ID: <OSBPR01MB2293ACA05221DB5A6D3A6BB2D8A70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
 <OSBPR01MB229351E3EC1B66339E6C9635D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
 <20181210081103.zxayrzpbxiuvv6hb@pengutronix.de>
 <OSBPR01MB2293BE0147A4A535136BDF82D8A70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
 <20181212073733.th23v5cvaxfbhy53@pengutronix.de>
In-Reply-To: <20181212073733.th23v5cvaxfbhy53@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low level
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Uwe,

> From: Uwe Kleine-K=F6nig, Sent: Wednesday, December 12, 2018 4:38 PM
<snip>
> > > In the past I suggested to weaken the requirements after pwm_disable,
> > > but Thierry didn't like it.
> >
> > I read the following discussion once:
> > https://patchwork.ozlabs.org/patch/959776/
>=20
> Yeah, that's (part of) the discussion I meant. Thierry doesn't agree
> though, so for now that's a dead end. My plan is to watch the pwm list
> for a while to get a better picture about the different pwm
> implementations because just one or two problematic cases are not
> enough to justify a generic solution in the core in his eyes.

I got it.

> > I could not understand all this yet, but I think I should try to add a =
special gpio handling
> > to the pwm-rcar.c driver instead of a generic approach because as you m=
entioned above,
> > such special handling needs for the hardware.
>=20
> Being able to set PHO to zero would be still better, so I hope you
> follow up on the question to your hardware guys if this is really
> forbidden. (If I had access to such hardware, I'd bluntly try what
> happens.)

The hardware guy said that the output level is always high if PH0 is set to=
 0.
However, the PH0 bitfields means "PWM High-Level Period" so that the behavi=
or of
the zero differs between the document and the hardware. So, we have to assu=
me
this is really forbidden unfortunately...

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
