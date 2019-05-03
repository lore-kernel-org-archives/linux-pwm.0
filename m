From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Fri, 3 May 2019 21:59:05 +0200
Message-ID: <20190503195904.zbqdfpowks6vwhv6@pengutronix.de>
References: <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190502091638.0f5a40b0@collabora.com>
 <20190502073326.sgqgkiexjkipvi27@pengutronix.de>
 <20190502100951.23ef9ed1@collabora.com>
 <20190502084243.anz5myut63g4torn@pengutronix.de>
 <20190503105915.GA32400@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190503105915.GA32400@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Fri, May 03, 2019 at 12:59:15PM +0200, Thierry Reding wrote:
> On Thu, May 02, 2019 at 10:42:43AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, May 02, 2019 at 10:09:51AM +0200, Boris Brezillon wrote:
> > > On Thu, 2 May 2019 09:33:26 +0200
> > > Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > On Thu, May 02, 2019 at 09:16:38AM +0200, Boris Brezillon wrote:
> > > > > I do understand that some users might want to check how the HW wi=
ll
> > > > > adjust the period/duty before applying the new setup, and in that
> > > > > regard, having pwm_round_rate() is a good thing. But in any case,=
 it's
> > > > > hard for the user to decide how to adjust things to get what it w=
ants
> > > > > (should he increase/decrease the period/duty?).  =


Whenever I wrote pwm_round_rate I actually meant pwm_round_state.

> > > > It depends on the use case. For one of them I suggested an algorith=
m.
> > > =

> > > Yes, I was just trying to say that passing a PWM state to
> > > pwm_round_state() is not enough, we need extra info if we want to make
> > > it useful, like the rounding policy, the accepted deviation on period,
> > > duty or the duty/period ratio, ....
> > =

> > Ack. My suggestion is that round_rate should do:
> > =

> > 	if polarity is unsupported:
> > 		polarity =3D !polarity
> > 		duty_cycle =3D period - duty_cycle
> =

> This should really be up to the consumer. The PWM framework or driver
> doesn't know whether or not the consumer cares about the polarity or
> whether it only cares about the power output.

You don't understand my idea. If the hardware cannot implement the
requested state the round_state function has to return a best
approximation according to some rules. After that the consumer can
decide if they want that or not. As the hardware isn't touched nothing
bad happens.

(Well, apart from that I still cannot imagine a use case where with the
current possibilities of the PWM API a consumer can really care about
the polarity.)

> > 	period =3D biggest supportable period <=3D requested period, 0 if no
> > 		such period exists.
> > =

> > 	duty_cycle =3D biggest supportable duty cycle <=3D requested
> > 		duty_cycle, 0 if no such value exists
> =

> This doesn't really work. We need some way to detect "value does not
> exist" that is different from value =3D=3D 0, because value =3D=3D 0 is a
> legitimate use-case.

Same as above. If I asked for duty_cycle =3D 5 ns and get back duty_cycle
=3D 0 ns this means the driver cannot implement a duty_cycle in the
interval (0, 5] ns, nothing more. =


> > This would allow to let the consumer (or framework helper function)
> > decide which deviation is ok.
> =

> So what's the consumer supposed to do if it gets back these values?

If the value is then known to be the best (or good enough if the
consumer doesn't really care), it is used. Otherwise a different state
is rounded or the consumer gives up if it becomes clear that the
hardware cannot satisfy their needs.

> How does it know how to scale them if the deviation is not okay?

It depends on what the consumer considers optimal. I already gave one
example code how I think pwm_round_state should be used. Another is:

If the consumer wants a period as near as possible to a given target
period the algorithm with the round_state function as suggested would
look as follows (duty_cycle ignored here for the ease of discussion):

		mystate.period =3D target_period
		...
		pwm_round_state(pwm, &mystate)

		if (mystate.period =3D=3D target_period)
			return mystate.period

		mystate.period =3D 2 * target_period - mystate.period
		pwm_round_state(pwm, &mystate)

		if (mystate.period < target_period)
			return mystate.period;

		do {
			best_bigger =3D mystate.period
			mystate.period -=3D 1
			pwm_round_state(pwm, &mystate)
		} while (mystate.period > target_period)

		return best_bigger

> What in case the hardware can do achieve a good period that is
> slightly bigger than the requested period and which would give a very
> good result?

The above algorithm answers this question.

Theoretically the requirements for pwm_round_state could be changed such
that it is supposed to yield the nearest hit instead of the next smaller
one, but this only shifts the complexity to a different area. (I think
my suggestion is the better one though because the math for the lowlevel
drivers and also the helper functions is easier then. Also the search
terminates earlier if the consumer wants something bigger than the
driver can implement. Moreover "biggest value not bigger than requested"
is (IMHO) easier to understand for the affected coders than "nearest
value" because there are more ugly special cases. (Consider I ask for
(duty_cycle, period) =3D (10, 20) and the driver can implement (9, 18) and
(12, 21). Which of these is nearer?))

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
