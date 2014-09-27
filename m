From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] clk: Add PWM clock driver
Date: Sat, 27 Sep 2014 13:01:22 -0700
Message-ID: <20140927200122.19023.40310@quantum>
References: <5410AEFD.5030302@elproma.com.pl> <20140923085130.GO30514@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140923085130.GO30514@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?utf-8?q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Quoting Thierry Reding (2014-09-23 01:51:31)
> On Wed, Sep 10, 2014 at 10:05:17PM +0200, Janusz U=C5=BCycki wrote:
> > Hi,
> >=20
> > http://patchwork.ozlabs.org/patch/359069/
> > https://lkml.org/lkml/2014/6/12/186
> >=20
> > Will the patch ever included to linux-next?
>=20
> I've never seen this patch before. From a quick look it doesn't seem
> like it would work as is, but the idea is certainly interesting. If
> somebody decides to continue work on it, please Cc me and the linux-p=
wm
> mailing list.

I just merged a gpio-controlled clock gate and I'm fine with a PWM cloc=
k
output.

Janusz, how are you testing the clock driver?

Regards,
Mike

>=20
> > pwm_config()  API could be extended to support
> > not only period [ns] and duty [ns] time
> > but also frequency [Hz] and duty cycle fraction [1/1000?]
> > (instead of time in ns) as parameters.
> > Then  ns (rounded by pwm) to freq. conversion problem
> > inclk_pwm_recalc_rate() usingpwm_get_period()
> > could be avoided.
> > To extend the API pwm_config() can support
> > new flags forduty_ns and period_ns,
> > eg. PWM_DUTY_PERCENT and PWM_PERIOD_HZ.
>=20
> Is that rounding really a problem? Also the PWM chips will most likel=
y
> use the concept of period and duty-cycle internally anyway, so it wil=
l
> convert back from Hz/percentage to nanoseconds and fall victim to
> similar rounding effects.
>=20
> Thierry
