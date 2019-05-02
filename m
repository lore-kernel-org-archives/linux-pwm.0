From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Thu, 2 May 2019 09:33:26 +0200
Message-ID: <20190502073326.sgqgkiexjkipvi27@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190502091638.0f5a40b0@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190502091638.0f5a40b0-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Boris,

On Thu, May 02, 2019 at 09:16:38AM +0200, Boris Brezillon wrote:
> On Mon, 29 Apr 2019 11:04:20 -0700
> Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> =

> > Hi,
> > =

> > On Sun, Apr 28, 2019 at 11:56 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > >
> > > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:  =

> > > > Hi,
> > > >
> > > > I'm not sure if I'm misreading you, but I thought I'd add here befo=
re
> > > > this expires out of my inbox:
> > > >
> > > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=F6nig
> > > > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:  =

> > > > > My intention here is more to make all drivers behave the same way=
 and
> > > > > because only two drivers updated the pwm_state this was the varia=
nt I
> > > > > removed.  =

> > > >
> > > > To be clear, this patch on its own is probably breaking things. Just
> > > > because the other drivers don't implement the documented behavior
> > > > doesn't mean you should break this driver. Maybe the others just
> > > > aren't used in precise enough scenarios where this matters.
> > > >  =

> > > > > When you say that the caller might actually care about the exact
> > > > > parameters I fully agree. In this case however the consumer shoul=
d be
> > > > > able to know the result before actually applying it. So if you do
> > > > >
> > > > >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12=
, ...})
> > > > >
> > > > > and this results in .period =3D 100 and .duty_cycle =3D 0 then pr=
obably the
> > > > > bad things you want to know about already happend. So my idea is =
a new
> > > > > function pwm_round_state() that does the adaptions to pwm_state w=
ithout
> > > > > applying it to the hardware. After that pwm_apply_state could do =
the
> > > > > following:
> > > > >
> > > > >         rstate =3D pwm_round_state(pwm, state)
> > > > >         pwm.apply(pwm, state)
> > > > >         gstate =3D pwm_get_state(pwm)
> > > > >
> > > > >         if rstate !=3D gstate:
> > > > >                 warn about problems  =

> > > >
> > > > For our case (we're using this with pwm-regulator), I don't recall =
[*]
> > > > we need to be 100% precise about the period, but we do need to be as
> > > > precise as possible with the duty:period ratio -- so once we get the
> > > > "feedback" from the underlying PWM driver what the real period will
> > > > be, we adjust the duty appropriately.  =

> > >
> > > I admit that I didn't understood the whole situation and (some) things
> > > are worse with my patches applied. I still think that changing the
> > > caller's state variable is bad design, but of course pwm_get_state
> > > should return the currently implemented configuration.  =

> > =

> > Regardless of the pros and cons of the current situation, hopefully
> > we're in agreement that we shouldn't break existing users?  In general
> > I'll probably stay out of the debate as long as we end somewhere that
> > pwm_regulator is able to somehow know the actual state that it
> > programmed into the hardware.
> > =

> > +Boris too in case he has any comments.
> =

> Well, the pwm_round_state() approach sounds okay to me, though I don't
> really see why it's wrong to adjust the state in pwm_apply_state()
> (just like clk_set_rate() will round the rate for you by internally
> calling clk_round_rate() before applying the config).

This are two orthogonal things. The "should pwm_apply_state change the
state argument" isn't really comparable to the clk stuff, as there only
the frequency is provided that is passed by value, not by reference as
the PWM state.

The key argument for me to *not* change it is that it might yield
surprises, still more as today most drivers don't adapt. An -- I admit
constructed, not real-word -- case where adaption would go wrong is:

	pwm_apply_state(pwm1, &mystate);
	pwm_apply_state(pwm2, &mystate);

> Note that pwm_config() is doing exactly the same: it adjusts the
> config to HW caps, excepts in that case you don't know it.

I don't see what you mean here. I don't see any adaption.

> I do understand that some users might want to check how the HW will
> adjust the period/duty before applying the new setup, and in that
> regard, having pwm_round_rate() is a good thing. But in any case, it's
> hard for the user to decide how to adjust things to get what it wants
> (should he increase/decrease the period/duty?).

It depends on the use case. For one of them I suggested an algorithm.

> My impression is that most users care about the duty/period ratio with
> little interest in accurate period settings (as long as it's close
> enough to what they expect of course). For the round-up/down/closest
> aspect, I guess that's also something we can pass to the new API. So,
> rather than passing it a duty in ns, maybe we could pass it a ratio
> (percent is probably not precise enough for some use cases, so we could
> make it per-million).

Yeah, something like that would be good. Still for the device drivers I
would use the callback I suggested because that is easier to implement.
This way the complexity is once in the framework instead of in each
driver.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
