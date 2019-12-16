From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Mon, 16 Dec 2019 10:24:21 +0100
Message-ID: <20191216092421.qjifzrdggu7jgqj3@pengutronix.de>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
 <20191212211434.455trhnlcvn26zl6@pengutronix.de>
 <20191216093955.177a04af@xps13>
 <20191216085424.x6fqr4gxkph5zqjh@pengutronix.de>
 <20191216101416.339d873f@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191216101416.339d873f@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Miquèl

On Mon, Dec 16, 2019 at 10:14:16AM +0100, Miquel Raynal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Mon, 16 Dec
> 2019 09:54:24 +0100:
> > intensity = DIV_ROUND_DOWN_ULL((unsigned long long)state->duty_cycle * PWM_DC_STATES, state->period);
> > 
> > should be both more exact and cheaper to calculate. (But this is
> > somewhat moot given that state->period shouldn't be there.)
> > (And in general you have to care for overflowing, but I think that's not
> > a problem in practise here as struct pwm_state::duty_cycle is an int
> > (still), and PWM_DC_STATES is small.)
> 
> Do you plan to change duty_cycle type?

I don't, but https://patchwork.ozlabs.org/patch/1195481/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
