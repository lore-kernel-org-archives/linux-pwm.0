From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock
 directly
Date: Thu, 7 Nov 2019 07:51:18 +0100
Message-ID: <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-5-peron.clem@gmail.com>
 <20191105145659.ffezqntodsys4phn@pengutronix.de>
 <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <pza@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hello Cl=E9ment,

On Wed, Nov 06, 2019 at 10:24:39PM +0100, Cl=E9ment P=E9ron wrote:
> On Tue, 5 Nov 2019 at 15:57, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 05, 2019 at 02:14:53PM +0100, Cl=E9ment P=E9ron wrote:
> > > +     bypass =3D state->enabled &&
> > > +              (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> >
> > This is too coarse. With state->period =3D 1000000 this is fulfilled
> > (unless the multiplication overflows).
> =

> Sorry, misunderstood the previous mail
> =

> What about something like this ?
> ((state->period - 1) * clk_rate <=3D NSEC_PER_SEC) &&
> ((state->period + 1) * clk_rate >=3D NSEC_PER_SEC) &&
>  ((state->duty_cycle - 1) * 2 <=3D state->period) &&
>  ((state->duty_cycle + 1) * 2 >=3D state->period);
> =

> We are sure that the user is looking for a PWM around the OSC with a
> 50% duty cycle ?

This again is too strict. The general policy to fulfill a request is:

 1) provide the longest possible period not bigger than requested
 2) provide the longest possible duty cycle not bigger than requested
 3) if possible complete the currently running period before switching
    and don't return to the user before the new setting is active.
    Document the behaviour prominently because the code (usually)
    doesn't allow to understand the hardware's features here.
 4) A disabled PWM should output the inactive level

And then there is a corner case: If the user requests .duty_cycle =3D 0,
.enabled =3D 1 it is ok to provide .enabled =3D 0 iff otherwise 0% isn't
possible.

So the right check for bypass is:

  state->period * clk_rate >=3D NSEC_PER_SEC &&
  state->period * clk_rate < whatevercanbereachedwithoutbypass &&
  state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
