From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
Date: Fri, 05 Jun 2020 20:17:59 +0200
Message-ID: <b3324f5c1c908edc89a9cd2676644dfe@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-6-michael@walle.cc> <20200605084915.GE3714@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200605084915.GE3714@dell>
Sender: linux-hwmon-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg
List-Id: linux-pwm@vger.kernel.org

Am 2020-06-05 10:49, schrieb Lee Jones:
[..]
>> +static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip 
>> *chip)
>> +{
>> +	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
>> +}
> 
> Why not save yourself the trouble and just:
> 
>   struct sl28cpld_pwm *pwm = dev_get_drvdata(chip->dev);

Is there a reason why not a single pwm driver uses something like that?

-michael
