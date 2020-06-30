From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v15 3/3] Input: new da7280 haptic driver
Date: Mon, 29 Jun 2020 20:13:48 -0700
Message-ID: <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgF3DOE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 23:14:04 -0400
In-Reply-To: <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi Roy,


On 6/29/20 6:01 AM, Roy Im wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 362e8a0..79fbddb 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -869,4 +869,17 @@ config INPUT_STPMIC1_ONKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stpmic1_onkey.
>  
> +config INPUT_DA7280_HAPTICS
> +	tristate "Dialog Semiconductor DA7280 haptics support"
> +	depends on INPUT && I2C
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the Dialog DA7280 haptics driver.
> +	  The haptics can be controlled by i2c communication,

If you make any more updates, make this:   I2C communication,
please.

> +	  or by PWM input, or by GPI.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280.
> +
>  endif

thanks.
-- 
~Randy
