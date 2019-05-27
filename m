From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 14/14] pwm: meson: add documentation to the driver
Date: Mon, 27 May 2019 14:33:52 +0200
Message-ID: <afc7da5b-dda2-84e0-a6c8-0ab3c41f7e0e@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-15-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-15-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> Add a link to the datasheet and a short summary how the hardware works.
> The goal is to make it easier for other developers to understand why the
> pwm-meson driver is implemented the way it is.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Co-authored-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index bb48ba85f756..6a978caba483 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -1,5 +1,23 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /*
> + * PWM controller driver for Amlogic Meson SoCs.
> + *
> + * This PWM is only a set of Gates, Dividers and Counters:
> + * PWM output is achieved by calculating a clock that permits calculating
> + * two periods (low and high). The counter then has to be set to switch after
> + * N cycles for the first half period.
> + * The hardware has no "polarity" setting. This driver reverses the period
> + * cycles (the low length is inverted with the high length) for
> + * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
> + * from the hardware.
> + * Setting the duty cycle will disable and re-enable the PWM output.
> + * Disabling the PWM stops the output immediately (without waiting for the
> + * current period to complete first).
> + *
> + * The public S922X datasheet contains some documentation for this PWM
> + * controller starting on page 1084:
> + * https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
> + *
>   * Copyright (c) 2016 BayLibre, SAS.
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   * Copyright (C) 2014 Amlogic, Inc.
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
