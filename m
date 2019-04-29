From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 08:56:13 +0200
Message-ID: <20190429065613.n52uwgys5eugmssd@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:
> Hi,
> =

> I'm not sure if I'm misreading you, but I thought I'd add here before
> this expires out of my inbox:
> =

> On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > My intention here is more to make all drivers behave the same way and
> > because only two drivers updated the pwm_state this was the variant I
> > removed.
> =

> To be clear, this patch on its own is probably breaking things. Just
> because the other drivers don't implement the documented behavior
> doesn't mean you should break this driver. Maybe the others just
> aren't used in precise enough scenarios where this matters.
> =

> > When you say that the caller might actually care about the exact
> > parameters I fully agree. In this case however the consumer should be
> > able to know the result before actually applying it. So if you do
> >
> >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ...})
> >
> > and this results in .period =3D 100 and .duty_cycle =3D 0 then probably=
 the
> > bad things you want to know about already happend. So my idea is a new
> > function pwm_round_state() that does the adaptions to pwm_state without
> > applying it to the hardware. After that pwm_apply_state could do the
> > following:
> >
> >         rstate =3D pwm_round_state(pwm, state)
> >         pwm.apply(pwm, state)
> >         gstate =3D pwm_get_state(pwm)
> >
> >         if rstate !=3D gstate:
> >                 warn about problems
> =

> For our case (we're using this with pwm-regulator), I don't recall [*]
> we need to be 100% precise about the period, but we do need to be as
> precise as possible with the duty:period ratio -- so once we get the
> "feedback" from the underlying PWM driver what the real period will
> be, we adjust the duty appropriately.

I admit that I didn't understood the whole situation and (some) things
are worse with my patches applied. I still think that changing the
caller's state variable is bad design, but of course pwm_get_state
should return the currently implemented configuration.

> So I don't see that "warning" would really help for this particular case.
> =

> > But before doing that I think it would be sensible to also fix the rules
> > how the round_state callback is supposed to round.
> =

> I'm not quite sure I grok exactly what you're planning, but I would
> much appreciate if you didn't break things on the way toward fixing
> them ;)

There are currently no rules how the driver should behave for example if
the consumer requests

	.duty_cycle =3D 10, .period =3D 50

and the hardware can only implement multiples of 3 for both values. The
obvious candidates are:

 - .duty_cycle =3D 9, .period =3D 51 (round nearest for both)
 - .duty_cycle =3D 12, .period =3D 51 (round up)
 - .duty_cycle =3D 9, .period =3D 48 (round down)
 - .duty_cycle =3D 9, .period =3D 45 (round duty_cycle and keep proportion)
 - return error (which code?)

And there are some other variants (e.g. round duty_cycle to nearest and
period in the same direction) that might be sensible.

Also it should be possible to know the result before actually
configuring the hardware. Otherwise things might already go wrong
because the driver implements a setting that is too far from the
requested configuration.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
