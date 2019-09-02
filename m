From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/6] pwm: ensure pwm_apply_state() doesn't modify the
 state argument
Date: Mon, 2 Sep 2019 22:19:05 +0200
Message-ID: <20190902201905.kyduxnehcjfzitrc@pengutronix.de>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190824153707.13746-1-uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Patrick Havelange <patrick.havelange-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Aug 24, 2019 at 05:37:01PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
> =

> this series eventually changes the prototype of pwm_apply_state to take
> a const struct pwm_state *, see the last patch for a rationale.
> =

> Changes since v2 apart from rebasing and so covering a few more drivers
> is mainly addressing the concern that after state was rounded and
> applied at least pwm_get_state should return the rounded values. See
> patch 2.

I thought a bit on this series and there is a question about it.
Depending on what is considered the right answer for it, this series
might have to change.

The key question is:

  - Is pwm_get_state() supposed to return
    a) the last requested configuration; or
    b) the last actually implemented configuration?

(If the difference is unclear: consider a PWM that can only implement
the following periods:

	1 ms, 2 ms, 3 ms, 4 ms, 5 ms, 6 ms, ...

and a consumer requested 4.2 ms. Should pwm_get_state() return .period =3D 4
ms (assuming this was picked) or 4.2 ms?)

As of v5.3-rc5 it depends on the backend driver. For most of them 4.2 ms
is returned. My series tries to push it to return 4 ms instead. (But
this only works for backends that implement the .get_state() callback.
And it gets more complicated as the drivers are not free of surprises.)

Maybe we need functions for both answers?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
