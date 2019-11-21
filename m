From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 4/8] pwm: sun4i: Add an optional probe for bus clock
Date: Thu, 21 Nov 2019 08:28:29 +0100
Message-ID: <20191121072829.vitly7altcvlt4sj@pengutronix.de>
References: <20191119175319.16561-1-peron.clem@gmail.com>
 <20191119175319.16561-5-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191119175319.16561-5-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

Hello Clément,

On Tue, Nov 19, 2019 at 06:53:15PM +0100, Clément Péron wrote:
> +	/*
> +	 * We're keeping the bus clock on for the sake of simplicity.
> +	 * Actually it only needs to be on for hardware register accesses.
> +	 */
> +	ret = clk_prepare_enable(pwm->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n");

Maybe add the error code to the message?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
