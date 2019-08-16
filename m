From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Fri, 16 Aug 2019 10:44:41 +0800
Message-ID: <CAMz4kuJBbTrR9+7XfDhRtmJovFJnne_RPGrdOYe09mdRDrDrig@mail.gmail.com>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de> <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de> <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
 <20190815085452.2cipewq3l3krnwzv@pengutronix.de> <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
 <20190815101147.azbbjcvafwjx67wc@pengutronix.de> <CAMz4ku+AAGC6TgxOA5EZGFeqpsq_Q8=S+DkDk9Rm_G=yAshJ0w@mail.gmail.com>
 <20190815122518.hzy57s635ubohywh@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815122518.hzy57s635ubohywh@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, DTML <devicetree@vger.kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Orson Zhai <orsonzhai@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 15 Aug 2019 at 20:25, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Aug 15, 2019 at 07:05:53PM +0800, Baolin Wang wrote:
> > On Thu, 15 Aug 2019 at 18:11, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello,
> > >
> > > On Thu, Aug 15, 2019 at 05:34:02PM +0800, Baolin Wang wrote:
> > > > On Thu, 15 Aug 2019 at 16:54, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> > > > > > On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > > > > > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K=C3=B6nig
> > > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wro=
te:
> > > > > > > > > > +      * To keep the maths simple we're always using MO=
D =3D SPRD_PWM_MOD_MAX.
> > > > > > > > >
> > > > > > > > > Did you spend some thoughts about how wrong your period c=
an get because
> > > > > > > > > of that "lazyness"?
> > > > > > > > >
> > > > > > > > > Let's assume a clk rate of 100/3 MHz. Then the available =
period lengths
> > > > > > > > > are:
> > > > > > > > >
> > > > > > > > >         PRESCALE =3D  0  ->  period =3D   7.65 =C2=B5s
> > > > > > > > >         PRESCALE =3D  1  ->  period =3D  15.30 =C2=B5s
> > > > > > > > >         ...
> > > > > > > > >         PRESCALE =3D 17  ->  period =3D 137.70 =C2=B5s
> > > > > > > > >         PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5s
> > > > > > > > >
> > > > > > > > > So the error can be up to (nearly) 7.65 =C2=B5s (or in ge=
neral
> > > > > > > >
> > > > > > > > Yes, but for our use case (pwm backlight), the precision ca=
n meet our
> > > > > > > > requirement. Moreover, we usually do not change the period,=
 just
> > > > > > > > adjust the duty to change the back light.
> > > > > > >
> > > > > > > Is this a license requirement for you SoC to only drive a bac=
klight with
> > > > > > > the PWM? The idea of having a PWM driver on your platform is =
that it can
> > > > > > > also be used to control a step motor or a laser.
> > > > > >
> > > > > > Not a license requirement. Until now we have not got any higher
> > > > > > precision requirements, and we've run this driver for many year=
s in
> > > > > > our downstream kernel.
> > > > >
> > > > > I understood that you're not ambitious to do something better tha=
n "it
> > > > > worked for years".
> > > >
> > > > How do you know that?
> > >
> > > I showed you how you could match the requested PWM output better and
> > > you refused telling it worked for years and the added precision isn't
> > > necessary for a backlight.
> >
> > Please I said the reason, it is not that I do not want a better
> > precision. The problem is we do not know how much precision to be
> > asked by users if no use case
>
> I don't understand the problem here. If you are asked for period =3D
> 145340 ns and configure the hardware to yield 137700 ns in reply to that
> but you could provide 144780 ns I don't understand why you need a use
> case as 144780 ns is objectively better than 137700 ns. A better match

You are wrong, we will provide 145350 ns with
DIV_ROUND_CLOSEST_ULL()., which is better than your 144780.

> has only upsides, it doesn't hurt people how don't care about a few
> micro seconds in the one or the other direction. OK, your CPU needs a
> few more cycles to find the better configuration but that's a poor
> argument. With only a backlight as use case you could even hardcode
> PRESCALE =3D 0 without any problems and have the needed calculations a bi=
t
> cheaper.
>
> > > > What I mean is use DIV_ROUND_CLOSEST_ULL we can get a nearer value =
to
> > > > the requested like above example.
> > >
> > > But given that it's unclear if 137700 ns or 145350 ns is better when
> > > 145340 ns was requested this is not a strong argument to use
> > > DIV_ROUND_CLOSEST_ULL. With the global picture for the pwm framework =
in
> > > mind it is sensible to request the same rounding from all drivers to =
get
> > > a consistent behaviour. And I believe the maths with rounding down is
> > > easier than when rounding up or nearest. That's why I argue in this
> > > direction.
> >
> > Let's wait for Thierry's suggestion to get a consensus firstly.
>
> OK. I'm not sure you want to wait until Thierry and I agree on a
> solution here though :-)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|



--=20
Baolin Wang
Best Regards
