From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Thu, 2 May 2019 08:48:11 +0200
Message-ID: <20190502064811.p7hbsf5rxu2lrmmf@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190430092824.ijtq3gfh6mqujvnk@pengutronix.de>
 <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WUi0NbsRDJA_4WeC62QYXjLNH2OygU1FOCx==W0SyqpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Doug,

On Tue, Apr 30, 2019 at 07:38:09AM -0700, Doug Anderson wrote:
> On Tue, Apr 30, 2019 at 2:28 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> >
> > > > Also it should be possible to know the result before actually
> > > > configuring the hardware. Otherwise things might already go wrong
> > > > because the driver implements a setting that is too far from the
> > > > requested configuration.
> > >
> > > Later in this thread Thierry didn't like the "round rate" idea due to
> > > races.  One way to solve that could be to indicate to the PWM
> > > framework which direction you'd like it to error in: a higher duty
> > > cycle or a lower one.
> >
> > I don't think this would result in settings as optimal as with my
> > suggestion. If you don't agree and want to convince me: Show how your
> > suggestion would work with a PWM that can implement only multiples of 3
> > for duty_cycle and period and you want 20% duty cycle with period <=3D 1
> > ms (without making use of the knowledge about the limitation of the
> > PWM in the algorithm).
> =

> I guess I was assuming that somehow this would percolate down into an
> API call that the PWM driver would implement, so you could make use of
> the PWM knowledge in the algorithm.

As there are so many different possibilities what could be "best" for a
consumer use case, I believe that it would end in a maintenance
mess if each lowlevel driver would need a callback to implement each
rounding strategy.
 =

> ...but I don't have any real strong feelings about this API so I'll
> leave it to you and Thierry to hash out what makes you both happy.

I look forward to us two agreeing on a best approach ... :-)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
