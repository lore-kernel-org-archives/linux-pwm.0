From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: atmel: Remove platform_device_id and use only dt
 bindings
Date: Thu, 19 Sep 2019 12:03:50 +0200
Message-ID: <20190919100350.alg4dbvnghfhfz5r@pengutronix.de>
References: <20190918145716.32022-1-kamel.bouhara@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190918145716.32022-1-kamel.bouhara@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Gregory Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 04:57:16PM +0200, Kamel Bouhara wrote:
> Since commit 26202873bb51 ("avr32: remove support for AVR32
> architecture") there is no more user of platform_device_id and we
> should only use dt bindings
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
