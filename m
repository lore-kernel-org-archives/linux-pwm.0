From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] backlight: pwm_bl: Fix brightness levels for non-DT
 case.
Date: Tue, 6 Nov 2018 21:53:09 +0100
Message-ID: <20181106205309.cyiar3rejr6ycunq@pengutronix.de>
References: <20181030103441.29145-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181030103441.29145-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, robert.jarzmik@free.fr, daniel.thompson@linaro.org, lee.jones@linaro.org, kernel@collabora.com, heiko@sntech.de, stable@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 30, 2018 at 11:34:41AM +0100, Enric Balletbo i Serra wrote:
> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
> 
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, it sets the max_brightness in their platform data and the
> driver calculates the level without a table. The ofending patch assumed

s/ofending/offending/

> hat when there is no brightness levels table we should create one, but this

s/hat/that/

> is clearly wrong for the non-DT case.
> 
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not.
> 
> Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'

These ' are unusual.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
