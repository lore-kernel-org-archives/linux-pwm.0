From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
Date: Sat, 24 Aug 2019 11:25:53 +0200
Message-ID: <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Stefan,

On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
> This small patch series contains minor fixes for clock handling and the
> period range check.

I'd like to understand the various different usecases of PWMs. The
in-kernel consumers are kind of obvious, but sysfs users are not. It
seems you are one of the latter.

Would you mind sharing what you control using the PWM? Does it bother
you that the sysfs interface doesn't allow atomic configuration?

Assuming you have some interest in this driver: It still uses the legacy
stuff implementing .config, .enable, .disable, .set_polarity. Are you
willing to test (or even implement) a switch to .apply instead?

Just from a quick lock into the driver I wonder a few things, maybe you
can shed some light here. If there is publicly available documenation
for this piece of hardware, feel free to point this out, then I might be
able to work out some of the answers myself.

The overall (and common) design of the PWM is an input clk, a counter, a
duty and a period register.

The slightly simplified logic in .config is:

	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
	writel(DIV_ROUND_CLOSEST(duty_ns, scaler), PWM_DUTY);
	writel(DIV_ROUND_CLOSEST(period_ns, scaler), PWM_PERIOD);

This is loosing precision while the calculation could be cheaper (in CPU
cycles) and more exact when using:

	writel(DIV_ROUND_CLOSEST(duty_ns * rate, NSEC_PER_SEC), PWM_DUTY);
	writel(DIV_ROUND_CLOSEST(period_ns * rate, NSEC_PER_SEC), PWM_PERIOD);

This is only two divisions instead of three. And assuming a rate of 9.2
MHz and a request of duty_ns =3D 499945, period_ns =3D 999891 the original
calculation yields

	DUTY =3D 4587
	PERIOD =3D 9173

	real_duty_ns =3D 498586.95652173914
	real_period_ns =3D 997065.2173913043

	error_duty_ns =3D 1358.0434782608645
	error_period_ns =3D 2825.7826086956775

With my suggestion you'd get

	DUTY =3D 4599
	PERIOD =3D 9199

	real_duty_ns =3D 499891.3043478261
	real_period_ns =3D 999891.304347826

	error_duty_ns =3D 53.69565217389027
	error_period_ns =3D -0.30434782605152577

(But having said this, I'd prefer to use rounding down instead of
rounding closest).

Also I wonder if reprogramming the hardware completes the currently
running period and how the hardware behaves on disable. (In the latter
case I'm interested in "Does it complete the running period?" and "Which
state does the output stop in?")

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
