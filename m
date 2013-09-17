Return-Path: <sha@pengutronix.de>
Date: Tue, 17 Sep 2013 11:36:22 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] pwm-backlight: allow for non-increasing brightness levels
Message-ID: <20130917093622.GB30088@pengutronix.de>
References: <1379010952-8928-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379010952-8928-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: thierry.reding@gmail.com, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>

Hi Mike,

On Thu, Sep 12, 2013 at 11:35:52AM -0700, Mike Dunn wrote:
> Currently the driver assumes that the values specified in the brightness-levels
> device tree property increase as they are parsed from left to right.  But boards
> that invert the signal between the PWM output and the backlight will need to
> specify decreasing brightness-levels.  This patch removes the assumption that
> the last element of the array is the max value, and instead searches the array
> for the max value and uses that as the normalizing value when determining the
> duty cycle.

Note there's also support for inverted PWMs in the PWM framework
provided your hardware supports this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
