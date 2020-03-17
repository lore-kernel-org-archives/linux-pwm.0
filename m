From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 22:32:48 +0100
Message-ID: <20200317213248.mmh2t6jgncq3tqp3@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317133450.58c25bcb@ub1910>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317133450.58c25bcb@ub1910>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Barker <pbarker@konsulko.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Palmer
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 01:34:50PM +0000, Paul Barker wrote:
> On Tue, 17 Mar 2020 14:32:25 +0200
> Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:
> 
> > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > Rename it to PWM_POLARITY_INVERTED.
> > 
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> Looks good. PWM_POLARITY_INVERSED confused me when I was working in this area
> recently.

Same for me.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
