From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/7] pwm: sun4i: Add support for H6 PWM
Date: Tue, 5 Nov 2019 15:57:48 +0100
Message-ID: <20191105145748.6l4ke7zxlt6mibmk@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-6-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191105131456.32400-6-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:54PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Now that sun4i PWM driver supports deasserting reset line and enabling
> bus clock, support for H6 PWM can be added.
> 
> Note that while H6 PWM has two channels, only first one is wired to
> output pin. Second channel is used as a clock source to companion AC200
> chip which is bundled into same package.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
