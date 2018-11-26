From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for
 sun8i-r40 soc pwm.
Date: Mon, 26 Nov 2018 21:49:24 +0100
Message-ID: <20181126204924.z2b7pwzeu6sqorxw@pengutronix.de>
References: <20181125162203.GA5392@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125162203.GA5392@arx-s1>
Sender: linux-kernel-owner@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 26, 2018 at 12:22:03AM +0800, Hao Zhang wrote:
> +#define CLK_APB1                27

This is already used in patch 2, so the patches must be reordered.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
