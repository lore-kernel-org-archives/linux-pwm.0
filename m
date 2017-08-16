From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 0/7] Add rk3328 pwm support
Date: Wed, 16 Aug 2017 18:49:41 +0800
Message-ID: <89a895fd-d905-6a5b-c697-8e43ecc55e73@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

For the PWM patches, whether we let the first patch land in, that is PWM 
APB and function clocks are different in rk3328 and rv1108 SOCs. If the 
first patch was merged before 4.14, it will guarantee that the PWM is 
working, and the lock function you might review it later.

ÔÚ 2017/8/8 23:38, David Wu Ð´µÀ:
> There are two features of rk3328 pwm module.
>   - PWM APB and function clocks are different.
>   - Add pwm atomic hardware update
> 
> David Wu (7):
>    pwm: rockchip: Add APB and function both clocks support
>    pwm: rockchip: Remove the judge from return value of pwm_config
>    pwm: rockchip: Use pwm_apply instead of the pwm_enable
>    pwm: rockchip: Move the configuration of polarity from
>      rockchip_pwm_set_enable() to rockchip_pwm_config()
>    pwm: rockchip: Use same pwm ops for each IP
>    pwm: rockchip: Add rk3328 pwm support
>    arm64: dts: rockchip: Add pwm nodes for rk3328
> 
>   .../devicetree/bindings/pwm/pwm-rockchip.txt       |   8 +-
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
>   drivers/pwm/pwm-rockchip.c                         | 281 +++++++++++----------
>   3 files changed, 199 insertions(+), 135 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
