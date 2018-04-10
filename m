From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND PATCH v6 4/5] ARM: dts: rockchip: set PWM delay backlight settings for Veyron.
Date: Tue, 10 Apr 2018 15:04:06 +0200
Message-ID: <4925136.8dMFCuW7Px@phil>
References: <20180328170327.5395-1-enric.balletbo@collabora.com> <20180328170327.5395-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328170327.5395-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com
List-Id: linux-pwm@vger.kernel.org

Am Mittwoch, 28. März 2018, 19:03:26 CEST schrieb Enric Balletbo i Serra:
> For veyron the binding should provide both PWM timings, the delay between
> you enable the PWM and set the enable signal, and the delay between you
> disable the PWM signal and clear the enable signal. Update the binding
> accordingly, in this case the panels connected to the veyron boards have
> a symmetric power sequence, hence the same value is used.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

applied for 4.18

Thanks
Heiko
