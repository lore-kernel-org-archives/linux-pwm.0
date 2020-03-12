From: Pascal Roeleven <dev@pascalroeleven.nl>
Subject: pwm: sun4i: pwm-backlight not working since 5.6-rc1
Date: Thu, 12 Mar 2020 13:22:13 +0100
Message-ID: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

Hi all,

I am working on adding an old A10 device to mainline and noticed an 
issue when testing on 5.5.8 vs master.

Since 5.6-rc1, I can't control the brightness of my LCD backlight 
anymore. The backlight stays on full brightness instead. I am 
controlling the brightness value via sysfs for testing.

I am not sure if this is a general pwm-sun4i issue or if it is related 
to the backlight. However I narrowed it down to one commit for 
pwm-sun4i:

fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5

If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on 
master, the backlight works fine. Unfortunately, due to my lack of 
kernel experience, I can't see how the commit above broke it.

Not sure if it helps, but the binding for the backlight is as follows:

backlight: backlight {
     compatible = "pwm-backlight";
     pwms = <&pwm 0 100000 PWM_POLARITY_INVERTED>;
     power-supply = <&reg_vbat>;
     enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
     brightness-levels = <0 30 40 50 60 70 80 90 100>;
     default-brightness-level = <8>;
};

Please let me know if there is anything else which might be helpful to 
know or anything I can test.

Regards,
Pascal
