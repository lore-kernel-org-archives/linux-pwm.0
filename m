From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: Enable compile testing for some of drivers
Date: Wed, 4 Mar 2020 07:52:53 +0100
Message-ID: <20200304065253.dhxwemlc7skp2gbt@pengutronix.de>
References: <20200303202447.4245-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50831 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCDGw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Mar 2020 01:52:56 -0500
Content-Disposition: inline
In-Reply-To: <20200303202447.4245-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>

Hello,

On Tue, Mar 03, 2020 at 09:24:47PM +0100, Krzysztof Kozlowski wrote:
> Some of the PWM drivers can be compile tested to increase build
> coverage.
> 
> The Meson PWM driver requires COMMON_CLK dependency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> # For Broadcoam
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # For Meson
> Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com> # For Atmel

I wonder if this results in some autobuilder fallout, but even if it
does I still think this is a good thing to do.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
