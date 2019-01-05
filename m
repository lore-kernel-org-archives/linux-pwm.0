From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Date: Sat, 5 Jan 2019 22:05:22 +0100
Message-ID: <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu.Beznea@microchip.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, linux-doc@vger.kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> =

> Add basic PWM modes: normal and complementary. These modes should
> differentiate the single output PWM channels from two outputs PWM
> channels. These modes could be set as follow:
> 1. PWM channels with one output per channel:
> - normal mode
> 2. PWM channels with two outputs per channel:
> - normal mode
> - complementary mode
> Since users could use a PWM channel with two output as one output PWM
> channel, the PWM normal mode is allowed to be set for PWM channels with
> two outputs; in fact PWM normal mode should be supported by all PWMs.

I still think that my suggestion that I sent in reply to your v5 using
.alt_duty_cycle and .alt_offset is the better one as it is more generic.
A word about that from Thierry before putting the mode into the pwm API
would be great.

I don't repeat what I wrote there assuming you still remember or are
willing to look it up at
e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd half
of my mail).

Also I think that if the capabilities function is the way forward adding
support to detect availability of polarity inversion should be
considered. This would also be an opportunity to split the introduction
of the capabilities function and the introduction of complementary mode.
(But my personal preference would be to just let .apply fail when an
unsupported configuration is requested.)

> +static int pwm_get_default_caps(struct pwm_caps *caps)
> +{
> +	static const struct pwm_caps default_caps =3D {
> +		.modes_msk =3D PWM_MODE_BIT(NORMAL),
> +	};
> +
> +	if (!caps)
> +		return -EINVAL;
> +
> +	*caps =3D default_caps;
> +
> +	return 0;
> +}
> +
> +/**
> + * pwm_get_caps() - get PWM capabilities of a PWM device
> + * @pwm: PWM device to get the capabilities for
> + * @caps: returned capabilities
> + *
> + * Returns: 0 on success or a negative error code on failure
> + */
> +int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
> +{
> +	if (!pwm || !caps)
> +		return -EINVAL;
> +
> +	if (pwm->chip->ops->get_caps)
> +		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
> +
> +	return pwm_get_default_caps(caps);

I'd drop pwm_get_default_caps (unless you introduce some more callers
later) and fold its implementation into pwm_get_caps.

> +}
> +EXPORT_SYMBOL_GPL(pwm_get_caps);
> [...]
> @@ -53,12 +75,14 @@ enum {
>   * @period: PWM period (in nanoseconds)
>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>   * @polarity: PWM polarity
> + * @modebit: PWM mode bit
>   * @enabled: PWM enabled status
>   */
>  struct pwm_state {
>  	unsigned int period;
>  	unsigned int duty_cycle;
>  	enum pwm_polarity polarity;
> +	unsigned long modebit;

I fail to see the upside of storing the mode as 2^mode instead of a
plain enum pwm_mode. Given that struct pwm_state is visible for pwm
users a plain pwm_mode would at least be more intuitive.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
