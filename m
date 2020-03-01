From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V9 3/3] Input: new da7280 haptic driver
Date: Sun, 1 Mar 2020 22:20:25 +0100
Message-ID: <20200301212025.lw4f6uv453oulu22@pengutronix.de>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
 <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60147 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCAVUs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 1 Mar 2020 16:20:48 -0500
Content-Disposition: inline
In-Reply-To: <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hello Roy,

On Sat, Feb 29, 2020 at 12:59:20AM +0000, Roy Im wrote:
> Okay, thanks. I have tried to update that as below.
> Could I get your comment if you still see anything on this?
> 
> 	/* Maximum gain is 0x7fff for PWM mode */
> 	#define MAX_MAGNITUDE_SHIFT		15
>        [...]
> 	period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
> 
> 	/* The interpretation of duty cycle depends on the acc_en,
> 	* it should be from 50% to 100% for acc_en = 0.
> 	* See datasheet 'PWM mode' section for more details.
> 	*/
> 	if (!haptics->acc_en) {
> 		period_mag_multi += state.period;
> 		period_mag_multi /= 2;
> 	}

Much better. Extra points if you add a link to the datasheet at the
top of the driver. I didn't look at the datasheet and assume that the
reasoning is obvious then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
