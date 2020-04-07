From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
Date: Tue, 7 Apr 2020 17:55:18 +0300
Message-ID: <CAGgjyvEP8q9AmXr5nnHiw6zEhoTwFNOW4=wP8eeALfsxtj7L-g@mail.gmail.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
 <20200405192246.3741784-3-oleksandr.suvorov@toradex.com> <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
 <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com> <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 7, 2020 at 2:19 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Apr 07, 2020 at 01:51:42PM +0300, Oleksandr Suvorov wrote:
> > On Tue, Apr 7, 2020 at 9:17 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Sun, Apr 05, 2020 at 10:22:42PM +0300, Oleksandr Suvorov wrote:
> > > > Add the description of PWM_NOFLAGS flag property.
> > > >
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > >
> > > As I already wrote in reply to the v1 series I'd prefer a name for 0
> > > that explicitly handles normal polarity.
> >
> > Uwe, AFAIU, there is no flag that forces normal polarity, the normal po=
larity
> > is the default state if there is no flag to invert the polarity is set.
>
> Yes, that's the status quo.
>
> > '0' value in the bit flags cell really means there are no flags set
> > for the PWM instance.
>
> For me the relevance of giving 0 a name is mostly for human consumption.
> Currently there is only a single flag encoded in the number in question.
> But as soon as we add another, say PWM_AUTOSTART we have the following
> possible settings:
>
>         PWM_NOFLAGS
>         PWM_POLARITY_INVERTED
>         PWM_AUTOSTART
>         PWM_POLARITY_INVERTED | PWM_AUTOSTART
>
> Then for the first two a reader doesn't see if autostart is not in use
> because the dt author doesn't know this feature (e.g. because autostart
> is too new) or if they don't want autostart at all.
>
> If however we had PWM_POLARITY_NORMAL and PWM_NO_AUTOSTART to complement
> PWM_POLARITY_INVERTED and PWM_AUTOSTART

So using this approach, in theory, we'll have several flags that all
just equals to 0 (0 << 0, 0 << 1, 0 << 2 ...).
What if just describe default states for each flag in the DT documentation?

> every flag's setting could be explicit and if there is a device tree that=
 only has
>
>         PWM_POLARITY_NORMAL
>
> it would be obvious that nobody thought enough about autostarting to
> explicitly mention it.

If you insist on the flag complement model, I have another suggestion.
As the normal polarity is the default state, can we use PWM_NO_POLARITY_INV=
ERTED
instead of PWM_POLARITY_NORMAL?
It gives us 2 benefits:
1. The name will not interfere with enum PWM_POLARITY_NORMAL in <linux/pmw.=
h>
2. Each flag complement will be made with the same scheme:
PWM_flagA -> PWM_NO_flagA...

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

--
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
