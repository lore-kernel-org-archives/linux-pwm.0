Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 17:47:58 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181012154758.eisrsrhf3exz35yx@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
 <3c0ec462-9f15-cbf2-51f6-5e7e70c68e48@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c0ec462-9f15-cbf2-51f6-5e7e70c68e48@ysoft.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Gavin Schenk <g.schenk@eckelmann.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

Hello Michal,

On Fri, Oct 12, 2018 at 12:25:01PM +0000, Vokáč Michal wrote:
> >> Regarding the GPIO output configuration. Yes, the pin is configured as
> >> input in the imx_pwm_init_pinctrl_info() function. At this stage you
> >> do not really know how to configure the pin. Configuring it as input
> >> is the safest option I think.
> > 
> > Did it work without setting the gpio as output in your tests?
> 
> Yes, I am using it like that for aprox. 2 months without issues.

and you're sure the gpio is configured as output? Strange.
 
> >> I thought that the pin is configured as output whenever gpiod_set_value()
> >> is called. None of the other examples/usages in kernel I looked at used
> >> the gpiod_direction_output()
> > 
> > Maybe they use devm_gpio_request_one or similar that return your gpio's
> > direction already configured?
> 
> Nope. Examples I looked at (mainly I2C recovery) use only the gpiolib
> functions.

For example drivers/i2c/busses/i2c-imx.c uses devm_gpiod_get(&pdev->dev,
"scl", GPIOD_OUT_HIGH_OPEN_DRAIN); which configures as output (somewhat).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
