From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock directly
Date: Fri, 8 Nov 2019 09:34:24 +0100
Message-ID: <CAJiuCcd3qAP=xODJWcvay6q-MbLeBvX5tAtuUj7dFcp8biXzOw@mail.gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-5-peron.clem@gmail.com>
 <20191105145659.ffezqntodsys4phn@pengutronix.de> <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
 <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, 7 Nov 2019 at 07:51, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Wed, Nov 06, 2019 at 10:24:39PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Tue, 5 Nov 2019 at 15:57, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Nov 05, 2019 at 02:14:53PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > +     bypass =3D state->enabled &&
> > > > +              (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > >
> > > This is too coarse. With state->period =3D 1000000 this is fulfilled
> > > (unless the multiplication overflows).
> >
> > Sorry, misunderstood the previous mail
> >
> > What about something like this ?
> > ((state->period - 1) * clk_rate <=3D NSEC_PER_SEC) &&
> > ((state->period + 1) * clk_rate >=3D NSEC_PER_SEC) &&
> >  ((state->duty_cycle - 1) * 2 <=3D state->period) &&
> >  ((state->duty_cycle + 1) * 2 >=3D state->period);
> >
> > We are sure that the user is looking for a PWM around the OSC with a
> > 50% duty cycle ?
>
> This again is too strict. The general policy to fulfill a request is:
>
>  1) provide the longest possible period not bigger than requested
>  2) provide the longest possible duty cycle not bigger than requested
>  3) if possible complete the currently running period before switching
>     and don't return to the user before the new setting is active.
>     Document the behaviour prominently because the code (usually)
>     doesn't allow to understand the hardware's features here.
>  4) A disabled PWM should output the inactive level

Thanks for the explanation

>
> And then there is a corner case: If the user requests .duty_cycle =3D 0,
> .enabled =3D 1 it is ok to provide .enabled =3D 0 iff otherwise 0% isn't
> possible.
>
> So the right check for bypass is:
>
>   state->period * clk_rate >=3D NSEC_PER_SEC &&
>   state->period * clk_rate < whatevercanbereachedwithoutbypass &&
>   state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC

The shortest PWM ratio which is not a constant output is 12MHz.
(Prescal 1, 2 entire cycle and 1 active cycle)

So something like this :
state->period * clk_rate >=3D NSEC_PER_SEC &&
state->period * clk_rate < 2 * NSEC_PER_SEC &&
state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC

I will send a v4,
Thanks for the help
Regards,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
